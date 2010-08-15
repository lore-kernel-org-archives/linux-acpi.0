From: =?UTF-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@itcare.pl>
Subject: Re: Strange CPU load - acpi_os_read_port
Date: Sun, 15 Aug 2010 12:25:22 +0200
Message-ID: <4C67C092.8060808@itcare.pl>
References: <4C489E58.7020604@itcare.pl> <alpine.LFD.2.00.1008142331000.2294@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.iq.pl ([86.111.241.19]:46958 "EHLO smtp.iq.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757815Ab0HOPwF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Aug 2010 11:52:05 -0400
In-Reply-To: <alpine.LFD.2.00.1008142331000.2294@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

W dniu 2010-08-15 05:33, Len Brown pisze:
> On Thu, 22 Jul 2010, Pawe=C5=82 Staszewski wrote:
>
>   =20
>> Hello
>>
>> I have strange problem with cpu load and acpi_os_read_port
>> please look at
>> perf top - output:
>>     PerfTop:    1852 irqs/sec  kernel:99.4%  exact:  0.0% [1000Hz cy=
cles],
>> (all, 16 CPUs)
>> --------------------------------------------------------------------=
-----------------------------------------------------------------------=
----------------------------------------
>>
>>               samples  pcnt function                        DSO
>>               _______ _____ _______________________________ ________=
_________
>>
>>               2217.00 13.7% acpi_os_read_port               [kernel.=
kallsyms]
>>     =20
> curious.
> does /proc/interrupts show you are receiving acpi interrupts?
> if yes, what do you see with 'grep . /sys/firmware/acpi/interrupts/*'=
?
>
> what do you see with
> grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
>
> and if there are IO states, any change if you boot with "idle=3Dhalt"=
 or
> "idle=3Dmwait"?
>
>   =20
:) too much time has passed since my first post
so i change many things
I can try to reproduce this again but it will take some time.

=46or now the solution for me was:

Change configuration for this host and boot with processor.max_cstate=3D=
0

now perf top shows:
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------------------------------------------------
    PerfTop:   11670 irqs/sec  kernel:99.7%  exact:  0.0% [1000Hz=20
cycles],  (all, 16 CPUs)
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------------------------------------------------

              samples  pcnt function                    DSO
              _______ _____ ___________________________=20
_________________________________

             12146.00 13.6% _raw_spin_lock             =20
/lib/modules/2.6.35/build/vmlinux
              3722.00  4.2% ipt_do_table               =20
/lib/modules/2.6.35/build/vmlinux
              3161.00  3.5% rb_next                    =20
/lib/modules/2.6.35/build/vmlinux
              2950.00  3.3% u32_classify               =20
/lib/modules/2.6.35/build/vmlinux
              2285.00  2.6% rb_first                   =20
/lib/modules/2.6.35/build/vmlinux
              2280.00  2.6% tick_program_event         =20
/lib/modules/2.6.35/build/vmlinux
              2186.00  2.4% rb_erase                   =20
/lib/modules/2.6.35/build/vmlinux
              2143.00  2.4% igb_poll                   =20
/lib/modules/2.6.35/build/vmlinux
              2027.00  2.3% hfsc_enqueue               =20
/lib/modules/2.6.35/build/vmlinux
              1822.00  2.0% cftree_insert              =20
/lib/modules/2.6.35/build/vmlinux
              1791.00  2.0% vttree_insert              =20
/lib/modules/2.6.35/build/vmlinux
              1775.00  2.0% apic_timer_interrupt       =20
/lib/modules/2.6.35/build/vmlinux
              1614.00  1.8% dev_queue_xmit             =20
/lib/modules/2.6.35/build/vmlinux
              1593.00  1.8% hfsc_dequeue               =20
/lib/modules/2.6.35/build/vmlinux
              1457.00  1.6% __hrtimer_start_range_ns   =20
/lib/modules/2.6.35/build/vmlinux
              1433.00  1.6% irq_entries_start          =20
/lib/modules/2.6.35/build/vmlinux
              1359.00  1.5% rb_insert_color            =20
/lib/modules/2.6.35/build/vmlinux
              1334.00  1.5% hrtimer_interrupt          =20
/lib/modules/2.6.35/build/vmlinux
              1212.00  1.4% pskb_expand_head           =20
/lib/modules/2.6.35/build/vmlinux
              1168.00  1.3% tick_dev_program_event     =20
/lib/modules/2.6.35/build/vmlinux
              1031.00  1.2% T.1040                     =20
/lib/modules/2.6.35/build/vmlinux
              1031.00  1.2% rb_last                    =20
/lib/modules/2.6.35/build/vmlinux

without processor.max_cstate=3D0 at boot i have

acpi_os_read_port in the top

Thanks
Pawel


> thanks,
> -Len Brown
> Intel Open Source Technology Center
>
>   =20
>>                613.00  3.8% igb_poll                        [kernel.=
kallsyms]
>>                546.00  3.4% acpi_idle_enter_bm              [kernel.=
kallsyms]
>>                482.00  3.0% _raw_spin_lock                  [kernel.=
kallsyms]
>>                469.00  2.9% ipt_do_table                    [kernel.=
kallsyms]
>>                415.00  2.6% find_busiest_group              [kernel.=
kallsyms]
>>                341.00  2.1% tick_dev_program_event          [kernel.=
kallsyms]
>>                299.00  1.9% u32_classify                    [kernel.=
kallsyms]
>>                299.00  1.9% __slab_free                     [kernel.=
kallsyms]
>>                294.00  1.8% timer_stats_update_stats        [kernel.=
kallsyms]
>>                235.00  1.5% leave_mm                        [kernel.=
kallsyms]
>>                231.00  1.4% skb_release_data                [kernel.=
kallsyms]
>>                227.00  1.4% __hrtimer_start_range_ns        [kernel.=
kallsyms]
>>                220.00  1.4% tick_program_event              [kernel.=
kallsyms]
>>                211.00  1.3% irq_entries_start               [kernel.=
kallsyms]
>>                206.00  1.3% cpuidle_idle_call               [kernel.=
kallsyms]
>>                181.00  1.1% acpi_hw_validate_io_request     [kernel.=
kallsyms]
>>                178.00  1.1% apic_timer_interrupt            [kernel.=
kallsyms]
>>                172.00  1.1% consume_skb                     [kernel.=
kallsyms]
>>                162.00  1.0% getnstimeofday                  [kernel.=
kallsyms]
>>                162.00  1.0% rb_erase                        [kernel.=
kallsyms]
>>                161.00  1.0% read_tsc                        [kernel.=
kallsyms]
>>                154.00  1.0% hrtimer_interrupt               [kernel.=
kallsyms]
>>                148.00  0.9% _raw_spin_unlock_irqrestore     [kernel.=
kallsyms]
>>                148.00  0.9% napi_schedule                   [kernel.=
kallsyms]
>>                136.00  0.8% __do_softirq                    [kernel.=
kallsyms]
>>                135.00  0.8% dma_issue_pending_all           [kernel.=
kallsyms]
>>                130.00  0.8% virt_to_head_page               [kernel.=
kallsyms]
>>                125.00  0.8% clockevents_program_event       [kernel.=
kallsyms]
>>                118.00  0.7% ladder_select_state             [kernel.=
kallsyms]
>>                114.00  0.7% hrtimer_force_reprogram         [kernel.=
kallsyms]
>>                108.00  0.7% timekeeping_get_ns              [kernel.=
kallsyms]
>>                107.00  0.7% __dma_has_cap                   [kernel.=
kallsyms]
>>                105.00  0.7% dev_queue_xmit                  [kernel.=
kallsyms]
>>                103.00  0.6% acpi_idle_do_entry              [kernel.=
kallsyms]
>>                102.00  0.6% kfree                           [kernel.=
kallsyms]
>>                 98.00  0.6% sched_clock                     [kernel.=
kallsyms]
>>                 95.00  0.6% load_balance                    [kernel.=
kallsyms]
>>                 95.00  0.6% pskb_expand_head                [kernel.=
kallsyms]
>>                 88.00  0.5% kmem_cache_free                 [kernel.=
kallsyms]
>>                 86.00  0.5% run_timer_softirq               [kernel.=
kallsyms]
>>                 84.00  0.5% __rcu_pending                   [kernel.=
kallsyms]
>>                 82.00  0.5% acpi_processor_ffh_cstate_enter [kernel.=
kallsyms]
>>                 80.00  0.5% notifier_call_chain             [kernel.=
kallsyms]
>>                 80.00  0.5% acpi_hw_read_port               [kernel.=
kallsyms]
>>                 79.00  0.5% nf_iterate                      [kernel.=
kallsyms]
>>                 77.00  0.5% dev_gro_receive                 [kernel.=
kallsyms]
>>                 77.00  0.5% rb_insert_color                 [kernel.=
kallsyms]
>>                 75.00  0.5% find_next_bit                   [kernel.=
kallsyms]
>>                 74.00  0.5% skb_header_pointer              [kernel.=
kallsyms]
>>                 72.00  0.4% run_posix_cpu_timers            [kernel.=
kallsyms]
>>                 72.00  0.4% hfsc_enqueue                    [kernel.=
kallsyms]
>>                 69.00  0.4% run_rebalance_domains           [kernel.=
kallsyms]
>>                 68.00  0.4% __napi_complete                 [kernel.=
kallsyms]
>>                 67.00  0.4% ktime_get                       [kernel.=
kallsyms]
>>                 67.00  0.4% scheduler_tick                  [kernel.=
kallsyms]
>>                 66.00  0.4% skb_release_head_state          [kernel.=
kallsyms]
>>                 64.00  0.4% __run_hrtimer                   [kernel.=
kallsyms]
>>                 64.00  0.4% acpi_hw_validate_register       [kernel.=
kallsyms]
>>                 62.00  0.4% ip_route_input_common           [kernel.=
kallsyms]
>>
>>
>> mpstat -P 1,2 1 10
>> Linux 2.6.35-rc5 (eP-RTR-IX-01)         07/22/10        _x86_64_    =
    (16
>> CPU)
>>
>> 23:39:26     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %s=
teal
>> %guest   %idle
>> 23:39:27       1    0.00    0.00    0.00    0.00    0.00   52.00    =
0.00
>> 0.00   48.00
>> 23:39:27       2    0.00    0.00    0.00    0.00    0.00   17.00    =
0.00
>> 0.00   83.00
>> 23:39:28       1    0.00    0.00    0.00    0.00    0.00   39.00    =
0.00
>> 0.00   61.00
>> 23:39:28       2    0.00    0.00    0.00    0.00    0.00    8.00    =
0.00
>> 0.00   92.00
>> 23:39:29       1    0.00    0.00    0.00    0.00    0.00   47.00    =
0.00
>> 0.00   53.00
>> 23:39:29       2    0.00    0.00    0.00    0.00    0.00    9.00    =
0.00
>> 0.00   91.00
>> 23:39:30       1   58.00    0.00    0.00    0.00    0.00   42.00    =
0.00
>> 0.00    0.00
>> 23:39:30       2    0.00    0.00    0.00    0.00    0.00   18.00    =
0.00
>> 0.00   82.00
>> 23:39:31       1    9.00    0.00    0.00    0.00    0.00   51.00    =
0.00
>> 0.00   40.00
>> 23:39:31       2    2.00    0.00    0.00    0.00    0.00   18.00    =
0.00
>> 0.00   80.00
>> 23:39:32       1    0.00    0.00    0.00    0.00    0.00   39.00    =
0.00
>> 0.00   61.00
>> 23:39:32       2    2.00    0.00    0.00    0.00    0.00   20.00    =
0.00
>> 0.00   78.00
>> 23:39:33       1    0.00    0.00    0.00    0.00    0.00   48.00    =
0.00
>> 0.00   52.00
>> 23:39:33       2    0.00    0.00    0.00    0.00    0.00   13.00    =
0.00
>> 0.00   87.00
>> 23:39:34       1    0.00    0.00    0.00    0.00    0.00   52.00    =
0.00
>> 0.00   48.00
>> 23:39:34       2    0.00    0.00    0.00    0.00    0.00    9.00    =
0.00
>> 0.00   91.00
>> 23:39:35       1    0.00    0.00    0.00    0.00    0.00   52.00    =
0.00
>> 0.00   48.00
>> 23:39:35       2    0.00    0.00    0.00    0.00    0.00   18.00    =
0.00
>> 0.00   82.00
>> 23:39:36       1    0.00    0.00    0.00    0.00    0.00   50.00    =
0.00
>> 0.00   50.00
>> 23:39:36       2    0.00    0.00    0.00    0.00    0.00    9.00    =
0.00
>> 0.00   91.00
>> Average:       1    6.70    0.00    0.00    0.00    0.00   47.20    =
0.00
>> 0.00   46.10
>> Average:       2    0.40    0.00    0.00    0.00    0.00   13.90    =
0.00
>> 0.00   85.70
>>
>> Server is acting as a bgp router - 500Mbit/s RX / 500Mbit/s TX traff=
ic.
>> But the topper of cpu load is acpi_os_read_port - why ?
>>
>>
>> Thanks
>> Pawel
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
