//
//  LBDeviceInfo.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "LBDeviceInfo.h"

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#include <ifaddrs.h>

@implementation LBDeviceInfo

+ (NSString *)getDeviceIPIpAddresses
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    if (sockfd > 0) return @"192.168.1.1";
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    
    NSString *deviceIP = @"192.168.1.1";
    for (int i=0; i < ips.count; i++){
        if (ips.count > 0){
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

+ (LBDeviceNetType) netType {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc] init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    return LBDeviceNetTypeNone;
                    //无网模式
                    break;
                case 1:
                    return LBDeviceNetType2G;
                    break;
                case 2:
                    return LBDeviceNetType3G;
                    break;
                case 3:
                    return LBDeviceNetType4G;
                    break;
                case 5:
                {
                    return LBDeviceNetTypeWifi;
                    break;
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    //根据状态选择
    return [state isEqualToString:@"WIFI"] ? YES : NO;
}

+ (NSString *)getNetworkFlowWithType:(LBDeviceNetworkFlowType)type{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1)
        
    {
        
        return nil;
    }
    
    uint32_t iBytes     = 0;
    
    uint32_t oBytes     = 0;
    
    uint32_t allFlow    = 0;
    
    uint32_t wifiIBytes = 0;
    
    uint32_t wifiOBytes = 0;
    
    uint32_t wifiFlow   = 0;
    
    uint32_t wwanIBytes = 0;
    
    uint32_t wwanOBytes = 0;
    
    uint32_t wwanFlow   = 0;
    
    struct IF_DATA_TIMEVAL time;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
        
    {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        // Not a loopback device.
        
        // network flow
        
        if (strncmp(ifa->ifa_name, "lo", 2))
            
        {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            allFlow = iBytes + oBytes;
            
            time = if_data->ifi_lastchange;
            
            // NSLog(@"1111===%s :iBytes is %d, oBytes is %d", ifa->ifa_name, iBytes, oBytes);
            
        }
        
        ///< style="font-family: Tahoma, Helvetica, Arial, 宋体, sans-serif; ">WIFI流量统计功能</span>
        
        if (!strcmp(ifa->ifa_name, "en0"))
            
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            wifiIBytes += if_data->ifi_ibytes;
            
            wifiOBytes += if_data->ifi_obytes;
            
            wifiFlow    = wifiIBytes + wifiOBytes;
            
        }
        
        ///< style="font-family: Tahoma, Helvetica, Arial, 宋体, sans-serif; ">3G和GPRS流量统计</span>
        
        if (!strcmp(ifa->ifa_name, "pdp_ip0"))
            
        {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            wwanIBytes += if_data->ifi_ibytes;
            
            wwanOBytes += if_data->ifi_obytes;
            
            wwanFlow    = wwanIBytes + wwanOBytes;
            
            //NSLog(@"111122===%s :iBytes is %d, oBytes is %d",  ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    
    
    NSString *changeTime=[NSString stringWithFormat:@"%s",ctime(&time)];
    
    NSLog(@"changeTime==%@",changeTime);
    
    switch (type) {
        case LBDeviceNetworkFlowTypeAll: {
            
            NSString *networkFlow      = [self bytesToAvaiUnit:allFlow];
            
            return networkFlow;
            break;
        }
            
        case LBDeviceNetworkFlowTypeAllReceived: {
            
            NSString *receivedBytes= [self bytesToAvaiUnit:iBytes];
            
            return receivedBytes;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeAllSend: {
            
            NSString *sentBytes       = [self bytesToAvaiUnit:oBytes];
            
            return sentBytes;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWIFITotal: {
            
            NSString *wifiBytes      = [self bytesToAvaiUnit:wifiFlow];
            
            return wifiBytes;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWIFIRecived: {
            
            NSString *wifiReceived   = [self bytesToAvaiUnit:wifiIBytes];
            
            return wifiReceived;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWIFISend: {
            
            NSString *wifiSent       = [self bytesToAvaiUnit: wifiOBytes];
            
            return wifiSent;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWWANTotal: {
            
            NSString *wwanBytes      = [self bytesToAvaiUnit:wwanFlow];
            
            return wwanBytes;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWWANRecived: {
            
            NSString *wwanReceived   = [self bytesToAvaiUnit:wwanIBytes];
            
            return wwanReceived;
            
            break;
        }
            
        case LBDeviceNetworkFlowTypeWWANSend: {
            
            NSString *wwanSent       = [self bytesToAvaiUnit:wwanOBytes];
            
            return wwanSent;
            
            break;
        }
        default:
            break;
    }
    
}

+ (NSString *)bytesToAvaiUnit:(int)bytes
{
    if(bytes < 1024)     // B
    {
        return [NSString stringWithFormat:@"%dB", bytes];
    }
    else if(bytes >= 1024 && bytes < 1024 * 1024) // KB
    {
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
    }
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)   // MB
    {
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
    }
    else    // GB
    {
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

+(NSArray *)appIconImageNames {

    return [[[NSBundle mainBundle] infoDictionary]valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"];
}

+(void)openSetting {

    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=Photos"]];
    }
}

+(void)sendSMSMessage:(NSString *)message delegete:(nonnull UIViewController<MFMessageComposeViewControllerDelegate> *)controller{

    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = controller;
        NSString *smsBody = message;
        picker.body= smsBody;
        if (picker && [picker isKindOfClass:UIViewController.class]) {
            [controller.navigationController?:controller presentViewController:picker animated:YES completion:nil];
            return;
        }
    }
    // Open the message app.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"短信功能不可用" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:NULL]];

    [controller presentViewController:alert animated:YES completion:NULL];
    
}

+(void)openSMSDelegate:(UIViewController *)controller {

    NSURL *smsURL = [NSURL URLWithString:@"sms://"];
    if ([[UIApplication sharedApplication] canOpenURL:smsURL]) {
        
        [[UIApplication sharedApplication] openURL:smsURL];
//        [[UIApplication sharedApplication] openURL:smsURL options:nil completionHandler:^(BOOL success) {
//            
//        }];
    } else {
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法打开短信App" preferredStyle:UIAlertControllerStyleAlert];
        [_alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:NULL]];
        [controller presentViewController:_alert animated:YES completion:NULL];
    }

}

@end
