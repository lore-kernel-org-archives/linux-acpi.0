From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 5/7] ACPI: Re-enable C2/C3 CPU states for systems without CST
Date: Wed, 27 Jul 2005 01:01:44 -0700
Message-ID: <200507270802.j6R82ekd009267@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Jindrich Makovicka <makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org>

Re-enable C2/C3 states for systems without CST.  Fixes a regression after
the patch for C2/C3 support for multiprocessors
(http://bugme.osdl.org/show_bug.cgi?id=4401), which accidentally removed
the acpi_processor_power_verify() call.

Signed-off-by: Jindrich Makovicka <makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without	2005-07-14 15:53:47.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2005-07-14 15:53:47.000000000 -0700
@@ -881,7 +881,7 @@ static int acpi_processor_get_power_info
 	result = acpi_processor_get_power_info_cst(pr);
 	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if (result)
+		if ((result) || acpi_processor_power_verify(pr) < 2)
 			result = acpi_processor_get_power_info_default_c1(pr);
 	}
 
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
