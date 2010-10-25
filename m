From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 18:38:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1010251821260.3955@localhost6.localdomain6>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com> <1287992610-14996-10-git-send-email-ying.huang@intel.com> <20101025084553.GA27119@elte.hu> <1287997112.2862.322.camel@yhuang-dev> <20101025091913.GA17622@basil.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35975 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755923Ab0JYQjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 12:39:24 -0400
In-Reply-To: <20101025091913.GA17622@basil.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Luck <tony.luck@intel.com>

On Mon, 25 Oct 2010, Andi Kleen wrote:
> > > Sigh, please integrate all this into EDAC (drivers/edac/) properly, instead of 
> > > turning it into YET ANOTHER hardware vendor special hw-errors thing. We can do 
> > > better than this. EDAC is almost there: it has support for Nehalem, AMD, a couple
> > > of older chips.
> > 
> > I think APEI (ACPI Platform Error Interface) is another driver. Why
> > integrate two drivers?
> 
> Yes they're solving quite different problems from EDAC with different
> interfaces and for different devices in the ACPI space.
> 
> The earlier nack seems to be based on a lot of confusion on what the code 
> does.

Errm. That patch series carries a lot of other weird stuff including a
new "memory allocator", a new ioremap implementation private to the
acpi code and new character device driver for hardware error
reporting.

> Subject: [PATCH -v2 5/9] Hardware error device core
> 
> Hardware error device is a kind of device which can report hardware
> errors.  The examples of hardware error device include APEI GHES, PCIe
> AER, etc.
> 
> Hardware error device core in this patch provides common services for
> various hardware error devices.

But it does not even make an attempt to explain why this error
reporting cannot be done via the existing interfaces and why they
can't be extended to fit your needs. What's so special about APEI GHES
and PCIe AER that we need another incompatible "just fits your needs"
ABI which makes tooling folks deal with another completely different
interface ?

The only explanation I have is that you are simply not willing to work
with others and this is just another proof of a repeating problem.

Thanks,

	tglx
