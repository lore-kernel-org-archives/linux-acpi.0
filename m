From: Thomas Renninger <trenn@suse.de>
Subject: Re: Attempting to patch DSDT to get HPET working
Date: Sun, 09 Sep 2007 19:07:05 +0200
Message-ID: <1189357625.9141.8.camel@prodigy.site>
References: <f9d2a5e10708292220n78e65f1ci9be27ee42e41ea6f@mail.gmail.com>
	 <200709081347.08174.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59907 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758029AbXIIRHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Sep 2007 13:07:08 -0400
In-Reply-To: <200709081347.08174.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Russ Dill <russ.dill@gmail.com>, linux-acpi@vger.kernel.org

On Sat, 2007-09-08 at 13:47 -0600, Bjorn Helgaas wrote:
> On Wednesday 29 August 2007 11:20:47 pm Russ Dill wrote:
> > I have an AMD SB460 southbridge (has HPET), but a BIOS with no HPET
> > support.
> > ...
> > I added this:
> > 
> > Device (HPET)
> > {
> >     Name (_HID, EisaId ("PNP0103"))
> >     Name (BUF0, ResourceTemplate ()
> >     {
> >         IRQNoFlags () {0}
> >         IRQNoFlags () {8}
> >         Memory32Fixed (ReadOnly, 0xFED00000, 0x00000400)
> >     })
> > 
> >     Method (_STA, 0, NotSerialized)
> >     {
> >          Return (0x0F)
> >     }
> > 
> >     Method (_CRS, 0, Serialized)
> >     {
> >         CreateDWordField (BUF0, 0x0A, HPT0)
> >         Store (0xFED01000, HPT0)
> >         Return (BUF0)
> >     }
> > }
> > 
> > ... I get the following message:
> > 
> > hpet_acpi_add: no address or irqs in _CRS
> > 
> > So, good news, drivers/char/hpet.c is finding my PNP0103 entry. Bad
> > news, its having a problem with the resources. Any clue why?
> 
> If you look at drivers/char/hpet.c:hpet_resources(), you'll see that
> it's fairly simple-minded.  In particular, hpet_acpi_add() requires
> both an address and an IRQ, but hpet_resources() only looks at
> ACPI_RESOURCE_TYPE_EXTENDED_IRQ items.
> 
> I'm not an AML expert, but my guess is that your AML generates a
> plain ACPI_RESOURCE_TYPE_IRQ, not an EXTENDED_IRQ item.  If you can
> write AML that generates an EXTENDED_IRQ item, I bet it will work.
> 
> This is a bug in the HPET driver.  I think the right way to fix it
> is to convert it from an ACPI driver to a PNP driver and let PNPACPI
> do the resource parsing.  That conversion is held up a bit right now
> because PNP doesn't support enough IRQ descriptors for many HPETs,
> but Thomas Renninger is working on the necessary PNP enhancements.

AFAIK AMD provides a separate HPET table normally and Intel makes use of
an HPET AML device (the later should work, also without PNPACPI, I never
looked at the code, but I bet Bjorn is right and there can be done some
cleanups).
Can you document this matter in a bugzilla.kernel.org entry (also attach
full acpidump output), add me to CC (or assign it to me) and ping me
again in some days if I do not answer.
Whether a separate HPET table is also provided can be checked with:
acpidump >acpidump
acpixtract -a acpidump   (with latest acpica/pmtools)

Thanks,

   Thomas

