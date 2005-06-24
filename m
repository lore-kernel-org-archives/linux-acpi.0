From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: Changeset "acpi: disable PCI links at boot again, fix ELCR" -> on-board nic adapter not working
Date: Fri, 24 Jun 2005 12:31:55 -0600
Message-ID: <200506241231.55760.bjorn.helgaas@hp.com>
References: <42B7CF33.5090501@neoware.com> <42BA6639.9090402@neoware.com> <Pine.LNX.4.58.0506241100290.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0506241100290.11175-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 24 June 2005 12:01 pm, Linus Torvalds wrote:
> 
> On Thu, 23 Jun 2005, Norbert Federa wrote:
> > 
> > Everything confirmed.
> > I've added the one-liner to 2.6.12 and the on-board nic is working
> > fine now. Also your assumption wrt the usb-controllers was right.
> 
> Len, acpi-developers, please tell me which one you prefer.

I haven't heard from Len for a while, maybe he's on vacation?

My preference is to use acpi_register_gsi() rather than
calling eisa_set_level_irq() directly.

> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -435,6 +435,12 @@ acpi_pci_irq_enable (
>  		/* Interrupt Line values above 0xF are forbidden */
>  		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
>  			printk(" - using IRQ %d\n", dev->irq);
> +/* Pick one! */
> +#if 1
> +			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
> +#else
> +			eisa_set_level_irq(dev->irq);
> +#endif
>  			return_VALUE(0);
>  		}
>  		else {


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
