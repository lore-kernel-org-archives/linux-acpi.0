From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 2/2] printk: drivers/acpi/pci_link.c
Date: Fri, 08 Apr 2005 09:50:34 +0200
Message-ID: <20050408075035.16A7C1EE91@trashy.coderock.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org, clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---


 kj-domen/drivers/acpi/pci_link.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/pci_link.c~printk-drivers_acpi_pci_link drivers/acpi/pci_link.c
--- kj/drivers/acpi/pci_link.c~printk-drivers_acpi_pci_link	2005-04-05 12:57:57.000000000 +0200
+++ kj-domen/drivers/acpi/pci_link.c	2005-04-05 12:57:57.000000000 +0200
@@ -352,7 +352,7 @@ acpi_pci_link_set (
 		/* ignore resource_source, it's optional */
 		break;
 	default:
-		printk("ACPI BUG: resource_type %d\n", link->irq.resource_type);
+		printk(KERN_WARNING "ACPI BUG: resource_type %d\n", link->irq.resource_type);
 		result = -EINVAL;
 		goto end;
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
