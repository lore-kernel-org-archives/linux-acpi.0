From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 01/12] ia64 CONFIG_APCI_NUMA fix
Date: Wed, 23 Feb 2005 01:52:57 -0800
Message-ID: <200502230953.j1N9rC1c020690@shell0.pdx.osdl.net>
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



arch/ia64/kernel/smpboot.c:511:17: #error Fixme: Dunno how to build CPU-to-node 
map.

Seems that CONFIG_NUMA requires CONFIG_ACPI_NUMA.

Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/arch/ia64/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/ia64/Kconfig~ia64-config_apci_numa-fix arch/ia64/Kconfig
--- 25/arch/ia64/Kconfig~ia64-config_apci_numa-fix	2005-02-23 01:47:48.000000000 -0800
+++ 25-akpm/arch/ia64/Kconfig	2005-02-23 01:47:48.000000000 -0800
@@ -169,6 +169,7 @@ config NUMA
 	bool "NUMA support"
 	depends on !IA64_HP_SIM
 	default y if IA64_SGI_SN2
+	select ACPI_NUMA
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option is for configuring high-end multiprocessor
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
