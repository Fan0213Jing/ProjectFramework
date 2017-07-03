//
//  FJReceivedMemoryWarningManager.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJReceivedMemoryWarningManager.h"

@implementation FJReceivedMemoryWarningManager
+ (instancetype)sharedInstance {
    static FJReceivedMemoryWarningManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FJReceivedMemoryWarningManager alloc] init];
    });
    return manager;
}

- (NSString *)currentCacheSize {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [self folderSizeAtPath :cachePath];
    
}
// 遍历文件夹获得文件夹大小，返回多少 M
- ( NSString * ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    // 这个是SDWebImageManager的缓存的,没有引用这个第三方类库不用加
    folderSize += [SDWebImageManager sharedManager].imageCache.getSize;
    
    CGFloat size = folderSize/(1024.0*1024.0);
    
    NSString *cacheStrc = size >= 1.0? [NSString stringWithFormat:@"%.2fM", size] : [NSString stringWithFormat:@"%.2fKB", size * 1024.0];

    return cacheStrc;
    
}



// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}




- (void)clearCache
{
    NSString * path = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    // 这个是清除SDWebImageManager的缓存的,没有引用这个第三方类库不用写
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    
    
}



@end
