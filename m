From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 6/7] pci_link-pm_message_t-fix
Date: Wed, 27 Jul 2005 01:01:45 -0700
Message-ID: <200507270802.j6R82gCF009271@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/pci_link.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/acpi/pci_link.c~pci_link-pm_message_t-fix drivers/acpi/pci_link.c
--- devel/drivers/acpi/pci_link.c~pci_link-pm_message_t-fix	2005-07-14 15:53:50.000000000 -0700
+++ devel-akpm/drivers/acpi/pci_link.c	2005-07-14 15:53:50.000000000 -0700
@@ -719,10 +719,7 @@ end:
 	return_VALUE(result);
 }
 
-static int
-irqrouter_suspend(
-	struct sys_device *dev,
-	u32	state)
+static int irqrouter_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
