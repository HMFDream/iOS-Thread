//
//  ViewController.m
//  多线程
//
//  Created by 黄梦妃 on 16/9/19.
//  Copyright © 2016年 黄梦妃. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)dispatch_queue_t mainQueue;
@property(strong,nonatomic)dispatch_queue_t globalQueue;
@property(strong,nonatomic)dispatch_queue_t serialQueue;
@end

@implementation ViewController


- (void)initQueue{
    _mainQueue = dispatch_get_main_queue();
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);

}

/**
 *  1.主队列不能添加同步任务
    2.主队列的任务只会在主线程中执行
    3.主队列即使添加多个异步任务也只会串行执行
 */
-(void)someAsyncTaskInMainQueue{
    dispatch_async(_mainQueue, ^{
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
    });
    dispatch_async(_mainQueue, ^{
        sleep(2);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        
    });
    dispatch_async(_mainQueue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(_mainQueue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:33:49.275 多线程[4125:895544] 0----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:49.276 多线程[4125:895544] 0----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:49.276 多线程[4125:895544] 0----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.277 多线程[4125:895544] 1----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.277 多线程[4125:895544] 1----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.277 多线程[4125:895544] 1----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 2----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 2----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 2----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 3----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 3----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
//    2016-09-21 15:33:51.278 多线程[4125:895544] 3----<NSThread: 0x7ffb987012d0>{number = 1, name = main}
}

/**
 *  串行队列执行多个异步任务，创建一个新线程，队列中的任务以串行的方式执行
 */
-(void)someAsyncTaskInSerialQueue{
    dispatch_async(_serialQueue, ^{
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
    });
    dispatch_async(_serialQueue, ^{
        sleep(2);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(_serialQueue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(_serialQueue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:35:46.156 多线程[4142:897395] 0----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:46.156 多线程[4142:897395] 0----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:46.157 多线程[4142:897395] 0----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.160 多线程[4142:897395] 1----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.161 多线程[4142:897395] 1----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.161 多线程[4142:897395] 1----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.161 多线程[4142:897395] 2----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.162 多线程[4142:897395] 2----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.162 多线程[4142:897395] 2----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.162 多线程[4142:897395] 3----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.163 多线程[4142:897395] 3----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
//    2016-09-21 15:35:48.163 多线程[4142:897395] 3----<NSThread: 0x7fa162740f30>{number = 2, name = (null)}
}

/**
 *  串行队列执行多个同步任务，当前线程(即主线程)中执行，队列中的任务以串行的方式执行
 */
-(void)someSyncTaskInSerialQueue{
    dispatch_sync(_serialQueue, ^{
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
    });
    dispatch_sync(_serialQueue, ^{
        sleep(2);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_sync(_serialQueue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_sync(_serialQueue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:37:03.399 多线程[4150:898536] 0----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:03.400 多线程[4150:898536] 0----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:03.400 多线程[4150:898536] 0----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.401 多线程[4150:898536] 1----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.401 多线程[4150:898536] 1----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.402 多线程[4150:898536] 1----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.402 多线程[4150:898536] 2----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.402 多线程[4150:898536] 2----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.402 多线程[4150:898536] 2----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.403 多线程[4150:898536] 3----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.403 多线程[4150:898536] 3----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
//    2016-09-21 15:37:05.403 多线程[4150:898536] 3----<NSThread: 0x7f91b3506be0>{number = 1, name = main}
}

/**
 *  串行队列执行多个任务(包括同步与异步)，同步任务在当前线程(即主线程)中串行执行，异步任务在一个新的线程中串行执行
 */
-(void)someTaskInSerialQueue{
    
    dispatch_async(_serialQueue, ^{
        NSLog(@"async 0----%@",[NSThread currentThread]);
        NSLog(@"async 0----%@",[NSThread currentThread]);
        NSLog(@"async 0----%@",[NSThread currentThread]);
    });
    dispatch_async(_serialQueue, ^{
        sleep(2);
        NSLog(@"async 1----%@",[NSThread currentThread]);
        NSLog(@"async 1----%@",[NSThread currentThread]);
        NSLog(@"async 1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(_serialQueue, ^{
        NSLog(@"sync 0----%@",[NSThread currentThread]);
        NSLog(@"sync 0----%@",[NSThread currentThread]);
        NSLog(@"sync 0----%@",[NSThread currentThread]);
    });
    dispatch_sync(_serialQueue, ^{
        sleep(2);
        NSLog(@"sync 1----%@",[NSThread currentThread]);
        NSLog(@"sync 1----%@",[NSThread currentThread]);
        NSLog(@"sync 1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(_serialQueue, ^{
        NSLog(@"sync 2----%@",[NSThread currentThread]);
        NSLog(@"sync 2----%@",[NSThread currentThread]);
        NSLog(@"sync 2----%@",[NSThread currentThread]);
    });
    dispatch_sync(_serialQueue, ^{
        NSLog(@"sync 3----%@",[NSThread currentThread]);
        NSLog(@"sync 3----%@",[NSThread currentThread]);
        NSLog(@"sync 3----%@",[NSThread currentThread]);
    });
    
    dispatch_async(_serialQueue, ^{
        NSLog(@"async 2----%@",[NSThread currentThread]);
        NSLog(@"async 2----%@",[NSThread currentThread]);
        NSLog(@"async 2----%@",[NSThread currentThread]);
    });
    dispatch_async(_serialQueue, ^{
        NSLog(@"async 3----%@",[NSThread currentThread]);
        NSLog(@"async 3----%@",[NSThread currentThread]);
        NSLog(@"async 3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:39:02.152 多线程[4165:899798] async 0----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:02.153 多线程[4165:899798] async 0----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:02.153 多线程[4165:899798] async 0----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:04.156 多线程[4165:899798] async 1----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:04.157 多线程[4165:899798] async 1----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:04.157 多线程[4165:899798] async 1----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:04.157 多线程[4165:899754] sync 0----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:04.158 多线程[4165:899754] sync 0----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:04.158 多线程[4165:899754] sync 0----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.160 多线程[4165:899754] sync 1----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.160 多线程[4165:899754] sync 1----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.161 多线程[4165:899754] sync 1----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.161 多线程[4165:899754] sync 2----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.161 多线程[4165:899754] sync 2----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.161 多线程[4165:899754] sync 2----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.162 多线程[4165:899754] sync 3----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.162 多线程[4165:899754] sync 3----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.162 多线程[4165:899754] sync 3----<NSThread: 0x7fd592501c70>{number = 1, name = main}
//    2016-09-21 15:39:06.163 多线程[4165:899798] async 2----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:06.163 多线程[4165:899798] async 2----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:06.163 多线程[4165:899798] async 2----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:06.164 多线程[4165:899798] async 3----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:06.164 多线程[4165:899798] async 3----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
//    2016-09-21 15:39:06.164 多线程[4165:899798] async 3----<NSThread: 0x7fd59270e6b0>{number = 2, name = (null)}
}

/**
 *  并发队列执行多个同步任务，当前线程(即主线程)中执行，队列中的任务以串行的方式执行
 */
-(void)someSyncTaskInGlobalQueue{
    dispatch_sync(_globalQueue, ^{
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        sleep(7);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:40:27.752 多线程[4175:901062] 0----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:27.753 多线程[4175:901062] 0----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:27.753 多线程[4175:901062] 0----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.754 多线程[4175:901062] 1----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.755 多线程[4175:901062] 1----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.755 多线程[4175:901062] 1----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.755 多线程[4175:901062] 2----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.755 多线程[4175:901062] 2----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.756 多线程[4175:901062] 2----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.756 多线程[4175:901062] 3----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.756 多线程[4175:901062] 3----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
//    2016-09-21 15:40:34.756 多线程[4175:901062] 3----<NSThread: 0x7fc6c2406e40>{number = 1, name = main}
}

/**
 *  并发队列执行多个异步任务，创建多个线程执行任务
 */
-(void)someAsyncTaskInGlobalQueue{
    dispatch_async(_globalQueue, ^{
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
        NSLog(@"0----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        sleep(7);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:41:48.328 多线程[4183:902345] 3----<NSThread: 0x7ffd7ae42cc0>{number = 4, name = (null)}
//    2016-09-21 15:41:48.328 多线程[4183:902344] 2----<NSThread: 0x7ffd7ad035d0>{number = 3, name = (null)}
//    2016-09-21 15:41:48.328 多线程[4183:902327] 0----<NSThread: 0x7ffd7acc7400>{number = 2, name = (null)}
//    2016-09-21 15:41:48.329 多线程[4183:902327] 0----<NSThread: 0x7ffd7acc7400>{number = 2, name = (null)}
//    2016-09-21 15:41:48.329 多线程[4183:902345] 3----<NSThread: 0x7ffd7ae42cc0>{number = 4, name = (null)}
//    2016-09-21 15:41:48.329 多线程[4183:902344] 2----<NSThread: 0x7ffd7ad035d0>{number = 3, name = (null)}
//    2016-09-21 15:41:48.329 多线程[4183:902327] 0----<NSThread: 0x7ffd7acc7400>{number = 2, name = (null)}
//    2016-09-21 15:41:48.329 多线程[4183:902345] 3----<NSThread: 0x7ffd7ae42cc0>{number = 4, name = (null)}
//    2016-09-21 15:41:48.330 多线程[4183:902344] 2----<NSThread: 0x7ffd7ad035d0>{number = 3, name = (null)}
//    2016-09-21 15:41:55.332 多线程[4183:902332] 1----<NSThread: 0x7ffd7acb67f0>{number = 5, name = (null)}
//    2016-09-21 15:41:55.332 多线程[4183:902332] 1----<NSThread: 0x7ffd7acb67f0>{number = 5, name = (null)}
//    2016-09-21 15:41:55.333 多线程[4183:902332] 1----<NSThread: 0x7ffd7acb67f0>{number = 5, name = (null)}
}

/**
 *  并发队列执行多个任务(包括同步与异步),同步任务在当前线程(即主线程)中串行执行，异步任务创建多个新的线程执行
 */
-(void)someTaskInGlobalQueue{
    dispatch_async(_globalQueue, ^{
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        sleep(2);
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        NSLog(@"sync0----%@",[NSThread currentThread]);
        NSLog(@"sync0----%@",[NSThread currentThread]);
        NSLog(@"sync0----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        sleep(2);
        NSLog(@"sync1----%@",[NSThread currentThread]);
        NSLog(@"sync1----%@",[NSThread currentThread]);
        NSLog(@"sync1----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        sleep(2);
        NSLog(@"sync2----%@",[NSThread currentThread]);
        NSLog(@"sync2----%@",[NSThread currentThread]);
        NSLog(@"sync2----%@",[NSThread currentThread]);
    });
    dispatch_sync(_globalQueue, ^{
        NSLog(@"sync3----%@",[NSThread currentThread]);
        NSLog(@"sync3----%@",[NSThread currentThread]);
        NSLog(@"sync3----%@",[NSThread currentThread]);
    });
//    2016-09-21 15:43:24.116 多线程[4191:903342] sync0----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:24.119 多线程[4191:903385] async0----<NSThread: 0x7f9828e262d0>{number = 2, name = (null)}
//    2016-09-21 15:43:24.119 多线程[4191:903390] async2----<NSThread: 0x7f9828e1c650>{number = 3, name = (null)}
//    2016-09-21 15:43:24.119 多线程[4191:903458] async3----<NSThread: 0x7f9828e1e120>{number = 4, name = (null)}
//    2016-09-21 15:43:24.121 多线程[4191:903342] sync0----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:24.121 多线程[4191:903390] async2----<NSThread: 0x7f9828e1c650>{number = 3, name = (null)}
//    2016-09-21 15:43:24.121 多线程[4191:903342] sync0----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:24.121 多线程[4191:903458] async3----<NSThread: 0x7f9828e1e120>{number = 4, name = (null)}
//    2016-09-21 15:43:24.121 多线程[4191:903385] async0----<NSThread: 0x7f9828e262d0>{number = 2, name = (null)}
//    2016-09-21 15:43:24.122 多线程[4191:903390] async2----<NSThread: 0x7f9828e1c650>{number = 3, name = (null)}
//    2016-09-21 15:43:24.123 多线程[4191:903458] async3----<NSThread: 0x7f9828e1e120>{number = 4, name = (null)}
//    2016-09-21 15:43:24.123 多线程[4191:903385] async0----<NSThread: 0x7f9828e262d0>{number = 2, name = (null)}
//    2016-09-21 15:43:26.123 多线程[4191:903342] sync1----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:26.123 多线程[4191:903377] async1----<NSThread: 0x7f9828d01860>{number = 5, name = (null)}
//    2016-09-21 15:43:26.124 多线程[4191:903342] sync1----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:26.124 多线程[4191:903342] sync1----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:26.124 多线程[4191:903377] async1----<NSThread: 0x7f9828d01860>{number = 5, name = (null)}
//    2016-09-21 15:43:26.124 多线程[4191:903377] async1----<NSThread: 0x7f9828d01860>{number = 5, name = (null)}
//    2016-09-21 15:43:28.125 多线程[4191:903342] sync2----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:28.125 多线程[4191:903342] sync2----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:28.125 多线程[4191:903342] sync2----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:28.126 多线程[4191:903342] sync3----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:28.126 多线程[4191:903342] sync3----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
//    2016-09-21 15:43:28.126 多线程[4191:903342] sync3----<NSThread: 0x7f9828d012b0>{number = 1, name = main}
}

/**
 *  延时执行
 */
-(void)dispatchAfter{
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    NSLog(@"dispatch_after");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%s",__func__);
    });
}

/**
 *  线程组的使用
 */
-(void)dispatchGroup{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_t group1 = dispatch_group_create();
    dispatch_group_async(group, _globalQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, _globalQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, _globalQueue, ^{
        NSLog(@"3");
    });
    //notify监听线程组是否执行完成
    dispatch_group_notify(group, _globalQueue, ^{
        dispatch_group_async(group1, _globalQueue, ^{
            NSLog(@"11");
        });
        dispatch_group_async(group1, _globalQueue, ^{
            NSLog(@"21");
        });
        dispatch_group_async(group1, _globalQueue, ^{
            NSLog(@"31");
        });
    });
    
}


/**
 *  隔断函数
 1.通过dispatch_barrier_async函数提交的任务会等它前面的任务执行完才开始，然后它后面的任务必须等它执行完毕才能开始.
 2.必须使用dispatch_queue_create创建的队列才会达到上面的效果,串行队列或者全局并发队列无效相当于
 （dispatch_barrier_async==dispatch_async）
（dispatch_barrier_sync==dispatch_sync）
 
 dispatch_barrier_sync 相当于加了一个断点，之后的程序都不会执行
 dispatch_barrier_async 只是对队列中的任务起断点作用，不是队列中的任务照常执行
 */
-(void)barrierSyncTask{
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
    });
    dispatch_barrier_sync(queue, ^{
        sleep(3);
        NSLog(@"barrier sync0----%@",[NSThread currentThread]);
        NSLog(@"barrier sync0----%@",[NSThread currentThread]);
        NSLog(@"barrier sync0----%@",[NSThread currentThread]);
    });
    NSLog(@"aaa");
    dispatch_async(queue, ^{
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
    });
    NSLog(@"bbb");
    dispatch_async(queue, ^{
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
    });
    // aaa,bbb 一定会在barrier sync0之后输出
//    2016-09-21 17:39:06.158 多线程[4644:974682] async1----<NSThread: 0x7fc0aae28420>{number = 2, name = (null)}
//    2016-09-21 17:39:06.158 多线程[4644:974672] async0----<NSThread: 0x7fc0aaf0be40>{number = 3, name = (null)}
//    2016-09-21 17:39:06.158 多线程[4644:974682] async1----<NSThread: 0x7fc0aae28420>{number = 2, name = (null)}
//    2016-09-21 17:39:09.159 多线程[4644:974632] barrier sync0----<NSThread: 0x7fc0aac07f20>{number = 1, name = main}
//    2016-09-21 17:39:09.160 多线程[4644:974632] barrier sync0----<NSThread: 0x7fc0aac07f20>{number = 1, name = main}
//    2016-09-21 17:39:09.160 多线程[4644:974632] barrier sync0----<NSThread: 0x7fc0aac07f20>{number = 1, name = main}
//    2016-09-21 17:39:09.160 多线程[4644:974632] aaa
//    2016-09-21 17:39:09.160 多线程[4644:974632] bbb
//    2016-09-21 17:39:09.160 多线程[4644:974672] async2----<NSThread: 0x7fc0aaf0be40>{number = 3, name = (null)}
//    2016-09-21 17:39:09.161 多线程[4644:974682] async3----<NSThread: 0x7fc0aae28420>{number = 2, name = (null)}
}

-(void)barrierAsyncTask{
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
        NSLog(@"async0----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
        NSLog(@"async1----%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        sleep(3);
        NSLog(@"barrier async0----%@",[NSThread currentThread]);
        NSLog(@"barrier async0----%@",[NSThread currentThread]);
        NSLog(@"barrier async0----%@",[NSThread currentThread]);
    });
    NSLog(@"aaa");
    dispatch_async(queue, ^{
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
        NSLog(@"async2----%@",[NSThread currentThread]);
    });
    NSLog(@"bbb");
    dispatch_async(queue, ^{
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
        NSLog(@"async3----%@",[NSThread currentThread]);
    });
    // aaa,bbb 不一定会在barrier sync0之后输出，输出位置不定
//    2016-09-21 17:45:03.160 多线程[4659:977662] async1----<NSThread: 0x7ff5b3420f70>{number = 2, name = (null)}
//    2016-09-21 17:45:03.160 多线程[4659:977438] aaa
//    2016-09-21 17:45:03.160 多线程[4659:977657] async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:03.161 多线程[4659:977662] async1----<NSThread: 0x7ff5b3420f70>{number = 2, name = (null)}
//    2016-09-21 17:45:03.161 多线程[4659:977657] async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:03.161 多线程[4659:977662] async1----<NSThread: 0x7ff5b3420f70>{number = 2, name = (null)}
//    2016-09-21 17:45:03.161 多线程[4659:977657] async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:03.161 多线程[4659:977438] bbb
//    2016-09-21 17:45:06.167 多线程[4659:977657] barrier async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:06.167 多线程[4659:977657] barrier async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:06.167 多线程[4659:977657] barrier async0----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:06.168 多线程[4659:977657] async2----<NSThread: 0x7ff5b35199e0>{number = 3, name = (null)}
//    2016-09-21 17:45:06.168 多线程[4659:977662] async3----<NSThread: 0x7ff5b3420f70>{number = 2, name = (null)}}
}

/**
 *  多次执行block
    dispatch_apply与dispatch_sync相同，会等待执行结束,在主队列中使用需小心
 */
-(void)dispatchApply{
    dispatch_apply(10, _globalQueue, ^(size_t index) {
        NSLog(@"%zu----%@",index,[NSThread currentThread]);
    });
    NSLog(@"done");
}

/**
 *  队列的挂起与唤醒
 */
- (void)dispatchSuspendAndResume{
    dispatch_queue_t queue = dispatch_queue_create(Nil, DISPATCH_QUEUE_CONCURRENT);
    __block int a = 1;
    dispatch_async(queue, ^{
        a += 1;
    });
    dispatch_suspend(queue);
    dispatch_async(queue, ^{
        a += 1;
    });
    dispatch_async(queue, ^{
        a += 1;
    });
    dispatch_async(queue, ^{
        a += 1;
    });
    dispatch_resume(queue);
    
}

/**
 *  信号量
 */
- (void)dispatchSemaphore{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:3];
    //定义信号量
    dispatch_semaphore_t dispatchSemaphore=dispatch_semaphore_create(1);
    
    for (int i = 0; i<5; i++) {
        dispatch_async(_globalQueue, ^{
            //等待信号量
            dispatch_semaphore_wait(dispatchSemaphore, DISPATCH_TIME_FOREVER);
            [marr addObject:@(i)];
            //发送信号量
            dispatch_semaphore_signal(dispatchSemaphore);
        });
    }
    
    NSLog(@"%@",marr);
    
}


/**
 *  只执行一次，多数用于单例模式
 */
- (void)dispatchOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"ffff");
    });
}

/**
 *  读取大文件的应用，可以提高读取文件速度
 */
- (void)dispatchIO{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GCD";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initQueue];
}



@end
