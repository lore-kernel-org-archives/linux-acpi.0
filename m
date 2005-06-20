From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 1/4] arch/i386/pci/acpi.c Use for_each_pci_dev macro
Date: Mon, 20 Jun 2005 23:50:55 +0200
Message-ID: <20050620215054.814162000@nd47.coderock.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=for-each-pci-dev-arch_i386_pci_acpi.patch
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hanna Linder <hannal-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Maximilian Attems <janitor-Aga/KQc5HWxW3WIO4DnKWw@public.gmane.org>, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Hanna Linder <hannal-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>



Using the new for_each_pci_dev macro. Compiled and boot tested.

Signed-off-by: Hanna Linder <hannal-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Maximilian Attems <janitor-Aga/KQc5HWxW3WIO4DnKWw@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---
 acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/arch/i386/pci/acpi.c
===================================================================
--- quilt.orig/arch/i386/pci/acpi.c
+++ quilt/arch/i386/pci/acpi.c
@@ -38,7 +38,7 @@ static int __init pci_acpi_init(void)
 		 * don't use pci_enable_device().
 		 */
 		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	} else
 		printk(KERN_INFO "PCI: If a device doesn't work, try \"pci=routeirq\".  If it helps, post a report\n");

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
