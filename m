From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/1] Fix help for ACPI_CONTAINER
Date: Wed, 09 Mar 2005 01:05:29 -0800
Message-ID: <200503090905.j2995sO4022116@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This is to fix Kconfig help of ACPI_CONTAINER that did not really help.  I
posted the patch before, but it seems that it has not applied yet.  Sorry
for the previous terrible help.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/Kconfig~fix-help-for-acpi_container drivers/acpi/Kconfig
--- 25/drivers/acpi/Kconfig~fix-help-for-acpi_container	2005-03-09 01:05:00.000000000 -0800
+++ 25-akpm/drivers/acpi/Kconfig	2005-03-09 01:05:00.000000000 -0800
@@ -328,8 +328,13 @@ config ACPI_CONTAINER
 	depends on EXPERIMENTAL
 	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
 	 ---help---
-	 	This is the ACPI generic container driver which supports
-		ACPI0004, PNP0A05 and PNP0A06 devices
+	  This allows _physical_ insertion and removal of CPUs and memory.
+	  This can be useful, for example, on NUMA machines that support
+	  ACPI based physical hotplug of nodes, or non-NUMA machines that
+	  support physical cpu/memory hot-plug.
+
+	  If one selects "m", this driver can be loaded with
+	  "modprobe acpi_container".
 
 endif	# ACPI
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
