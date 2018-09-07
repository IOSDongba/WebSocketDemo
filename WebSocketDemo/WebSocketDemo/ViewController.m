//
//  ViewController.m
//  WebSocketDemo
//
//  Created by 孙俊 on 17/2/16.
//  Copyright © 2017年 newbike. All rights reserved.
//

#import "ViewController.h"
#import "SocketRocketUtility.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hostField;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgField;
@property (weak, nonatomic) IBOutlet UITextView *receiveView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sendMsgField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.hostField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessageNote object:nil];

    
//    [[SocketRocketUtility instance] SRWebSocketClose]; 在需要得地方 关闭socket
    
}


- (IBAction)connetServer:(UIButton *)sender {
    [[SocketRocketUtility instance] SRWebSocketOpenWithURLString:self.hostField.text];
}

- (IBAction)sendMsg:(UIButton *)sender {
    [[SocketRocketUtility instance] sendData:self.sendMsgField.text];
}


- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    //在成功后需要做的操作。。。
        
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    
    if (![message isEqualToString:@"heart"]) {
        self.receiveView.text = [NSString stringWithFormat:@"%@\n%@",self.receiveView.text,message];
        
        //    NSLog(@"receiveView.conttentsize.height::::%lf",self.receiveView.contentSize.height);
        self.receiveView.contentOffset = CGPointMake(0, self.receiveView.contentSize.height - self.receiveView.frame.size.height < 0 ? 0 : self.receiveView.contentSize.height - self.receiveView.frame.size.height);
    }
    

    
    
}

@end
