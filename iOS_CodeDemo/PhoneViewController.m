//
//  PhoneViewController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/4/1.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "PhoneViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PhoneViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(50, 200, SCREEN_WIDTH - 100, 40);
    label.textColor = COLOR_RANDOM;
    label.numberOfLines = 0;
    label.text = @"点击页面进入系统联系人列表";
    label.font = [UIFont fontName_Zapfino_Size:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    NSLog(@"%@",self.navigationController.topViewController);
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self getIntoSystemPhoneBook];
}
//调用系统通讯录界面---------------------------
- (void)getIntoSystemPhoneBook{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 通讯录代理

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(nonnull ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    NSLog(@"%s",__func__);
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (firstName==nil) {
        firstName = @" ";
    }
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (lastName==nil) {
        lastName = @" ";
    }
    NSMutableArray *phones = [NSMutableArray array/*WithCapacity:0*/];
    for (int i = 0; i < ABMultiValueGetCount(valuesRef); i++) {
        NSString *aPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(valuesRef, i);
        [phones addObject:aPhone];
    }
    NSDictionary *dic = @{@"fullname": [NSString stringWithFormat:@"%@%@", firstName, lastName],
                          @"phone" : phones.count > 0 ? [phones lastObject] : @"读取失败"};
    NSArray *arr = [NSArray arrayWithObjects:@"qw",@"问",@"题", nil];
    NSLog(@"dic----->%@--%@",dic,arr);
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dis---->%@--%@",(__bridge NSString*)value,dic);
    }];
}
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
//    NSLog(@"%s",__func__);
//}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    NSLog(@"%s",__func__);
}















//----------------------------------------------------
//获取通讯录内容
- (void)getTelMessage{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion
        (addressBook, ^(bool granted, CFErrorRef error)
         {
             if (error)
                 NSLog(@"Error: %@", (__bridge NSError *)error);
             else if (!granted) {
                 UIAlertView *av = [[UIAlertView alloc]
                                    initWithTitle:@"Authorization Denied"
                                    message:@"Set permissions in  Settings>General>Privacy."
                                    delegate:nil
                                    cancelButtonTitle:nil
                                    otherButtonTitles:@"OK", nil];
                 [av show];
             }
             else
             {
                 //还原 ABAddressBookRef
                 ABAddressBookRevert(addressBook);
                 NSArray * myContacts = [NSArray arrayWithArray:
                                         (__bridge_transfer NSArray*)
                                         ABAddressBookCopyArrayOfAllPeople(addressBook)];
                 
                 NSLog(@"%@",myContacts);
             }
         });
    }else{
        ABAddressBookRevert(addressBook);
        NSArray * myContacts = [NSArray arrayWithArray:
                                (__bridge_transfer NSArray*)
                                ABAddressBookCopyArrayOfAllPeople(addressBook)];
        NSLog(@"%@",myContacts);
        [self handleRowSelection:0 byArray:myContacts];
    }
    
}
//取电话数据
-(void)handleRowSelection:(int)rowIndex byArray:(NSArray *)myContacts
{
//    __bridge CAST_USER_ADDR_T([myContacts objectAtIndex:rowIndex]);
    ABRecordRef person = (__bridge void*)([myContacts objectAtIndex:rowIndex]);
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    
    
    NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    NSLog(@"%@-----%@----%@",phoneNumbers,lastName,phone);
    for (int i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
        NSLog(@"%@",(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneNumbers, i)));
    }
    if (ABMultiValueGetCount(phoneNumbers) == 1){
        //        [self callThisNumber:(__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers, 0)];
        //        NSLog(@"%@---%@-----%@----%@",phoneNumbers,firstName,lastName,phone);
    }else if (ABMultiValueGetCount(phoneNumbers) > 1)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Pick A Number"
                                                     message:@"Which number would you like to call?"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:nil];
        
        for (int i=0; i < ABMultiValueGetCount(phoneNumbers); i++)
            [av addButtonWithTitle:(__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers, i)];
        
        [av show];
    }
    
    if (phoneNumbers)
        CFRelease(phoneNumbers);
}
//---------------------------------

@end
