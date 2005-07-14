From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 1/1] drivers/acpi/system.c : remove unused brackets
Date: Fri, 15 Jul 2005 00:20:33 +0200
Message-ID: <20050714222033.509197000@homer>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=remove_brackets-drivers_acpi_system
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


Remove not used brackets

Signed-off-by: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---
 system.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/drivers/acpi/system.c
===================================================================
--- quilt.orig/drivers/acpi/system.c
+++ quilt/drivers/acpi/system.c
@@ -148,9 +148,8 @@ static int __init acpi_system_init (void
 		S_IRUGO, acpi_root_dir);
 	if (!entry)
 		goto Error;
-	else {
+	else
 		entry->proc_fops = &acpi_system_info_ops;
-	}
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
