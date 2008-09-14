From: Raz <raziebe@gmail.com>
Subject: Re: Subject: [PATCH] linux-acpi: smp_alternatives sleeping in spinlock
Date: Sun, 14 Sep 2008 15:37:08 +0200
Message-ID: <5d96567b0809140637n7eff9881y367aeacdd885ab1a@mail.gmail.com>
References: <5d96567b0809130652i7bc86cbfv6cdc103f595e1e11@mail.gmail.com>
	 <20080914131818.GA30643@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:12533 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbYINNhK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Sep 2008 09:37:10 -0400
Received: by nf-out-0910.google.com with SMTP id d3so907406nfc.21
        for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2008 06:37:09 -0700 (PDT)
In-Reply-To: <20080914131818.GA30643@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, carlos@strangeworlds.co.uk, Vegard Nossum <vegard.nossum@gmail.com>, Pekka Paalanen <pq@iki.fi>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

On Sun, Sep 14, 2008 at 3:18 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Raz <raziebe@gmail.com> wrote:
>
>> From: Raz Ben Yehuda <raziebe@gmail.com>
>>
>> When booting a kernel with PREEMPT_ENABLE and SLAB_DEBUG, unplugging a
>> processor results in BUG in slab.
>
> could you please post that BUG? (and which version of the kernel you
> have tried, and exactly what you did to trigger this bug)

Latest working kernel version: unknown
Earliest failing kernel version: 2.6.26.5  <-- this is the kernel I tested.
Distribution:centos 5.0 64bit
Hardware Environment: Lenovo T61 Dual core.
Software Environment:
Problem Description:
1. configure kernel as describe in Documentation/submitCheckList section 12.
2. boot this kernel
3. run . echo 0 >  /sys/devices/system/node/node0/cpu1/online

result:

SMP alternatives: switching to UP code
BUG: sleeping function called from invalid context at mm/slab.c:3052
in_atomic():1, irqs_disabled():0
INFO: lockdep is turned off.
Pid: 2463, comm: bash Not tainted 2.6.26.5 #28

Call Trace:
 [<ffffffff80251c61>] ? __debug_show_held_locks+0x1b/0x24
 [<ffffffff8022aae6>] __might_sleep+0x108/0x10a
 [<ffffffff802962fd>] kmem_cache_alloc_node+0x39/0x1a3
 [<ffffffff80289432>] ? __get_vm_area_node+0xa4/0x1d7
 [<ffffffff80289432>] __get_vm_area_node+0xa4/0x1d7
 [<ffffffff8020a3d7>] ? disable_TSC+0x17/0x53
 [<ffffffff802895c5>] get_vm_area_caller+0x2f/0x31
 [<ffffffff804b2653>] ? text_poke+0x11d/0x19a
 [<ffffffff80289d40>] vmap+0x31/0x63
 [<ffffffff804b7b62>] ? _etext+0x0/0xe
 [<ffffffff804b2653>] text_poke+0x11d/0x19a
 [<ffffffff804b7b62>] ? _etext+0x0/0xe
 [<ffffffff802118d4>] alternatives_smp_unlock+0x4f/0x63
 [<ffffffff80211b77>] alternatives_smp_switch+0x161/0x19e
 [<ffffffff8021b80c>] __cpu_die+0x5c/0x86
 [<ffffffff8049d047>] _cpu_down+0x1b5/0x28d
 [<ffffffff8049d145>] cpu_down+0x26/0x36
 [<ffffffff8049e306>] store_online+0x32/0x75
 [<ffffffff8037402e>] sysdev_store+0x24/0x26
 [<ffffffff802e3134>] sysfs_write_file+0xe5/0x121
 [<ffffffff8029dddc>] vfs_write+0xae/0x124
 [<ffffffff8029e320>] sys_write+0x47/0x70
 [<ffffffff8020bffb>] system_call_after_swapgs+0x7b/0x80

Steps to reproduce:

> note that the conversion to a sleeping lock:
>
>> -static DEFINE_SPINLOCK(smp_alt);
>> +static __DECLARE_SEMAPHORE_GENERIC(smp_alt_lock, 1);
>
> is already done correctly in the latest upstream kernel, see this
> commit:
>
>  # 2f1dafe: x86: fix SMP alternatives: use mutex instead of spinlock
>
> the better solution is to use a mutex, not a semaphore. This fix is part
> of the v2.6.26 kernel.
>
>        Ingo
>
yes. I understand.
