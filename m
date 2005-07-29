From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: [RFC: 2.6 patch] enable ACPI_HOTPLUG_CPU automatically if HOTPLUG_CPU=y
Date: Sat, 30 Jul 2005 00:36:15 +0200
Message-ID: <20050729223615.GB5590@stusta.de>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Does the combination
- HOTPLUG_CPU=y
- ACPI_PROCESSOR=y
- ACPI_HOTPLUG_CPU=n
make any sense?

If not, please apply this patch.


Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>

---

This patch was already sent on:
- 12 Jul 2005

--- linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig.old	2005-07-12 21:45:41.000000000 +0200
+++ linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig	2005-07-12 21:46:04.000000000 +0200
@@ -153,12 +153,10 @@
 	  support it.
 
 config ACPI_HOTPLUG_CPU
-	bool "Processor Hotplug (EXPERIMENTAL)"
-	depends on ACPI_PROCESSOR && HOTPLUG_CPU && EXPERIMENTAL
+	bool
+	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
-	default n
-	 ---help---
-	 Select this option if your platform support physical CPU hotplug.
+	default y
 
 config ACPI_THERMAL
 	tristate "Thermal Zone"



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
