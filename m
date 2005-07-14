From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/7] acpi-ext build fix
Date: Thu, 14 Jul 2005 15:54:38 -0700
Message-ID: <200507142255.j6EMtLOK010352@shell0.pdx.osdl.net>
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

In file included from /usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:18:
include2/asm/acpi-ext.h:15: error: parse error before "hp_acpi_csr_space"
include2/asm/acpi-ext.h:15: error: parse error before "u64"
include2/asm/acpi-ext.h:15: warning: type defaults to `int' in declaration of `hp_acpi_csr_space'


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 include/asm-ia64/acpi-ext.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/asm-ia64/acpi-ext.h~acpi-ext-build-fix include/asm-ia64/acpi-ext.h
--- devel/include/asm-ia64/acpi-ext.h~acpi-ext-build-fix	2005-07-14 15:46:06.000000000 -0700
+++ devel-akpm/include/asm-ia64/acpi-ext.h	2005-07-14 15:46:06.000000000 -0700
@@ -11,6 +11,7 @@
 #define _ASM_IA64_ACPI_EXT_H
 
 #include <linux/types.h>
+#include <acpi/actypes.h>
 
 extern acpi_status hp_acpi_csr_space (acpi_handle, u64 *base, u64 *length);
 
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
