From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 02/12] ia64 acpi build fix
Date: Wed, 23 Feb 2005 01:52:58 -0800
Message-ID: <200502230953.j1N9rCep020693@shell0.pdx.osdl.net>
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



arch/ia64/kernel/acpi.c: In function `acpi_map_iosapic':
arch/ia64/kernel/acpi.c:822: error: `MAX_PXM_DOMAINS' undeclared (first use in this function)
arch/ia64/kernel/acpi.c:822: error: (Each undeclared identifier is reported only once
arch/ia64/kernel/acpi.c:822: error: for each function it appears in.)
arch/ia64/kernel/acpi.c:827: error: `pxm_to_nid_map' undeclared (first use in this function)


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/arch/ia64/kernel/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ia64/kernel/acpi.c~ia64-acpi-build-fix arch/ia64/kernel/acpi.c
--- 25/arch/ia64/kernel/acpi.c~ia64-acpi-build-fix	2005-02-23 01:47:50.000000000 -0800
+++ 25-akpm/arch/ia64/kernel/acpi.c	2005-02-23 01:47:50.000000000 -0800
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(acpi_unmap_lsapic);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
  
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_ACPI_NUMA
 acpi_status __init
 acpi_map_iosapic (acpi_handle handle, u32 depth, void *context, void **ret)
 {
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
