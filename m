From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 2/7] CONFIG_ACPI=n build fix
Date: Wed, 27 Jul 2005 01:01:31 -0700
Message-ID: <200507270802.j6R82R5T009258@shell0.pdx.osdl.net>
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


From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function `acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function `acpi_boot_init'
arch/i386/kernel/built-in.o(.init.text+0x17c4): In function `setup_sigcontext':
/usr/src/25/arch/i386/kernel/signal.c:299: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x17c9):/usr/src/25/arch/i386/kernel/signal.c:300: undefined reference to `acpi_boot_init'


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 include/linux/acpi.h |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff -puN include/linux/acpi.h~no-acpi-build-fix include/linux/acpi.h
--- devel/include/linux/acpi.h~no-acpi-build-fix	2005-07-14 15:53:20.000000000 -0700
+++ devel-akpm/include/linux/acpi.h	2005-07-14 15:53:20.000000000 -0700
@@ -433,16 +433,6 @@ extern int sbf_port ;
 
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
@@ -553,5 +543,17 @@ static inline int acpi_get_pxm(acpi_hand
 
 extern int pnpacpi_disabled;
 
+#else	/* CONFIG_ACPI */
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
 #endif	/* CONFIG_ACPI */
 #endif	/*_LINUX_ACPI_H*/
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
