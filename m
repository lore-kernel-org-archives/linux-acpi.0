From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re: Changeset "acpi: disable PCI links at boot again,
 fix ELCR" -> on-board nic adapter not working
Date: Fri, 24 Jun 2005 11:44:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241143520.11175@ppc970.osdl.org>
References: <42B7CF33.5090501@neoware.com> <42BA6639.9090402@neoware.com>
 <Pine.LNX.4.58.0506241100290.11175@ppc970.osdl.org> <200506241231.55760.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506241231.55760.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



On Fri, 24 Jun 2005, Bjorn Helgaas wrote:
> 
> My preference is to use acpi_register_gsi() rather than
> calling eisa_set_level_irq() directly.

Ok. Norbert, just because I'm anal, can you verify that that version also
fixes it before I commit it?

		Linus

> 
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -435,6 +435,12 @@ acpi_pci_irq_enable (
> >  		/* Interrupt Line values above 0xF are forbidden */
> >  		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> >  			printk(" - using IRQ %d\n", dev->irq);
> > +/* Pick one! */
> > +#if 1
> > +			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
> > +#else
> > +			eisa_set_level_irq(dev->irq);
> > +#endif
> >  			return_VALUE(0);
> >  		}
> >  		else {
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
