From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 4/4] printk: drivers/acpi/pci_link.c
Date: Mon, 20 Jun 2005 23:50:58 +0200
Message-ID: <20050620215057.674778000@nd47.coderock.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=printk-drivers_acpi_pci_link.patch
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---
 pci_link.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/acpi/pci_link.c
===================================================================
--- quilt.orig/drivers/acpi/pci_link.c
+++ quilt/drivers/acpi/pci_link.c
@@ -352,7 +352,7 @@ acpi_pci_link_set (
 		/* ignore resource_source, it's optional */
 		break;
 	default:
-		printk("ACPI BUG: resource_type %d\n", link->irq.resource_type);
+		printk(KERN_WARNING "ACPI BUG: resource_type %d\n", link->irq.resource_type);
 		result = -EINVAL;
 		goto end;
 

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
