From: Len Brown <lenb@kernel.org>
Subject: Re: BUG: spinlock bad magic on CPU#0
Date: Fri, 14 Jan 2011 14:26:08 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101141424330.9760@x980>
References: <20110114140803.GA4003@swordfish>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20110114140803.GA4003@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 14 Jan 2011, Sergey Senozhatsky wrote:

> Hello,
> 
> Acer Aspire  5741g
> 2.6.37-git11
> 
> Got this trace today:
> 
> [    0.814609] ACPI: EC: Look up EC in DSDT
> [    0.825556] BUG: spinlock bad magic on CPU#0, swapper/1
> [    0.825639]  lock: ffffffff8242fa90, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.825741] Pid: 1, comm: swapper Not tainted 2.6.37-dbg-git11-07456-gdbc61c6-dirty #359
> [    0.825841] Call Trace:
> [    0.825923]  [<ffffffff81247919>] ? spin_bug+0x9c/0xa3
> [    0.826004]  [<ffffffff812479e9>] ? do_raw_spin_lock+0x29/0x122
> [    0.826093]  [<ffffffff814867e5>] ? _raw_spin_lock_irqsave+0x56/0x60
> [    0.826181]  [<ffffffff81275e8a>] ? acpi_os_acquire_lock+0x9/0xb
> [    0.826264]  [<ffffffff81275e8a>] ? acpi_os_acquire_lock+0x9/0xb
> [    0.826350]  [<ffffffff81288fad>] ? acpi_ev_acquire_global_lock+0x10b/0x206
> [    0.826438]  [<ffffffff8129620c>] ? acpi_ex_acquire_mutex_object+0xa3/0x11d
> [    0.826525]  [<ffffffff812952e3>] ? acpi_ex_acquire_global_lock+0x61/0xa2

Does the failure go away if you revert this commit?

commit 9cd031441a4fd09273b7c2beb337d0b2683d104c
    ACPI / ACPICA: Fix global lock acquisition

thanks,
Len Brown, Intel Open Source Technology Center
