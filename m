From: Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Changeset "acpi: disable PCI links at boot again,
	fix ELCR" -> on-board nic adapter not working
Date: Sat, 02 Jul 2005 12:34:58 +0200
Message-ID: <1120300498.1171.3.camel@localhost.localdomain>
References: <42B7CF33.5090501@neoware.com> <42BA6639.9090402@neoware.com>
	 <Pine.LNX.4.58.0506241100290.11175@ppc970.osdl.org>
	 <200506241231.55760.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0506241143520.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0506241143520.11175-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
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
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > My preference is to use acpi_register_gsi() rather than
> > calling eisa_set_level_irq() directly.
> 
> Ok. Norbert, just because I'm anal, can you verify that that version also
> fixes it before I commit it?

It appears this change:

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -435,6 +435,7 @@ acpi_pci_irq_enable (
                /* Interrupt Line values above 0xF are forbidden */
                if (dev->irq >= 0 && (dev->irq <= 0xF)) {
                        printk(" - using IRQ %d\n", dev->irq);
+                       acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
                        return_VALUE(0);
                }
                else {


Caused some problems reported at:
http://bugme.osdl.org/show_bug.cgi?id=4824

Will the acpi guys reassign this bug to them?



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
