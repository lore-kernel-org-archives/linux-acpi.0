From: "Len Brown" <lenb@kernel.org>
Subject: boot crash at ibm_find_acpi_device+0x5c/0xf5
Date: Thu, 24 Sep 2009 15:12:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909241512070.7118@sony>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.g-wis.com ([204.250.154.18]:4655 "EHLO mail.g-wis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab0CHUCx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Mar 2010 15:02:53 -0500
Received: from sony (localhost [127.0.0.1]) by sony (8.14.3/8.14.3) with ESMTP id o28JuVqR005397 for <linux-acpi@vger.kernel.org>; Mon, 8 Mar 2010 14:56:40 -0500
Received: from localhost (lenb@localhost) by sony (8.14.3/8.14.3/Submit) with ESMTP id n8OJHTR1023342 for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2009 15:22:07 -0400
Content-Class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

anybody seen this one?

thanks,
Len Brown, Intel Open Source Technology Center

---------- Forwarded message ----------
Date: Wed, 23 Sep 2009 21:02:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jason Wessel <jason.wessel@windriver.com>, Len Brown <lenb@kernel.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>,
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
    linux-usb@vger.kernel.org
Subject: Re: [origin tree boot hang] [PATCH] Revert
    "early_printk: Allow morethan one early console"


* Jason Wessel <jason.wessel@windriver.com> wrote:

> Ingo Molnar wrote:
> >>       early_printk: Allow more than one early console
> >>     
> >
> > this patch broke things pretty badly on x86, with pretty much any 
> > config, as long as the early console is used - which most of my 
> > test-systems do :-(
> >   
> 
> Ingo,
> 
> Can you send me the boot args and kernel config you are using?  I'd 
> like to figure out which part was at fault and fix it up.

will do. Will take some time though - trying to track down a new boot 
crash as well:

acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpiphp_init+0x0/0x83 returned -19 after 16410 usecs
calling  ibm_acpiphp_init+0x0/0x190 @ 1
BUG: unable to handle kernel NULL pointer dereference at 0000000000000003
IP: [<ffffffff82b07130>] ibm_find_acpi_device+0x5c/0xf5
PGD 0 
Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
last sysfs file: 
CPU 0 
Pid: 1, comm: swapper Not tainted 2.6.31-tip #16786 System Product Name
RIP: 0010:[<ffffffff82b07130>]  [<ffffffff82b07130>] ibm_find_acpi_device+0x5c/0xf5
RSP: 0018:ffff88003f2d1d60  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88003f2d1d68 RSI: 00000000000001e4 RDI: 0000000000000000
RBP: ffff88003f2d1d90 R08: 0000000000000001 R09: ffffffff824b645b
R10: 000000002d0ef63b R11: ffff88003f2d1a80 R12: ffff88003fa780d0
R13: ffffffff83940dc8 R14: 0000000000000001 R15: ffffffff83942e10
FS:  0000000000000000(0000) GS:ffff880005800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000003 CR3: 0000000001001000 CR4: 00000000000006b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 1, threadinfo ffff88003f2d0000, task ffff88003f2c8000)
Stack:
 ffff88003f2c8000 ffff88003cfbb690 000000002d0ef63b 0000000000000000
<0> 0000000000000000 ffff88003fa780d0 ffff88003f2d1e10 ffffffff8156b6b6
<0> 0000000000000001 0000000100000000 0000000000000000 ffffffff83940dc8
Call Trace:
 [<ffffffff8156b6b6>] acpi_ns_walk_namespace+0x11d/0x234
 [<ffffffff82b070d4>] ? ibm_find_acpi_device+0x0/0xf5
 [<ffffffff8157b159>] ? acpi_ut_acquire_mutex+0xd9/0x12e
 [<ffffffff82b070d4>] ? ibm_find_acpi_device+0x0/0xf5
 [<ffffffff81566dfa>] acpi_walk_namespace+0x105/0x162
 [<ffffffff81d067bf>] ? acpi_pm_read+0xd/0x3e
 [<ffffffff82b06f44>] ? ibm_acpiphp_init+0x0/0x190
 [<ffffffff82b06fa8>] ibm_acpiphp_init+0x64/0x190
 [<ffffffff810090b4>] do_one_initcall+0x82/0x1a6
 [<ffffffff810edecc>] ? init_irq_proc+0x77/0x9a
 [<ffffffff82ad8975>] do_basic_setup+0x5e/0x87
 [<ffffffff82ad8a26>] kernel_init+0x88/0xe2
 [<ffffffff8103ddfa>] child_rip+0xa/0x20
 [<ffffffff8103d7bc>] ? restore_args+0x0/0x30
 [<ffffffff82ad899e>] ? kernel_init+0x0/0xe2
 [<ffffffff8103ddf0>] ? child_rip+0x0/0x20
Code: 48 c7 c2 c0 7b 0b 82 48 c7 c6 95 39 4a 82 48 c7 c7 1a 3c 4a 82 31 c0 e8 02 84 4b ff 31 c0 e9 82 00 00 00 48 8b 45 d8 48 8b 40 30 <c6> 40 03 00 48 8b 45 d8 83 78 18 00 74 5f f6 40 0d 04 74 59 48 
RIP  [<ffffffff82b07130>] ibm_find_acpi_device+0x5c/0xf5
 RSP <ffff88003f2d1d60>
CR2: 0000000000000003
---[ end trace 5a5d197966b56a2e ]---
Kernel panic - not syncing: Fatal exception
Pid: 1, comm: swapper Tainted: G      D    2.6.31-tip #16786

/me looks in the general direction of Len ;-)

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
