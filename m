From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Thu, 01 Dec 2016 22:17:54 +0100
Message-ID: <3848089.cIkXoRipBG@aspire.rjw.lan>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic> <1480511979-11722-1-git-send-email-prarit@redhat.com> <20161201200739.qcibekpe37podnmu@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161201200739.qcibekpe37podnmu@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 01, 2016 09:07:39 PM Borislav Petkov wrote:
> On Wed, Nov 30, 2016 at 08:19:39AM -0500, Prarit Bhargava wrote:
> > When removing and adding cpu 0 on a system with GHES NMI the following stack
> > trace is seen when re-adding the cpu:
> > 
> > WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1349 setup_local_APIC+
> > Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 nfs fscache coretemp intel_ra
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.0-rc6+ #2
> > Call Trace:
> >  dump_stack+0x63/0x8e
> >  __warn+0xd1/0xf0
> >  warn_slowpath_null+0x1d/0x20
> >  setup_local_APIC+0x275/0x370
> >  apic_ap_setup+0xe/0x20
> >  start_secondary+0x48/0x180
> >  set_init_arg+0x55/0x55
> >  early_idt_handler_array+0x120/0x120
> >  x86_64_start_reservations+0x2a/0x2c
> >  x86_64_start_kernel+0x13d/0x14c
> > 
> > During the cpu bringup, wakeup_cpu_via_init_nmi() is called and issues an
> > NMI on CPU 0.  The GHES NMI handler, ghes_notify_nmi() runs the
> > ghes_proc_irq_work work queue which ends up setting IRQ_WORK_VECTOR
> > (0xf6).  The "faulty" IR line set at arch/x86/kernel/apic/apic.c:1349 is  also
> > 0xf6 (specifically APIC IRR for irqs 255 to 224 is 0x400000) which confirms
> > that something has set the IRQ_WORK_VECTOR line prior to the APIC being
> > initialized.
> > 
> > Commit 2383844d4850 ("GHES: Elliminate double-loop in the NMI handler")
> > incorrectly modified the behavior such that the handler returns
> > NMI_HANDLED only if an error was processed, and incorrectly runs the ghes
> > work queue for every NMI.
> > 
> > This patch modifies the ghes_proc_irq_work() to run as it did prior to
> > 2383844d4850 ("GHES: Elliminate double-loop in the NMI handler") by
> > properly returning NMI_HANDLED and only calling the work queue if
> > NMI_HANDLED has been set.
> > 
> > v2: Borislav, setting of NMI_HANDLED moved & cleaned up changelog.
> > 
> > Fixes: 2383844d4850 ("GHES: Elliminate double-loop in the NMI handler")
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Cc: Tyler Baicar <tbaicar@codeaurora.org>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> > Cc: Don Zickus <dzickus@redhat.com>
> > ---
> >  drivers/acpi/apei/ghes.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

I guess I should pick up this one, then?

Thanks,
Rafael
