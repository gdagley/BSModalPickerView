//
//  BSModalPickerView.m
//  CustomPicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSModalPickerView.h"

@interface BSModalPickerView ()

@property (nonatomic) NSUInteger indexSelectedBeforeDismissal;

@end

@implementation BSModalPickerView

- (id)initWithValues:(NSArray *)values {
    self = [super init];
    if (self) {
        self.values = values;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setValues:(NSArray *)values {
    _values = values;
    
    if (values) {
        if (self.picker) {
            UIPickerView *pickerView = (UIPickerView *)self.picker;
            [pickerView reloadAllComponents];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (self.picker) {
        UIPickerView *pickerView = (UIPickerView *)self.picker;
        [pickerView selectRow:selectedIndex inComponent:0 animated:YES];
    }
}

- (void)setSelectedValue:(NSString *)selectedValue {
    NSInteger index = [self.values indexOfObject:selectedValue];
    [self setSelectedIndex:index];
}

- (NSString *)selectedValue {
    return [self.values objectAtIndex:self.selectedIndex];
}

- (void)onDone:(id)sender {
    self.selectedIndex = self.indexSelectedBeforeDismissal;
    [super onDone:sender];
}

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    [pickerView selectRow:self.selectedIndex inComponent:0 animated:NO];
    return pickerView;
}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.indexSelectedBeforeDismissal = row;
}

@end