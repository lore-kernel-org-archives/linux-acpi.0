From: Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Changeset "acpi: disable PCI links at boot again, fix ELCR" ->
 on-board nic adapter not working
Date: Thu, 23 Jun 2005 09:35:21 +0200
Message-ID: <42BA6639.9090402@neoware.com>
References: <42B7CF33.5090501@neoware.com> <Pine.LNX.4.58.0506210901230.2268@ppc970.osdl.org> <42B843F6.7040704@neoware.com> <Pine.LNX.4.58.0506221245370.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0506221245370.2353-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 21 Jun 2005, Norbert Federa wrote:
> 
>>The difference basically is:
>>2.6.10-rc2-bk7:  ACPI: IRQ9 SCI: Level Trigger.
>>2.6.10-rc2-bk8:  ACPI: setting ELCR to 0200 (from 8a20)
> 
> 
> Ok. The original 8a20 mask is irq's 15, 11, 9, and 5. The new mask starts 
> out with irq9 (SCI) set up, and we should set the others to level as we 
> discover them (and enable them) as PCI interrupts.
> 
> Looking at your irq list:
> 
> 	  0:      54460          XT-PIC  timer
> 	  1:        168          XT-PIC  i8042
> 	  2:          0          XT-PIC  cascade
> **	  5:          0          XT-PIC  ehci_hcd
> **	  9:          0          XT-PIC  acpi
> **	 11:          0          XT-PIC  uhci_hcd
> 	 12:         89          XT-PIC  i8042
> 	 14:         45          XT-PIC  ide0
> **	 15:          0          XT-PIC  uhci_hcd, uhci_hcd, eth0
> 
> all of those other three irq's should definitely have triggered, and you
> should have ended up with exactly the same ELCR setting in the end. Sadly,
> we don't actually print out those changes, but since it's the on-board NIC
> adapter that's not working, I'll ignore the other irq's and just look at
> irq15. However, it would be interesting to know if you've tried the USB
> controllers at all? It sounds like _none_ of those should work either..
> 
> The VIA Rhine driver clearly sets up its IRQ and ACPI is happy:
> 
> 	via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
> 	ACPI: PCI interrupt 0000:00:12.0[A]: no GSI - using IRQ 15
> 
> (the USB drivers do the same things), and I think the magic note here is 
> the "no GSI".
> 
> That, in turn, causes the code to not call "acpi_register_gsi()", and that 
> in turn means that it never does the "eisa_set_level_irq()" call either.
> 
> I bet this appended one-liner will fix your problem.
> 
> Norbert, can you confirm?
> 
> Len, ACPI people, any reason not to do this?
> 
> 		Linus
> 
> ---
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -435,6 +435,7 @@ acpi_pci_irq_enable (
>  		/* Interrupt Line values above 0xF are forbidden */
>  		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
>  			printk(" - using IRQ %d\n", dev->irq);
> +			eisa_set_level_irq(dev->irq);
>  			return_VALUE(0);
>  		}
>  		else {
> 

Everything confirmed.
I've added the one-liner to 2.6.12 and the on-board nic is working
fine now. Also your assumption wrt the usb-controllers was right.

-- Norbert


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
