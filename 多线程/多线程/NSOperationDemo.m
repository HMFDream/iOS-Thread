//
//  ViewController(NSOperation).m
//  多线程
//
//  Created by 黄梦妃 on 16/9/22.
//  Copyright © 2016年 黄梦妃. All rights reserved.
//
/**
 *  NSOperation,NSBlockOperation,NSInvocationOperation,NSOperationQueue使用方法
 *
 */
#import "NSOperationDemo.h"

@interface NSOperationDemo ()
@property(strong,nonatomic)NSBlockOperation *blockOperation;
@property(strong,nonatomic)NSInvocationOperation *invocationOperation;
@property(strong,nonatomic)NSOperationQueue *operationQueue;
@end

@implementation NSOperationDemo

/**
 *  NSBlockOperation 并发执行加入其中的Block
    可能开启新线程也可能在当前线程执行
 */
- (void)useBlockOperation{
    //创建
    _blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"0 %s---%@",__func__,[NSThread currentThread]);
    }];
    
    //添加需要执行的block
    [_blockOperation addExecutionBlock:^{
        NSLog(@"1 %s---%@",__func__,[NSThread currentThread]);
    }];
    
    [_blockOperation addExecutionBlock:^{
        NSLog(@"2 %s---%@",__func__,[NSThread currentThread]);
    }];
    
    [_blockOperation addExecutionBlock:^{
        NSLog(@"3 %s---%@",__func__,[NSThread currentThread]);
    }];
    
    //执行Block，执行的时候或者执行完成之后不可以在添加Block
    [_blockOperation start];
    
    NSLog(@"%@",[_blockOperation executionBlocks]);
    
//    2016-09-22 11:35:18.655 多线程[5436:1116561] 0 __36-[NSOperationDemo useBlockOperation]_block_invoke---<NSThread: 0x7fae2a502820>{number = 1, name = main}
//    2016-09-22 11:35:18.660 多线程[5436:1116561] 1 __36-[NSOperationDemo useBlockOperation]_block_invoke_2---<NSThread: 0x7fae2a502820>{number = 1, name = main}
//    2016-09-22 11:35:18.661 多线程[5436:1116561] 2 __36-[NSOperationDemo useBlockOperation]_block_invoke_3---<NSThread: 0x7fae2a502820>{number = 1, name = main}
//    2016-09-22 11:35:18.662 多线程[5436:1116593] 3 __36-[NSOperationDemo useBlockOperation]_block_invoke_4---<NSThread: 0x7fae2a683b10>{number = 2, name = (null)}
//    2016-09-22 11:35:18.663 多线程[5436:1116561] (
//                                               "<__NSGlobalBlock__: 0x102059040>",
//                                               "<__NSGlobalBlock__: 0x102059080>",
//                                               "<__NSGlobalBlock__: 0x1020590c0>",
//                                               "<__NSGlobalBlock__: 0x102059100>"
//                                               )
//
//    
}

/**
 *  NSInvocationOperation 同步执行，小心阻塞主线程
 */
- (void)useInvocationOperation{
    //创建一个NSInvocationOperation对象，如果run方法没有实现，这个返回nil
    _invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //任务完成之后执行的回调
    [_invocationOperation setCompletionBlock:^{
        NSLog(@"OK");
    }];
    // 开始执行任务(同步执行)
    [_invocationOperation start];
    
    NSLog(@"aaa");
    //result：任务执行之后的结果
    //如果没有result会抛出异常NSInvocationOperationVoidResultException
    NSLog(@"%@",[_invocationOperation result]);
    
    
}

- (int)run{
    NSLog(@"run--%@",[NSThread currentThread]);
    sleep(2);
    return 1;
}

/**
 *  把NSOperation子类的对象放入NSOperationQueue队列中，该队列就会启动并开始处理它。
 */
- (void)useOperationQueue{
    //NSOperationQueue是同步执行还是异步执行？
    //根据设置的并发数，如果为1，则为同步执行。
    //系统自己控制是否新创建线程执行。
    //可以根据需求，来改变队列中任务的优先级
    //TODO:
    
    _operationQueue  = [[NSOperationQueue alloc] init];
    NSBlockOperation * bkOp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bkOp1.....handle.....on thread num%@",[NSThread currentThread]);
        sleep(10);
    }];
    
    [bkOp1 setCompletionBlock:^{
        NSLog(@"bkOp1........OK !!");
    }];
    
    
    NSBlockOperation * bkOp2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"bkOp2.....handle.....on thread num%@",[NSThread currentThread]);
        sleep(2);
    }];
    [bkOp2 setCompletionBlock:^{
        NSLog(@"bkOp2........OK !!");
    }];
    
    NSBlockOperation * bkOp3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bkOp3.....handle.....on thread num%@",[NSThread currentThread]);
        sleep(1);
    }];
    [bkOp3 setCompletionBlock:^{
        NSLog(@"bkOp3........OK !!");
    }];
    
    NSBlockOperation * bkOp4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bkOp4.....handle.....on thread num%@",[NSThread currentThread]);
         sleep(10);
    }];
    [bkOp4 setCompletionBlock:^{
        NSLog(@"bkOp4........OK !!");
    }];
    
    NSBlockOperation * bkOp5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bkOp5.....handle.....on thread num%@",[NSThread currentThread]);
        sleep(5);
    }];
//    [bkOp5 setQueuePriority:NSOperationQueuePriorityHigh];
    [bkOp5 setCompletionBlock:^{
        NSLog(@"bkOp5........OK !!");
    }];
    NSInvocationOperation *invoOp6 = [[NSInvocationOperation alloc] initWithTarget:(id)self selector:@selector(run) object:nil];
    [invoOp6 setCompletionBlock:^{
        NSLog(@"invoOp6........OK !!");
    }];
    
    NSInvocationOperation *invoOp7 = [[NSInvocationOperation alloc] initWithTarget:(id)self selector:@selector(run) object:nil];
    [invoOp7 setCompletionBlock:^{
        NSLog(@"invoOp7........OK !!");
    }];
//    [invoOp7 setQueuePriority:NSOperationQueuePriorityHigh];
    //设置为1，所有任务同步执行。
    [_operationQueue setMaxConcurrentOperationCount:2];
    [_operationQueue addOperation:bkOp3];
    [_operationQueue addOperation:bkOp2];
    [_operationQueue addOperation:bkOp1];
    [_operationQueue addOperation:bkOp4];
    [_operationQueue addOperation:bkOp5];
    [_operationQueue addOperation:invoOp6];
    [_operationQueue addOperation:invoOp7];
}

/**
 *  为操作添加依赖
 */
- (void)operationAddDependency{
    
    __block int a = 1;
    
    NSBlockOperation *b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%d",++a);
        sleep(5);
    }];
    
    NSBlockOperation *c = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%d",++a);
    }];
    
    [c addDependency:b];
    
    NSOperationQueue *queue = [NSOperationQueue new];
//    [queue setMaxConcurrentOperationCount:2];
    [queue addOperation:b];
    [queue addOperation:c];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"NSOperation";
    
    [self operationAddDependency];
}



@end
