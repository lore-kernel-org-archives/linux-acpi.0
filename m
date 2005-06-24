From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: Changeset "acpi: disable PCI links at boot again, fix ELCR" ->
 on-board nic adapter not working
Date: Fri, 24 Jun 2005 11:01:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241100290.11175@ppc970.osdl.org>
References: <42B7CF33.5090501@neoware.com> <Pine.LNX.4.58.0506210901230.2268@ppc970.osdl.org>
 <42B843F6.7040704@neoware.com> <Pine.LNX.4.58.0506221245370.2353@ppc970.osdl.org>
 <42BA6639.9090402@neoware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42BA6639.9090402-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Thu, 23 Jun 2005, Norbert Federa wrote:
> 
> Everything confirmed.
> I've added the one-liner to 2.6.12 and the on-board nic is working
> fine now. Also your assumption wrt the usb-controllers was right.

Len, acpi-developers, please tell me which one you prefer.

		Linus

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -435,6 +435,12 @@ acpi_pci_irq_enable (
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
+/* Pick one! */
+#if 1
+			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
+#else
+			eisa_set_level_irq(dev->irq);
+#endif
 			return_VALUE(0);
 		}
 		else {


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
