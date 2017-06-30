//
//  FJNetTool.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^compeletionHandle)(NSURLSessionDataTask * task, id responseObject);
typedef void (^failureHandle)(NSURLSessionDataTask * task, NSError * error);
typedef void (^progressHandle)(NSProgress *progress);

@interface FJNetTool : NSObject

+ (instancetype)defaultManager;

/**
 *  post 请求
 *
 *  @param params  参数
 *  @param url     url 地址
 *  @param success 成功请求回掉
 *  @param failure 失败请求回掉
 */
- (void)postWithParams:(id)params url:(NSString *)url success:(compeletionHandle)success failure:(failureHandle)failure;

/**
 *  get 请求
 *
 *  @param params  参数
 *  @param url     url地址
 *  @param success 成功请求回掉
 *  @param failure 失败请求回掉
 */
- (void)getWithParams:(id)params url:(NSString *)url success:(compeletionHandle)success failure:(failureHandle)failure;


/**
 *  post 请求
 *
 *  @param params  参数
 *  @param url     url 地址
 *  @param progress 需要的请求进度回掉
 *  @param success 成功请求回掉
 *  @param failure 失败请求回掉
 */
- (void)postWithParams:(id)params url:(NSString *)url progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure;

/**
 *  get 请求
 *
 *  @param params  参数
 *  @param url     url 地址
 *  @param progress 需要的请求进度回掉
 *  @param success 成功请求回掉
 *  @param failure 失败请求回掉
 */
- (void)getWithParams:(id)params url:(NSString *)url progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure;
/**
 *  从url位置下载
 *
 *  @param URL 下载url
 */
- (void)downloadWithURL:(NSString *)URL;

/**
 *  上传 图片
 *
 *  @param URL      url
 *  @param params   参数
 *  @param image    图片
 *  @param name     图片
 *  @param filename 服务器文件存储名字
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败2
 */
- (void)uploadWithURL:(NSString *)URL withParams:(NSDictionary *)params withImage:(UIImage *)image name:(NSString *)name filename:(NSString *)filename progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure;

/**
 *  上传 文件
 *
 *  @param URL      url
 *  @param params   参数
 *  @param image    图片
 *  @param name     图片
 *  @param filename 服务器文件存储名字
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败2
 */
- (void)uploadWithURL:(NSString *)URL withParams:(NSDictionary *)params withFileAddress:(NSString *)fileaddress name:(NSString *)name filename:(NSString *)filename progress:(progressHandle)progress success:(compeletionHandle)success failure:(failureHandle)failure;


//+ (NSString *)rsaWithParam:(NSDictionary *)dict;
//
//+ (NSString *)aesWithParam:(NSDictionary *)dict;






@end
