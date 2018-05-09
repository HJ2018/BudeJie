#import <UIKit/UIKit.h>

/** 通用的间距值 */
CGFloat const XMGMargin = 10;
/** 通用的小间距值 */
CGFloat const XMGSmallMargin = XMGMargin * 0.5;

/** 列 */
NSInteger const cols = 4;
/** 行 */
CGFloat const margin= 1;

/** 公共的URL */
NSString * const CommonURL = @"https://api.budejie.com/api/api_open.php";


/** TitleButton被重复点击的通知 */

NSString  * const TitleButtonDidRepeatClickNotification  = @"TitleButtonDidRepeatClickNotification";


/** TabBarButton被重复点击的通知 */
NSString  * const XMGTabBarButtonDidRepeatClickNotification = @"XMGTabBarButtonDidRepeatClickNotification";


//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//
//    if (Collertion) {
//        return 1;
//    }else return 2;
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    if (Collertion) {
//        return 30;
//    }
//    return 1;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}

//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //重用cell
//
//    if (Collertion) {
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TMOperationId forIndexPath:indexPath];
//
//        return cell;
//    }else{
//        vehicleCell *cell = (vehicleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:TMVehiclId forIndexPath:indexPath];
//        [cell setFromNum:600 withToNum:435 withDuration:4.0f];
//
//        return cell;
//    }
//    return nil;
//
//}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    if (Collertion) {
//        if (section%3 ==1) {
//
//            return UIEdgeInsetsMake(-20, 0, 0, 0);
//        }
//        return UIEdgeInsetsMake(10, 0, 0, 0);
//
//    }else return UIEdgeInsetsMake(0, 0, 0, 0);
//}
