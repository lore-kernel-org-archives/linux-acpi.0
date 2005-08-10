From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Disable slow duplicate object tracking in ACPI_DEBUG
Date: Wed, 10 Aug 2005 13:32:55 +0200
Message-ID: <20050810113255.GK19772@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The current SUSE 10.0 beta has CONFIG_ACPI_DEBUG enabled. That lead
to severe slowdowns on several machines. One issue was the different
default for ec_burst_mode. Another one was that the object tracking
would always walk the full list of all objects, which lead to kacpid
needing up to 25% of the total CPU time.

This patch disables the slow list walking. It could be probably
replaced with a hash or similar too, but I don't think the duplicate
object tracking is too useful anaywys so I just disabled it.

-Andi

From: ak-l3A5Bk7waGM@public.gmane.org
Subject: Disable linear search in ACPI debugging
Suse-bugzilla: 102565

Looking through all the memory objects all the time is just too slow.
Don't do it.


Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

Index: linux-2.6.13rc5/drivers/acpi/utilities/utalloc.c
===================================================================
--- linux-2.6.13rc5.orig/drivers/acpi/utilities/utalloc.c
+++ linux-2.6.13rc5/drivers/acpi/utilities/utalloc.c
@@ -674,6 +674,9 @@ acpi_ut_find_allocation (
 {
 	struct acpi_debug_mem_block     *element;
 
+	/* too slow to be usable */
+	return NULL;
+
 
 	ACPI_FUNCTION_ENTRY ();
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
