//
//  RowTracker.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/27/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef RowTracker_h
#define RowTracker_h

@interface RowTracker:NSObject
@property(nonatomic, readonly, copy)NSArray* allRows;
+(instancetype)sharedRows;
-(void)addRows:(NSInteger) val;
-(void)rowTap:(NSInteger) row;
-(void)clearRows;
-(int)length;
@end


#endif /* RowTracker_h */
