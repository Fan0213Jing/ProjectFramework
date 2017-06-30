//
//  FJNetTool.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJNetTool.h"

NSString * const kHASREQUESTSURLKEY = @"kHASREQUESTSURLKEYURL";
NSString * const kHASREQUESTSPARAMSKEY = @"kHASREQUESTSPARAMSKEYParams";

@interface FJNetTool () {
    dispatch_semaphore_t _lock;
}
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSString * multiURL;

@property (nonatomic,strong) NSMutableArray * hasRequestedURLS;

@property (nonatomic,strong) NSArray * notNeedLoadings;

@end

@implementation FJNetTool

+ (instancetype)defaultManager {
    static FJNetTool * tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[FJNetTool alloc] init];
    });
    return tool;
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        _lock = dispatch_semaphore_create(1);
        
      
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/plain", @"application/json", @"text/json", @"text/javascript", @"text/html", @"image/png", nil];
        self.manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
         self.manager.requestSerializer.timeoutInterval = 10; // 请求时长
         self.manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        self.manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
        self.manager.securityPolicy.validatesDomainName = NO;//是否验证域名
        self.multiURL = HTTP;
        
   //     [self createLoadingBlackList];
        
    }
    return self;
}


- (void)getWithParams:(id)params url:(nonnull NSString *)url success:(compeletionHandle)success failure:(failureHandle)failure {
    
    [self getWithParams:params url:url progress:nil success:success failure:failure];
    
}

- (void)postWithParams:(id)params url:(NSString *)url success:(compeletionHandle)success failure:(failureHandle)failure {
    
    
    [self postWithParams:params url:url progress:nil success:success failure:failure];
}

- (void)getWithParams:(id)params url:(NSString *)url progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure {
    
    if (![self isNeedRequestWithURL:url params:params]) {
        
        
        !failure? :failure(nil,[[NSError alloc] initWithDomain:@"重复请求" code:905799827 userInfo:@{}]);
        return  ;
    }
    NSDictionary * dict = @{kHASREQUESTSURLKEY:url,kHASREQUESTSPARAMSKEY:params};
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [self.hasRequestedURLS addObject:dict];
        dispatch_semaphore_signal(_lock);
    }
    
    
    url = [self checkURL:url];
    
    NSLog(@"get URL : %@\n params:%@",url,params);
    params = [self addParams:params];
    
    
    //添加全局loding
    
  
    
    [self.manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if([self.hasRequestedURLS containsObject:dict]){
            dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
            [self.hasRequestedURLS removeObject:dict];
            dispatch_semaphore_signal(_lock);
        }
        if (success) {
            success(task,responseObject);
        }
        
        [self tocastWithResponseObject:responseObject with:url params:params];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        

        if([self.hasRequestedURLS containsObject:dict]){
            dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
            [self.hasRequestedURLS removeObject:dict];
            dispatch_semaphore_signal(_lock);
        }
        if (failure) {
            failure(task,error);
        }
    }];
    
}
- (void)postWithParams:(id)params url:(NSString *)url progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure {
    NSLog(@"post URL : %@\n params:%@",url,params);
    
    if (![self isNeedRequestWithURL:url params:params]) {
        
        !failure? :failure(nil,[[NSError alloc] initWithDomain:@"重复请求" code:905799827 userInfo:@{}]);
        return ;
    }
    
    NSDictionary * dict = @{kHASREQUESTSURLKEY:url,kHASREQUESTSPARAMSKEY:params};
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [self.hasRequestedURLS addObject:dict];
        dispatch_semaphore_signal(_lock);
    }
    url = [self checkURL:url];
    params = [self addParams:params];
    
    
    
    [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        if([self.hasRequestedURLS containsObject:dict]){
            dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
            [self.hasRequestedURLS removeObject:dict];
            dispatch_semaphore_signal(_lock);
        }
        
        if (success) {
            success(task,responseObject);
        }
        [self tocastWithResponseObject:responseObject with:url params:params];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
        if([self.hasRequestedURLS containsObject:dict]){
            dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
            [self.hasRequestedURLS removeObject:dict];
            dispatch_semaphore_signal(_lock);
        }
        
        if (failure) {
            failure(task,error);
        }
        
    }];
}

- (void)tocastWithResponseObject:(id)responseObject with:(NSString*)url params:(id)params {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSString *code = [responseObject objectForKey:@"errorcode"];
        
        if (code && ([code isEqualToString: CODE0]||[code isEqualToString: CODE3])) {
            NSString *msg = [responseObject objectForKey:@"msg"];
            if (msg && msg.length > 0) {
                UIView *view = [[UIApplication sharedApplication].delegate window];
                
                [view showHUDWithText:msg withYOffSet:0];
            }
        }
        #ifdef DEBUG
        if (![code isEqualToString:CODE0]) {
            NSLog(@"这个接口有问题 : %@\n params:%@===%@",url,params,code);
        }
#endif
    }
}

- (void)downloadWithURL:(NSString *)URL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    URL = [self checkURL:URL];
    //    params = [self addParams:params];
    NSURL *url = [NSURL URLWithString:URL];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载路径
        NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return [NSURL URLWithString:filepath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    
    [task resume];
    
}

- (void)uploadWithURL:(NSString *)URL withParams:(NSDictionary *)params withImage:(id)image name:(NSString *)name filename:(NSString *)filename progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure{
    
    
    URL = [self checkURL:URL];
    params = [self addParams:params];
    
    [self.manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:name fileName:filename mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
}

- (void)uploadWithURL:(NSString *)URL withParams:(NSDictionary *)params withFileAddress:(NSString *)fileaddress name:(NSString *)name filename:(NSString *)filename progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure {
    
    URL = [self checkURL:URL];
    params = [self addParams:params];
    
    [self.manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileaddress] name:name fileName:fileaddress mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
    
}

#pragma mark private methods
- (NSString *)checkURL:(NSString *)url{
    if ([url containsString:self.multiURL]) {
        
        return url;
    } else {
        
        url = [NSString stringWithFormat:@"%@%@",self.multiURL,url];
        
        return url;
    }
    
}

- (id)addParams:(id)params {
    
    if ([params isKindOfClass:[NSDictionary class]]) {
   //     NSString *device_id = [MXUUIDManager getUUID];
        NSString *os_v = [[UIDevice currentDevice] systemVersion];
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)params];
        
   //     [param setObject:device_id.md5 forKey:@"device_id"];
//        [param setObject:os_v forKey:@"os_v"];
//        [param setObject:@"ios" forKey:@"os_t"];
//        [param setObject:@"jupiter" forKey:@"os_app"];
        
   //     [param setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"app_v"];
        // 参数添加
        params = param;
    }
    
    return params;
    
}

/**
 *  判断是否需要进行这次请求
 *  判断URL 以及params。如果都一致 可认为是 同一个请求return掉
 *  @return 是否需要继续
 */
- (BOOL)isNeedRequestWithURL:(NSString *)URL params:(id)params{
    
    return YES;
    
    if (self.hasRequestedURLS.count <= 0) {
        return YES;
    }
    
    if (self.hasRequestedURLS.count > 10) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [self.hasRequestedURLS removeObjectAtIndex:0];
        dispatch_semaphore_signal(_lock);
    }
    
    NSArray * reserA = [[self.hasRequestedURLS reverseObjectEnumerator] allObjects];
    
    
    for (NSDictionary * dict in reserA) {
        
        NSString * urll = dict[kHASREQUESTSURLKEY];
        NSDictionary * paramss = dict[kHASREQUESTSPARAMSKEY];
        
        
        if([urll isEqualToString:URL]){
            //比较两个字典是否一致
            return ![params isEqualToDictionary:paramss];
            
        } else {
            return YES;
        }
        
        
    }
    
    return YES;
    
}
//+ (NSString *)rsaWithParam:(NSDictionary *)dict {
//    NSData *paramData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dictStr = [[NSString alloc] initWithData:paramData encoding:NSUTF8StringEncoding];
//    RSAEncrypt *rsaEncrypt = [[RSAEncrypt alloc] init];
//    return [rsaEncrypt encryptToString:dictStr];
//}
//
//+ (NSString *)aesWithParam:(NSDictionary *)dict {
//    NSData *paramData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    //    paramData = [[CJSONSerializer serializer] serializeObject:dict error:nil];
//    NSString *key = [AppSetting appsetting].AESKey;
//    NSString *iv = [AppSetting appsetting].AESIV;
//    if (!key || !iv) {
//        return nil;
//    }
//    NSData *encryptedData = [paramData AES128EncryptWithKey:key iv:iv];
//    
//    NSString *result = [NSString base64forData:encryptedData];
//    return result;
//}
#pragma mark -- getter

- (NSMutableArray *)hasRequestedURLS {
    
    if (!_hasRequestedURLS) {
        _hasRequestedURLS = [NSMutableArray array];
    }
    return _hasRequestedURLS;
}


/**
 添加不需要加loading的黑名单,
 */
- (void)createLoadingBlackList {
 //   self.notNeedLoadings = @[LIVEGIFTLIST,LIVE_MULTISENDGIFTSTART,LIVE_MULTISENDGIFTED,LIVE_SENDGIFT,LIVE_HEARTBEAT,LIVESHAREINFO,LIVE_ANCHORDETAIL,LIVE_WATCHERDETAIL,LIVE_SENDREDENVELOPE,LIVE_OPENREDENVELOPE,LIVE_FANSLIST,Coupon_livecouponinfo,LIVE_KICKOFF,DIAMONDMYBALANCE];
    
    
}

@end

