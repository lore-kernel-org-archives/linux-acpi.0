From: Huang Ying <ying.huang@intel.com>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 16:58:32 +0800
Message-ID: <1287997112.2862.322.camel@yhuang-dev>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
	 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
	 <20101025084553.GA27119@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31550 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0JYI6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 04:58:35 -0400
In-Reply-To: <20101025084553.GA27119@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Mon, 2010-10-25 at 16:45 +0800, Ingo Molnar wrote:
> * Huang Ying <ying.huang@intel.com> wrote:
> 
> > Generic Hardware Error Source provides a way to report platform
> > hardware errors (such as that from chipset). It works in so called
> > "Firmware First" mode, that is, hardware errors are reported to
> > firmware firstly, then reported to Linux by firmware. This way, some
> > non-standard hardware error registers or non-standard hardware link
> > can be checked by firmware to produce more valuable hardware error
> > information for Linux.
> > 
> > This patch adds POLL/IRQ/NMI notification types support.
> > 
> > Because the memory area used to transfer hardware error information
> > from BIOS to Linux can be determined only in NMI, IRQ or timer
> > handler, but general ioremap can not be used in atomic context, so a
> > special version of atomic ioremap is implemented for that.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  arch/x86/kernel/acpi/boot.c |    1 
> >  arch/x86/kernel/dumpstack.c |    1 
> >  drivers/acpi/apei/ghes.c    |  397 ++++++++++++++++++++++++++++++++++++--------
> >  kernel/panic.c              |    1 
> >  lib/ioremap.c               |    2 
> >  mm/vmalloc.c                |    1 
> >  6 files changed, 333 insertions(+), 70 deletions(-)
> 
> WTF?
> 
> Sigh, please integrate all this into EDAC (drivers/edac/) properly, instead of 
> turning it into YET ANOTHER hardware vendor special hw-errors thing. We can do 
> better than this. EDAC is almost there: it has support for Nehalem, AMD, a couple
> of older chips.

I think APEI (ACPI Platform Error Interface) is another driver. Why
integrate two drivers?

> Guys, instead of carving out a special driver area where you can produce crap 
> without anyone looking too much, and pretending that the EDAC code does not exist, 
> please try to work with others who are aiming higher and who are using saner 
> interfaces.
> 
> Just look at the higher level structure in drivers/acpi/apei/:
> 
>   apei-base.c  apei-internal.h  cper.c  einj.c  erst.c  erst-dbg.c  ghes.c  hest.c  Kconfig  Makefile
> 
> ghes, einj, cper, erst? Someone's been abbreviating too much.

Maybe they are not good name. But they are defined in ACPI
specification. Using the same name makes it easier for people to link
the specification to corresponding implementation.

> einj.c: it's about the 3rd separate 'error injection' concept that got introduced 
> ...

EINJ is a true platform feature, not just software feature. We need to
support it to debug various hardware error features.

Best Regards,
Huang Ying


