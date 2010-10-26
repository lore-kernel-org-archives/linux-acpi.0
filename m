From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Tue, 26 Oct 2010 09:55:59 +0200
Message-ID: <20101026075559.GA9798@elte.hu>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
 <20101025084553.GA27119@elte.hu>
 <alpine.LFD.2.00.1010252058370.11036@localhost.localdomain>
 <alpine.LFD.2.00.1010260629560.3955@localhost6.localdomain6>
 <20101026072210.GE13036@elte.hu>
 <1288078222.2862.484.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34314 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab0JZH40 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 03:56:26 -0400
Content-Disposition: inline
In-Reply-To: <1288078222.2862.484.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, "Luck, Tony" <tony.luck@intel.com>


* Huang Ying <ying.huang@intel.com> wrote:

> On Tue, 2010-10-26 at 15:22 +0800, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > >From Kconfig:
> > > 
> > >   EDAC is designed to report errors in the core system.
> > >   These are low-level errors that are reported in the CPU or
> > >   supporting chipset or other subsystems:
> > >   memory errors, cache errors, PCI errors, thermal throttling, etc..
> > >   If unsure, select 'Y'.
> > > 
> > > So please explain why your error reporting is so different from the above that it 
> > > justifies a separate facility. And you better come up with a real good explanation 
> > > other than we looked at EDAC and it did not fit our needs.
> > 
> > Btw., it's not just about EDAC - the firmware can store Linux events 
> > persistently (beyond allowing the firmware to insert its own RAS events), that 
> > is obviously _hugely_ useful for kernel debugging in general. We could inject 
> > debugging events there and recover them after a crash, etc.
> 
> Yes. It can be used by other kernel subsystems other than RAS. A kernel API is 
> provided already. The design of the kernel API makes it easy to be used by various 
> kernel subsystems. As the first step, we plan to support saving kernel log before 
> panic and reading it back after reboot.

And that's the problem: we have good facilities already that deal with similar 
things. We have NMI-safe event logging, event enumeration, dump-on-panic code and 
all sorts of goodies there.

But what did Andi's guidance/design lead you to do instead?

You stuck a useful hw feature into a vendor specific area of the kernel and exported 
it to /dev/erst-dbg via a crappy ABI. You also did it in the worst possible 
imaginable way: you avoided talking to the people who maintain and know the 
RAS/EDAC/debugging/instrumentation code, and you tried to create an ABI to export it 
in the most raw form possible - limiting our future options.

All that done so that dealing with those pesky RAS/EDAC, instrumentation and core 
kernel people can be avoided? ;-)

Sucks IMHO.

Thanks,

	Ingo
