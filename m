From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch (for 2.6.26?) 2/2] acpi: fix drivers/acpi/glue.c build
 error
Date: Tue, 10 Jun 2008 14:00:01 -0700
Message-ID: <20080610140001.c001e350.akpm@linux-foundation.org>
References: <200806092348.m59NmJnC015625@imap1.linux-foundation.org>
	<alpine.LFD.1.10.0806101212360.14381@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35698 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757616AbYFJVC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 17:02:26 -0400
In-Reply-To: <alpine.LFD.1.10.0806101212360.14381@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, mingo@elte.hu, bjorn.helgaas@hp.com

On Tue, 10 Jun 2008 12:14:08 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> 
> 
> On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > x86.git testing found the following build bug:
> > 
> >   drivers/built-in.o: In function `acpi_rtc_init':
> >   glue.c:(.init.text+0x16c3): undefined reference to `pnp_bus_type'
> > 
> > this tries to use PNP bus infrastructure even in the !PNP case.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/acpi/glue.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff -puN drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error drivers/acpi/glue.c
> > --- a/drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error
> > +++ a/drivers/acpi/glue.c
> > @@ -303,6 +303,7 @@ static void rtc_wake_off(struct device *
> >  
> >  static struct cmos_rtc_board_info rtc_info;
> >  
> > +#ifdef CONFIG_PNP
> >  
> >  /* PNP devices are registered in a subsys_initcall();
> >   * ACPI specifies the PNP IDs to use.
> > @@ -364,4 +365,6 @@ static int __init acpi_rtc_init(void)
> >  /* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
> >  fs_initcall(acpi_rtc_init);
> >  
> > +#endif /* CONFIG_PNP */
> > +
> >  #endif
> 
> ENOREPRODUCE
> 
> I'm unable to convince "make oldconfig" to allow a
> CONFIG_ACPI=y CONFIG_PNP=n build.
> 

ick, look at this thing:

 Symbol: PNP [=y]
 Prompt: Plug and Play support
   Defined at drivers/pnp/Kconfig:5
   Depends on: HAS_IOMEM && (ISA || ACPI) 
   Location:
     -> Device Drivers
   Selected by: ACPI && !X86_VOYAGER && !X86_NUMAQ && !X86_VISWS && !IA64_HP_SIM && (IA64 || X86) && PCI && PM

it's rather reliant upon select working as desired, which it often
doesn't.

Ingo usually provides a link to the offending .config, but this time he
didn't?

