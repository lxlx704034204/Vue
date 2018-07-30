package com.example.utils;

import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * ScheduledExecutorService是从Java SE 5的java.util.concurrent里，做为并发工具类被引进的，这是最理想的定时任务实现方式。
 * 相比于上两个方法(普通thread和用Timer、TimerTask)，它有以下好处：
 * 相比于Timer的单线程，它是通过线程池的方式来并发执行任务的
 * 可以很灵活的去设定第一次执行任务delay时间
 * 提供了良好的约定，以便设定执行的时间间隔
 */

public class timer implements Runnable  {

    private String jobName = "";

    public timer(String jobName) {
        super();
        this.jobName = jobName;
    }

    @Override
    public void run() {
        System.out.println(new Date()+","+jobName);
    }

    public static void main(String[] args) {
        ScheduledExecutorService service = Executors.newScheduledThreadPool(10);
        System.out.println(new Date());

        long initialDelay1 = 1;
        long period1 = 1;
        // 从现在开始1秒钟之后，每隔1秒钟执行一次job1
        service.scheduleAtFixedRate(
                new timer("job1"), initialDelay1,
                period1, TimeUnit.SECONDS);


        long initialDelay2 = 2;
        long delay2 = 2;
        // 从现在开始2秒钟之后，每隔2秒钟执行一次job2
        service.scheduleWithFixedDelay(
                new timer("job2"), initialDelay2,
                delay2, TimeUnit.SECONDS);
    }

}
