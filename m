From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Mon, 30 Oct 2017 16:14:15 -0400
Message-ID: <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

On 10/30/2017 1:46 PM, Linus Torvalds wrote:
> On Mon, Oct 30, 2017 at 10:20 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> I will add a "might_sleep()" to ioremap_page_range() itself, so that
>> we get this warning more reliably and much eailer. Right now it has
>> been hidden by the fact that most of the time the time the page tables
>> may be already allocated, but even then it's broken.
> Done. It doesn't report anything for me, so _hopefully_ the GHES
> driver is the only one that does games like this. See commit
> b39ab98e2f47 ("Mark 'ioremap_page_range()' as possibly sleeping").
>
> So now it should hopefully warn about this bad usage of page remapping
> reliably, at least if you have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
>
> Can somebody who has a working GHES setup (although Borislav seems to
> think no such thing exists) verify?
Hello Linus,

I have verified that this flags the error for me every time ghes_proc() is used.
But I also see it flagged in ARM PMU code:

[    7.381153] BUG: sleeping function called from invalid context at mm/slab.h:420
[    7.387625] in_atomic(): 0, irqs_disabled(): 128, pid: 11, name: cpuhp/0
[    7.394310] CPU: 0 PID: 11 Comm: cpuhp/0 Not tainted 4.14.0-rc7 #46
[    7.400559] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development 
Platform
[    7.414361] Call trace:
[    7.416797] [<ffff000008088b28>] dump_backtrace+0x0/0x270
[    7.422175] [<ffff000008088dbc>] show_stack+0x24/0x30
[    7.427211] [<ffff0000090d01f0>] dump_stack+0x98/0xb8
[    7.432246] [<ffff00000810118c>] ___might_sleep+0x104/0x128
[    7.437799] [<ffff000008101208>] __might_sleep+0x58/0x90
[    7.443097] [<ffff000008254a7c>] kmem_cache_alloc_trace+0x224/0x280
[    7.449347] [<ffff000008e9c938>] armpmu_alloc+0x30/0x168
[    7.454639] [<ffff000008e9d15c>] arm_pmu_acpi_cpu_starting+0x114/0x148
[    7.461151] [<ffff0000080d0f30>] cpuhp_invoke_callback+0xb8/0x760
[    7.467226] [<ffff0000080d1ec4>] cpuhp_thread_fun+0xa4/0x1b8
[    7.472872] [<ffff0000080f661c>] smpboot_thread_fn+0x174/0x250
[    7.478684] [<ffff0000080f18ec>] kthread+0x114/0x140
[    7.483632] [<ffff000008084774>] ret_from_fork+0x10/0x1c

For a GHES polling source:

[   47.944596] BUG: sleeping function called from invalid context at 
lib/ioremap.c:164
[   47.951290] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/19
[   47.958150] CPU: 19 PID: 0 Comm: swapper/19 Tainted: G W       4.14.0-rc7 #46
[   47.958152] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development 
Platform
[   47.958154] Call trace:
[   47.958161] [<ffff000008088b28>] dump_backtrace+0x0/0x270
[   47.958165] [<ffff000008088dbc>] show_stack+0x24/0x30
[   47.958169] [<ffff0000090d01f0>] dump_stack+0x98/0xb8
[   47.958174] [<ffff00000810118c>] ___might_sleep+0x104/0x128
[   47.958177] [<ffff000008101208>] __might_sleep+0x58/0x90
[   47.958180] [<ffff0000090d3d20>] ioremap_page_range+0x40/0x310
[   47.958185] [<ffff0000086c5a98>] ghes_copy_tofrom_phys+0x1f8/0x240
[   47.958188] [<ffff0000086c5da8>] ghes_proc+0xb0/0x8f0
[   47.958190] [<ffff0000086c6ae8>] ghes_poll_func+0x20/0x40
[   47.958196] [<ffff00000814b3dc>] call_timer_fn+0x3c/0x1b0
[   47.958198] [<ffff00000814b638>] expire_timers+0xe8/0x170
[   47.958201] [<ffff00000814b7fc>] run_timer_softirq+0x13c/0x188
[   47.958203] [<ffff000008081964>] __do_softirq+0x144/0x33c
[   47.958206] [<ffff0000080d6e78>] irq_exit+0xd0/0x108
[   47.958210] [<ffff00000812dc44>] __handle_domain_irq+0x6c/0xc0
[   47.958212] [<ffff000008081764>] gic_handle_irq+0xcc/0x188

For a GHES interrupt source:

[  265.502603] BUG: sleeping function called from invalid context at 
lib/ioremap.c:164
[  265.509296] in_atomic(): 1, irqs_disabled(): 128, pid: 3, name: kworker/0:0
[  265.516242] CPU: 0 PID: 3 Comm: kworker/0:0 Tainted: G W       4.14.0-rc7 #46
[  265.516244] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development 
Platform
[  265.516251] Workqueue: kacpi_notify acpi_os_execute_deferred
[  265.516254] Call trace:
[  265.516258] [<ffff000008088b28>] dump_backtrace+0x0/0x270
[  265.516261] [<ffff000008088dbc>] show_stack+0x24/0x30
[  265.516264] [<ffff0000090d01f0>] dump_stack+0x98/0xb8
[  265.516268] [<ffff00000810118c>] ___might_sleep+0x104/0x128
[  265.516270] [<ffff000008101208>] __might_sleep+0x58/0x90
[  265.516273] [<ffff0000090d3d20>] ioremap_page_range+0x40/0x310
[  265.516277] [<ffff0000086c5a98>] ghes_copy_tofrom_phys+0x1f8/0x240
[  265.516279] [<ffff0000086c5da8>] ghes_proc+0xb0/0x8f0
[  265.516282] [<ffff0000086c6670>] ghes_notify_hed+0x50/0x90
[  265.516286] [<ffff0000080f36a4>] notifier_call_chain+0x5c/0xa0
[  265.516289] [<ffff0000080f3b80>] __blocking_notifier_call_chain+0x58/0xa0
[  265.516291] [<ffff0000080f3c04>] blocking_notifier_call_chain+0x3c/0x50
[  265.516293] [<ffff0000086c1140>] acpi_hed_notify+0x28/0x30
[  265.516296] [<ffff000008678100>] acpi_device_notify+0x30/0x40
[  265.516301] [<ffff000008691fb8>] acpi_ev_notify_dispatch+0x64/0x74
[  265.516304] [<ffff00000867296c>] acpi_os_execute_deferred+0x24/0x38
[  265.516308] [<ffff0000080ea748>] process_one_work+0x1f8/0x488
[  265.516310] [<ffff0000080eaa30>] worker_thread+0x58/0x4a0
[  265.516312] [<ffff0000080f18ec>] kthread+0x114/0x140
[  265.516315] [<ffff000008084774>] ret_from_fork+0x10/0x1c

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
