//
//  HJTopic.h
//  MrHuang
//
//  Created by MrHuang on 16/9/6.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger , TopicType) {
    
    /* 全部 */
    TopicTypeAll = 1,
    
    /* 图片 */
    TopicTypePicture = 10,
    
    /* 段子 */
    TopicTypeWWord = 29,
    
    /* 声音 */
    TopicTypeVoice = 31,
    
    /* 视频 */
    TopicTypeVideo = 41,
    
};

@interface HJTopic : NSObject


/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
//帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) NSInteger type;
//最热评论
@property (nonatomic,strong) NSArray *top_cmt;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;

/** 额外添加的属性 不是服务器返回的 根据当前模型计算高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 额外添加的属性,计算中图片的frame */
@property (nonatomic, assign) CGRect middleFrame;

@end
