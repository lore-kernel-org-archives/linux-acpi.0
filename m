From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] Fix help for ACPI_CONTAINER
Date: Wed, 16 Feb 2005 20:06:52 +0900
Message-ID: <20050216200652.2b46a2ce.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Anil Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This is to fix Kconfig help of ACPI_CONTAINER that did
not really help.  I posted the patch before, but it seems
that it has not applied yet.  Sorry for the previous terrible
help.

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 linux-2.6.11-rc4-kei/drivers/acpi/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/Kconfig~fix_help drivers/acpi/Kconfig
--- linux-2.6.11-rc4/drivers/acpi/Kconfig~fix_help	2005-02-16 19:54:48.000000000 +0900
+++ linux-2.6.11-rc4-kei/drivers/acpi/Kconfig	2005-02-16 19:55:40.000000000 +0900
@@ -339,7 +339,12 @@ config ACPI_CONTAINER
 	depends on ACPI && EXPERIMENTAL
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
 
 endmenu

_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
