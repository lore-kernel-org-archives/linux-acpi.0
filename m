From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/4] bk-acpi alpha build fix
Date: Mon, 04 Apr 2005 23:57:11 -0700
Message-ID: <200504050657.j356vBUi032675@shell0.pdx.osdl.net>
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



ACPI doesn't work on alphas.

  CC      drivers/pci/quirks.o
distcc[25816] ERROR: compile on localhost failed
In file included from include/acpi/platform/acenv.h:123,
                 from include/acpi/acpi.h:53,
                 from include/linux/acpi.h:34,
                 from drivers/pci/quirks.c:21:
include/acpi/platform/aclinux.h:59:22: asm/acpi.h: No such file or directory
In file included from include/acpi/acpi.h:54,
                 from include/linux/acpi.h:34,
                 from drivers/pci/quirks.c:21:
include/acpi/actypes.h:110: error: parse error before "INT64"
include/acpi/actypes.h:110: warning: type defaults to `int' in declaration of `INT64'
include/acpi/actypes.h:110: warning: data definition has no type or storage class
include/acpi/actypes.h:111: error: parse error before "UINT64"
include/acpi/actypes.h:111: warning: type defaults to `int' in declaration of `UINT64'
include/acpi/actypes.h:111: warning: data definition has no type or storage class
In file included from drivers/pci/quirks.c:21:
include/linux/acpi.h:37:22: asm/acpi.h: No such file or directory


I chose to fix it in acpi.h.  Seems cleaner than adding an ifdef to quirks.c.

Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/include/linux/acpi.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN include/linux/acpi.h~bk-acpi-alpha-build-fix include/linux/acpi.h
--- 25/include/linux/acpi.h~bk-acpi-alpha-build-fix	2005-04-04 23:56:24.000000000 -0700
+++ 25-akpm/include/linux/acpi.h	2005-04-04 23:56:31.000000000 -0700
@@ -25,6 +25,8 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#ifdef CONFIG_ACPI
+
 #ifndef _LINUX
 #define _LINUX
 #endif
@@ -536,4 +538,5 @@ static inline int acpi_get_pxm(acpi_hand
 
 extern int pnpacpi_disabled;
 
-#endif /*_LINUX_ACPI_H*/
+#endif	/* CONFIG_ACPI */
+#endif	/* _LINUX_ACPI_H */
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
