From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 1/1] arch/i386/pci/acpi.c Use for_each_pci_dev macro
Date: Sat, 05 Mar 2005 16:29:36 +0100
Message-ID: <20050305152937.6C73F1EE1E@trashy.coderock.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org, hannal-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, janitor-Aga/KQc5HWxW3WIO4DnKWw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org




Using the new for_each_pci_dev macro. Compiled and boot tested.

Signed-off-by: Hanna Linder <hannal-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Maximilian Attems <janitor-Aga/KQc5HWxW3WIO4DnKWw@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---


 kj-domen/arch/i386/pci/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/pci/acpi.c~for-each-pci-dev-arch_i386_pci_acpi arch/i386/pci/acpi.c
--- kj/arch/i386/pci/acpi.c~for-each-pci-dev-arch_i386_pci_acpi	2005-03-05 16:09:18.000000000 +0100
+++ kj-domen/arch/i386/pci/acpi.c	2005-03-05 16:09:18.000000000 +0100
@@ -41,7 +41,7 @@ static int __init pci_acpi_init(void)
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
