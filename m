From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Sanitize ACPI Kconfig
Date: Fri, 7 Jan 2005 22:22:59 +0100
Message-ID: <20050107212259.GA13026@wotan.suse.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Sanitize ACPI Kconfig. No other subsystem uses default m for all its
options and surely there is no need to do this for the more obscure
modules. When you do make oldconfig with an old option and just press
return you tend to get a lot of modules you don't want with this. 
Normally new stuff is off by default.

I added default y for the processor driver which is important
for power saving, and for the others the user can decide but 
the default is off.

Also give a useful default for the cutoff year.

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

diff -u linux-2.6.10-bk6/drivers/acpi/Kconfig-o linux-2.6.10-bk6/drivers/acpi/Kconfig
--- linux-2.6.10-bk6/drivers/acpi/Kconfig-o	2005-01-04 12:15:18.000000000 +0100
+++ linux-2.6.10-bk6/drivers/acpi/Kconfig	2005-01-04 13:44:00.000000000 +0100
@@ -82,7 +82,6 @@
 	tristate "AC Adapter"
 	depends on X86
 	depends on ACPI_INTERPRETER
-	default m
 	help
 	  This driver adds support for the AC Adapter object, which indicates
 	  whether a system is on AC, or not.  Typically, only mobile systems 
@@ -92,7 +91,6 @@
 	tristate "Battery"
 	depends on X86
 	depends on ACPI_INTERPRETER
-	default m
 	help
 	  This driver adds support for battery information through
 	  /proc/acpi/battery. If you have a mobile system with a battery, 
@@ -102,7 +100,6 @@
 	tristate "Button"
 	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
-	default m
 	help
 	  This driver registers for events based on buttons, such as the
 	  power, sleep, and lid switch.  In the future, a daemon will read
@@ -115,7 +112,6 @@
 	depends on ACPI_INTERPRETER
 	depends on EXPERIMENTAL
 	depends on !IA64_SGI_SN
-	default m
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
@@ -129,7 +125,6 @@
 	tristate "Fan"
 	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
-	default m
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
 	  applications to perform basic fan control (on, off, status).
@@ -138,7 +133,7 @@
 	tristate "Processor"
 	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
-	default m
+	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
 	  ACPI C2 and C3 processor states to save power, on systems that
@@ -156,7 +151,7 @@
 config ACPI_THERMAL
 	tristate "Thermal Zone"
 	depends on ACPI_PROCESSOR
-	default m
+	default y
 	help
 	  This driver adds support for ACPI thermal zones.  Most mobile and
 	  some desktop systems support ACPI thermal zones.  It is HIGHLY
@@ -174,7 +169,6 @@
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
 	depends on ACPI_INTERPRETER
-	default m
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also
@@ -204,7 +198,6 @@
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
 	depends on ACPI_INTERPRETER
-	default m
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
@@ -218,7 +211,6 @@
 	tristate "Toshiba Laptop Extras"
 	depends on X86
 	depends on ACPI_INTERPRETER
-	default m
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
@@ -259,7 +251,7 @@
 
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year"
-	default 0
+	default 2001
 	help
 	  enter a 4-digit year, eg. 2001 to disable ACPI by default
 	  on platforms with DMI BIOS date before January 1st that year.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
