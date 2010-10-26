From: Huang Ying <ying.huang@intel.com>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Tue, 26 Oct 2010 16:32:46 +0800
Message-ID: <1288081966.2862.571.camel@yhuang-dev>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
	 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
	 <20101025084553.GA27119@elte.hu>
	 <alpine.LFD.2.00.1010252058370.11036@localhost.localdomain>
	 <alpine.LFD.2.00.1010260629560.3955@localhost6.localdomain6>
	 <20101026072210.GE13036@elte.hu> <1288078222.2862.484.camel@yhuang-dev>
	 <20101026075559.GA9798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26793 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0JZIcv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 04:32:51 -0400
In-Reply-To: <20101026075559.GA9798@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, "Luck, Tony" <tony.luck@intel.com>

On Tue, 2010-10-26 at 15:55 +0800, Ingo Molnar wrote:
> * Huang Ying <ying.huang@intel.com> wrote:
> 
> > On Tue, 2010-10-26 at 15:22 +0800, Ingo Molnar wrote:
> > > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > > >From Kconfig:
> > > > 
> > > >   EDAC is designed to report errors in the core system.
> > > >   These are low-level errors that are reported in the CPU or
> > > >   supporting chipset or other subsystems:
> > > >   memory errors, cache errors, PCI errors, thermal throttling, etc..
> > > >   If unsure, select 'Y'.
> > > > 
> > > > So please explain why your error reporting is so different from the above that it 
> > > > justifies a separate facility. And you better come up with a real good explanation 
> > > > other than we looked at EDAC and it did not fit our needs.
> > > 
> > > Btw., it's not just about EDAC - the firmware can store Linux events 
> > > persistently (beyond allowing the firmware to insert its own RAS events), that 
> > > is obviously _hugely_ useful for kernel debugging in general. We could inject 
> > > debugging events there and recover them after a crash, etc.
> > 
> > Yes. It can be used by other kernel subsystems other than RAS. A kernel API is 
> > provided already. The design of the kernel API makes it easy to be used by various 
> > kernel subsystems. As the first step, we plan to support saving kernel log before 
> > panic and reading it back after reboot.
> 
> And that's the problem: we have good facilities already that deal with similar 
> things. We have NMI-safe event logging, event enumeration, dump-on-panic code and 
> all sorts of goodies there.

We have provided an in-kernel API for ERST now. And we plan to implement
a kmsg_dumper with ERST. And maybe implement some output support (maybe
via some /dev/kmsg extension) for kmsg_dumper if necessary.

Best Regards,
Huang Ying


