From: Len Brown <lenb@kernel.org>
Subject: Re: Strange CPU load - acpi_os_read_port
Date: Sat, 14 Aug 2010 23:33:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008142331000.2294@localhost.localdomain>
References: <4C489E58.7020604@itcare.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-628639775-1281843196=:2294"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:59416 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0HODdT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Aug 2010 23:33:19 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L76002P6CJHVO02@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 14 Aug 2010 22:33:18 -0500 (CDT)
In-reply-to: <4C489E58.7020604@itcare.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-2?Q?Pawe=B3_Staszewski?= <pstaszewski@itcare.pl>
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-628639775-1281843196=:2294
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Jul 2010, Paweł Staszewski wrote:

> Hello
> 
> I have strange problem with cpu load and acpi_os_read_port
> please look at
> perf top - output:
>    PerfTop:    1852 irqs/sec  kernel:99.4%  exact:  0.0% [1000Hz cycles],
> (all, 16 CPUs)
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>              samples  pcnt function                        DSO
>              _______ _____ _______________________________ _________________
> 
>              2217.00 13.7% acpi_os_read_port               [kernel.kallsyms]

curious.
does /proc/interrupts show you are receiving acpi interrupts?
if yes, what do you see with 'grep . /sys/firmware/acpi/interrupts/*'?

what do you see with
grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*

and if there are IO states, any change if you boot with "idle=halt" or 
"idle=mwait"?

thanks,
-Len Brown
Intel Open Source Technology Center

>               613.00  3.8% igb_poll                        [kernel.kallsyms]
>               546.00  3.4% acpi_idle_enter_bm              [kernel.kallsyms]
>               482.00  3.0% _raw_spin_lock                  [kernel.kallsyms]
>               469.00  2.9% ipt_do_table                    [kernel.kallsyms]
>               415.00  2.6% find_busiest_group              [kernel.kallsyms]
>               341.00  2.1% tick_dev_program_event          [kernel.kallsyms]
>               299.00  1.9% u32_classify                    [kernel.kallsyms]
>               299.00  1.9% __slab_free                     [kernel.kallsyms]
>               294.00  1.8% timer_stats_update_stats        [kernel.kallsyms]
>               235.00  1.5% leave_mm                        [kernel.kallsyms]
>               231.00  1.4% skb_release_data                [kernel.kallsyms]
>               227.00  1.4% __hrtimer_start_range_ns        [kernel.kallsyms]
>               220.00  1.4% tick_program_event              [kernel.kallsyms]
>               211.00  1.3% irq_entries_start               [kernel.kallsyms]
>               206.00  1.3% cpuidle_idle_call               [kernel.kallsyms]
>               181.00  1.1% acpi_hw_validate_io_request     [kernel.kallsyms]
>               178.00  1.1% apic_timer_interrupt            [kernel.kallsyms]
>               172.00  1.1% consume_skb                     [kernel.kallsyms]
>               162.00  1.0% getnstimeofday                  [kernel.kallsyms]
>               162.00  1.0% rb_erase                        [kernel.kallsyms]
>               161.00  1.0% read_tsc                        [kernel.kallsyms]
>               154.00  1.0% hrtimer_interrupt               [kernel.kallsyms]
>               148.00  0.9% _raw_spin_unlock_irqrestore     [kernel.kallsyms]
>               148.00  0.9% napi_schedule                   [kernel.kallsyms]
>               136.00  0.8% __do_softirq                    [kernel.kallsyms]
>               135.00  0.8% dma_issue_pending_all           [kernel.kallsyms]
>               130.00  0.8% virt_to_head_page               [kernel.kallsyms]
>               125.00  0.8% clockevents_program_event       [kernel.kallsyms]
>               118.00  0.7% ladder_select_state             [kernel.kallsyms]
>               114.00  0.7% hrtimer_force_reprogram         [kernel.kallsyms]
>               108.00  0.7% timekeeping_get_ns              [kernel.kallsyms]
>               107.00  0.7% __dma_has_cap                   [kernel.kallsyms]
>               105.00  0.7% dev_queue_xmit                  [kernel.kallsyms]
>               103.00  0.6% acpi_idle_do_entry              [kernel.kallsyms]
>               102.00  0.6% kfree                           [kernel.kallsyms]
>                98.00  0.6% sched_clock                     [kernel.kallsyms]
>                95.00  0.6% load_balance                    [kernel.kallsyms]
>                95.00  0.6% pskb_expand_head                [kernel.kallsyms]
>                88.00  0.5% kmem_cache_free                 [kernel.kallsyms]
>                86.00  0.5% run_timer_softirq               [kernel.kallsyms]
>                84.00  0.5% __rcu_pending                   [kernel.kallsyms]
>                82.00  0.5% acpi_processor_ffh_cstate_enter [kernel.kallsyms]
>                80.00  0.5% notifier_call_chain             [kernel.kallsyms]
>                80.00  0.5% acpi_hw_read_port               [kernel.kallsyms]
>                79.00  0.5% nf_iterate                      [kernel.kallsyms]
>                77.00  0.5% dev_gro_receive                 [kernel.kallsyms]
>                77.00  0.5% rb_insert_color                 [kernel.kallsyms]
>                75.00  0.5% find_next_bit                   [kernel.kallsyms]
>                74.00  0.5% skb_header_pointer              [kernel.kallsyms]
>                72.00  0.4% run_posix_cpu_timers            [kernel.kallsyms]
>                72.00  0.4% hfsc_enqueue                    [kernel.kallsyms]
>                69.00  0.4% run_rebalance_domains           [kernel.kallsyms]
>                68.00  0.4% __napi_complete                 [kernel.kallsyms]
>                67.00  0.4% ktime_get                       [kernel.kallsyms]
>                67.00  0.4% scheduler_tick                  [kernel.kallsyms]
>                66.00  0.4% skb_release_head_state          [kernel.kallsyms]
>                64.00  0.4% __run_hrtimer                   [kernel.kallsyms]
>                64.00  0.4% acpi_hw_validate_register       [kernel.kallsyms]
>                62.00  0.4% ip_route_input_common           [kernel.kallsyms]
> 
> 
> mpstat -P 1,2 1 10
> Linux 2.6.35-rc5 (eP-RTR-IX-01)         07/22/10        _x86_64_        (16
> CPU)
> 
> 23:39:26     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
> %guest   %idle
> 23:39:27       1    0.00    0.00    0.00    0.00    0.00   52.00    0.00
> 0.00   48.00
> 23:39:27       2    0.00    0.00    0.00    0.00    0.00   17.00    0.00
> 0.00   83.00
> 23:39:28       1    0.00    0.00    0.00    0.00    0.00   39.00    0.00
> 0.00   61.00
> 23:39:28       2    0.00    0.00    0.00    0.00    0.00    8.00    0.00
> 0.00   92.00
> 23:39:29       1    0.00    0.00    0.00    0.00    0.00   47.00    0.00
> 0.00   53.00
> 23:39:29       2    0.00    0.00    0.00    0.00    0.00    9.00    0.00
> 0.00   91.00
> 23:39:30       1   58.00    0.00    0.00    0.00    0.00   42.00    0.00
> 0.00    0.00
> 23:39:30       2    0.00    0.00    0.00    0.00    0.00   18.00    0.00
> 0.00   82.00
> 23:39:31       1    9.00    0.00    0.00    0.00    0.00   51.00    0.00
> 0.00   40.00
> 23:39:31       2    2.00    0.00    0.00    0.00    0.00   18.00    0.00
> 0.00   80.00
> 23:39:32       1    0.00    0.00    0.00    0.00    0.00   39.00    0.00
> 0.00   61.00
> 23:39:32       2    2.00    0.00    0.00    0.00    0.00   20.00    0.00
> 0.00   78.00
> 23:39:33       1    0.00    0.00    0.00    0.00    0.00   48.00    0.00
> 0.00   52.00
> 23:39:33       2    0.00    0.00    0.00    0.00    0.00   13.00    0.00
> 0.00   87.00
> 23:39:34       1    0.00    0.00    0.00    0.00    0.00   52.00    0.00
> 0.00   48.00
> 23:39:34       2    0.00    0.00    0.00    0.00    0.00    9.00    0.00
> 0.00   91.00
> 23:39:35       1    0.00    0.00    0.00    0.00    0.00   52.00    0.00
> 0.00   48.00
> 23:39:35       2    0.00    0.00    0.00    0.00    0.00   18.00    0.00
> 0.00   82.00
> 23:39:36       1    0.00    0.00    0.00    0.00    0.00   50.00    0.00
> 0.00   50.00
> 23:39:36       2    0.00    0.00    0.00    0.00    0.00    9.00    0.00
> 0.00   91.00
> Average:       1    6.70    0.00    0.00    0.00    0.00   47.20    0.00
> 0.00   46.10
> Average:       2    0.40    0.00    0.00    0.00    0.00   13.90    0.00
> 0.00   85.70
> 
> Server is acting as a bgp router - 500Mbit/s RX / 500Mbit/s TX traffic.
> But the topper of cpu load is acpi_os_read_port - why ?
> 
> 
> Thanks
> Pawel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--8323328-628639775-1281843196=:2294--
