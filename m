From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/4] CONFIG_ACPI=n build fix
Date: Mon, 04 Apr 2005 23:57:16 -0700
Message-ID: <200504050657.j356vG0I032687@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function `acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function `acpi_boot_init'
arch/i386/kernel/built-in.o(.init.text+0x17c4): In function `setup_sigcontext':
/usr/src/25/arch/i386/kernel/signal.c:299: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x17c9):/usr/src/25/arch/i386/kernel/signal.c:300: undefined reference to `acpi_boot_init'


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/include/linux/acpi.h |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff -puN include/linux/acpi.h~no-acpi-build-fix include/linux/acpi.h
--- 25/include/linux/acpi.h~no-acpi-build-fix	2005-04-04 23:56:26.000000000 -0700
+++ 25-akpm/include/linux/acpi.h	2005-04-04 23:56:26.000000000 -0700
@@ -418,16 +418,6 @@ extern int sbf_port ;
 
 #define acpi_mp_config	0
 
-static inline int acpi_boot_init(void)
-{
-	return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-	return 0;
-}
-
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
@@ -539,4 +529,15 @@ static inline int acpi_get_pxm(acpi_hand
 extern int pnpacpi_disabled;
 
 #endif	/* CONFIG_ACPI */
+
+static inline int acpi_boot_init(void)
+{
+	return 0;
+}
+
+static inline int acpi_boot_table_init(void)
+{
+	return 0;
+}
+
 #endif	/* _LINUX_ACPI_H */
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
