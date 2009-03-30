From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: warning at powernowk8_cpu_init()
Date: Mon, 30 Mar 2009 10:38:20 +0800
Message-ID: <1238380700.3625.17.camel@localhost.localdomain>
References: <49CF4DDB.8050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48399 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753AbZC3Ch0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Mar 2009 22:37:26 -0400
In-Reply-To: <49CF4DDB.8050607@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2009-03-29 at 18:30 +0800, Roel Kluin wrote:
> Hi,
> 
> I got this warning during boot:
> 
> powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 5000+ processors (2 cpu cores) (version 2.20.00)
> ------------[ cut here ]------------
> WARNING: at /home/roel/dnld/src/kernel/git/linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c:1254 powernowk8_cpu_init+0x500/0xad0()
> Hardware name: MS-7369
> [Firmware Bug]: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
Hi, 
   From the log it seems that there is no _PSS object , which is
required by the powernow-k8 cpufreq. IMO the warning message is
reasonable. 
   We have seen this issue on a lot of machines based on AMD platforms.
And this issue had better be fixed by BIOS upgrading.

> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.29-smp #1
Is the following dump stack message reported on vanilla kernel ? Or is
it reported by adding the function of dump_stack?
Thanks.
> Call Trace:
>  [<c012c466>] warn_slowpath+0x86/0xa0
>  [<c0300ae5>] ? acpi_ns_get_node+0x7a/0x84
>  [<c0300ae5>] ? acpi_ns_get_node+0x7a/0x84
>  [<c0124870>] ? default_wake_function+0x0/0x10
>  [<c0120f56>] ? task_rq_lock+0x66/0x90
>  [<c0300d54>] ? acpi_get_handle+0x6c/0x8e
>  [<c03125ad>] ? acpi_processor_register_performance+0x397/0x3b2
>  [<c047f2c2>] ? _cond_resched+0x22/0x50
>  [<c018f48b>] ? kmem_cache_alloc+0x8b/0xd0
>  [<c047a59e>] ? powernowk8_cpu_init+0x4e/0xad0
>  [<c047aa50>] powernowk8_cpu_init+0x500/0xad0
>  [<c012677f>] ? finish_task_switch+0xaf/0xf0
>  [<c047f2c2>] ? _cond_resched+0x22/0x50
>  [<c047f2c2>] ? _cond_resched+0x22/0x50
>  [<c047ff0b>] ? down_write+0xb/0x30
>  [<c03cd970>] ? lock_policy_rwsem_write+0x70/0xa0
>  [<c03cdcf9>] cpufreq_add_dev+0x1c9/0x5f0
>  [<c032dc80>] ? vt_console_print+0x0/0x2a0
>  [<c0144176>] ? up+0x46/0x60
>  [<c012cc29>] ? release_console_sem+0x209/0x210
>  [<c0120f56>] ? task_rq_lock+0x66/0x90
>  [<c02c3f87>] ? kref_get+0x37/0x60
>  [<c01273ee>] ? set_cpus_allowed_ptr+0xae/0x120
>  [<c033c025>] sysdev_driver_register+0x75/0x120
>  [<c047a550>] ? powernowk8_cpu_init+0x0/0xad0
>  [<c03ce5a6>] cpufreq_register_driver+0x86/0x140
>  [<c047a537>] powernowk8_init+0x87/0xa0
>  [<c047a4b0>] ? powernowk8_init+0x0/0xa0
>  [<c0101114>] do_one_initcall+0x24/0x150
>  [<c01d46c4>] ? create_proc_entry+0x54/0xa0
>  [<c015c5e2>] ? register_irq_proc+0xa2/0xc0
>  [<c015c665>] ? init_irq_proc+0x65/0x80
>  [<c0618662>] kernel_init+0x122/0x180
>  [<c0618540>] ? kernel_init+0x0/0x180
>  [<c0103cdb>] kernel_thread_helper+0x7/0x1c
> ---[ end trace f7b2fa9171ecaaac ]---
> dmesg and .config are attached

