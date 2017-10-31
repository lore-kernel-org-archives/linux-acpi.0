From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Tue, 31 Oct 2017 12:29:46 +0000
Message-ID: <20171031122945.ojkdtg4efxljf5xt@lakrids.cambridge.arm.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
 <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org>
 <20171031103833.GD5584@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbdJaM3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Oct 2017 08:29:55 -0400
Content-Disposition: inline
In-Reply-To: <20171031103833.GD5584@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>

On Tue, Oct 31, 2017 at 10:38:33AM +0000, Will Deacon wrote:
> On Mon, Oct 30, 2017 at 04:14:15PM -0400, Tyler Baicar wrote:
> > On 10/30/2017 1:46 PM, Linus Torvalds wrote:
> > >On Mon, Oct 30, 2017 at 10:20 AM, Linus Torvalds
> > ><torvalds@linux-foundation.org> wrote:
> > >>I will add a "might_sleep()" to ioremap_page_range() itself, so that
> > >>we get this warning more reliably and much eailer. Right now it has
> > >>been hidden by the fact that most of the time the time the page tables
> > >>may be already allocated, but even then it's broken.
> > >Done. It doesn't report anything for me, so _hopefully_ the GHES
> > >driver is the only one that does games like this. See commit
> > >b39ab98e2f47 ("Mark 'ioremap_page_range()' as possibly sleeping").
> > >
> > >So now it should hopefully warn about this bad usage of page remapping
> > >reliably, at least if you have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> > >
> > >Can somebody who has a working GHES setup (although Borislav seems to
> > >think no such thing exists) verify?
> > Hello Linus,
> > 
> > I have verified that this flags the error for me every time ghes_proc() is used.
> > But I also see it flagged in ARM PMU code:
> > 
> > [    7.381153] BUG: sleeping function called from invalid context at mm/slab.h:420
> > [    7.387625] in_atomic(): 0, irqs_disabled(): 128, pid: 11, name: cpuhp/0
> > [    7.394310] CPU: 0 PID: 11 Comm: cpuhp/0 Not tainted 4.14.0-rc7 #46
> > [    7.400559] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development
> > Platform
> > [    7.414361] Call trace:
> > [    7.416797] [<ffff000008088b28>] dump_backtrace+0x0/0x270
> > [    7.422175] [<ffff000008088dbc>] show_stack+0x24/0x30
> > [    7.427211] [<ffff0000090d01f0>] dump_stack+0x98/0xb8
> > [    7.432246] [<ffff00000810118c>] ___might_sleep+0x104/0x128
> > [    7.437799] [<ffff000008101208>] __might_sleep+0x58/0x90
> > [    7.443097] [<ffff000008254a7c>] kmem_cache_alloc_trace+0x224/0x280
> > [    7.449347] [<ffff000008e9c938>] armpmu_alloc+0x30/0x168
> > [    7.454639] [<ffff000008e9d15c>] arm_pmu_acpi_cpu_starting+0x114/0x148
> > [    7.461151] [<ffff0000080d0f30>] cpuhp_invoke_callback+0xb8/0x760
> > [    7.467226] [<ffff0000080d1ec4>] cpuhp_thread_fun+0xa4/0x1b8
> > [    7.472872] [<ffff0000080f661c>] smpboot_thread_fn+0x174/0x250
> > [    7.478684] [<ffff0000080f18ec>] kthread+0x114/0x140
> > [    7.483632] [<ffff000008084774>] ret_from_fork+0x10/0x1c
> 
> I know Mark was doing some fixes in the ACPI notifier code here, so I've
> added him to CC.

Sorry for the delay on this; I have a rather hideous fix that I'll clean
up and post shortly.

Thanks,
Mark.
