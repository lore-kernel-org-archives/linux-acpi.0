From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/1] bk-acpi-acpi_pci_irq_disable build fix
Date: Sat, 12 Mar 2005 01:57:26 -0800
Message-ID: <200503120957.j2C9vs7u000794@shell0.pdx.osdl.net>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



drivers/acpi/pci_irq.c: In function `acpi_pci_irq_disable':
drivers/acpi/pci_irq.c:495: error: too few arguments to function `acpi_pci_irq_lookup'
drivers/acpi/pci_irq.c:502: error: too few arguments to function `acpi_pci_irq_derive'

Wild-assed guess:

Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/pci_irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/pci_irq.c~bk-acpi-acpi_pci_irq_disable-build-fix drivers/acpi/pci_irq.c
--- 25/drivers/acpi/pci_irq.c~bk-acpi-acpi_pci_irq_disable-build-fix	2005-03-12 01:57:08.000000000 -0800
+++ 25-akpm/drivers/acpi/pci_irq.c	2005-03-12 01:57:08.000000000 -0800
@@ -482,14 +482,14 @@ acpi_pci_irq_disable (
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
  	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
-				  &edge_level, &active_high_low);
+				  &edge_level, &active_high_low, NULL);
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
 	if (gsi < 0)
  		gsi = acpi_pci_irq_derive(dev, pin,
-					  &edge_level, &active_high_low);
+					  &edge_level, &active_high_low, NULL);
 	if (gsi < 0)
 		return_VOID;
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
