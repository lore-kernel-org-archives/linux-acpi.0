From: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] remove obsolete IA64_SGI_SN checks from acpi Kconfig
Date: Mon, 21 Mar 2005 09:47:20 -0800
Message-ID: <200503210947.20559.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oiwPCpapRTSnUAm"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_oiwPCpapRTSnUAm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

IA64_SGI_SN hasn't been set for a long time now, so we can remove all 
references to it.  Noticed this when looking at the recent CONFIG_PM 
dependency issue (we can keep that dependency if you want, Len, I've sent 
Tony a fix for the ia64 tree that'll unbreak the build for sn2).

Signed-off-by: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>

Thanks,
Jesse

--Boundary-00=_oiwPCpapRTSnUAm
Content-Type: text/plain;
  charset="us-ascii";
  name="acpi-sgi-sn-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-sgi-sn-cleanup.patch"

===== drivers/acpi/Kconfig 1.45 vs edited =====
--- 1.45/drivers/acpi/Kconfig	2005-03-12 13:27:34 -08:00
+++ edited/drivers/acpi/Kconfig	2005-03-21 09:40:30 -08:00
@@ -49,7 +49,6 @@
 
 config ACPI_INTERPRETER
 	bool
-	depends on !IA64_SGI_SN
 	default y
 
 if ACPI_INTERPRETER
@@ -100,7 +99,6 @@
 
 config ACPI_BUTTON
 	tristate "Button"
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver registers for events based on buttons, such as the
@@ -112,7 +110,6 @@
 config ACPI_VIDEO
 	tristate "Video"
 	depends on EXPERIMENTAL
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
@@ -125,7 +122,6 @@
 
 config ACPI_FAN
 	tristate "Fan"
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
@@ -133,7 +129,6 @@
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
@@ -143,7 +138,6 @@
 config ACPI_HOTPLUG_CPU
 	bool "Processor Hotplug (EXPERIMENTAL)"
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU && EXPERIMENTAL
-	depends on !IA64_SGI_SN
 	select ACPI_CONTAINER
 	default n
 	 ---help---
@@ -263,7 +257,6 @@
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	depends on !IA64_SGI_SN
 	default n
 	help
 	  The ACPI driver can optionally report errors with a great deal
@@ -272,7 +265,6 @@
 
 config ACPI_BUS
 	bool
-	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_EC
@@ -286,17 +278,14 @@
 
 config ACPI_POWER
 	bool
-	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_PCI
 	bool
-	depends on !IA64_SGI_SN
 	default PCI
 
 config ACPI_SYSTEM
 	bool
-	depends on !IA64_SGI_SN
 	default y
 	help
 	  This driver will enable your system to shut down using ACPI, and

--Boundary-00=_oiwPCpapRTSnUAm--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
