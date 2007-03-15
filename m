From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: move driver to drivers/misc hierarchy
Date: Thu, 15 Mar 2007 00:12:51 -0300
Message-ID: <20070315031251.GB6292@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <200703112054.41560.lenb@kernel.org> <20070312012700.GB19808@khazad-dum.debian.net> <20070315031015.GA6292@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38610 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965013AbXCODNA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Mar 2007 23:13:00 -0400
Content-Disposition: inline
In-Reply-To: <20070315031015.GA6292@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

ibm-acpi is not an ACPICA driver, so move it to drivers/misc as per Len
Brown's request.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/Kconfig              |   37 -------------------------------------
 drivers/acpi/Makefile             |    1 -
 drivers/misc/Kconfig              |   37 +++++++++++++++++++++++++++++++++++++
 drivers/misc/Makefile             |    1 +
 drivers/{acpi => misc}/ibm_acpi.c |    0 
 drivers/{acpi => misc}/ibm_acpi.h |    0 
 6 files changed, 38 insertions(+), 38 deletions(-)
 rename drivers/{acpi => misc}/ibm_acpi.c (100%)
 rename drivers/{acpi => misc}/ibm_acpi.h (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e2ce4a9..45c4315 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -218,43 +218,6 @@ config ACPI_ASUS
 	  NOTE: This driver is deprecated and will probably be removed soon,
 	  use asus-laptop instead.
 
-config ACPI_IBM
-	tristate "IBM ThinkPad Laptop Extras"
-	depends on X86
-	select BACKLIGHT_CLASS_DEVICE
-	---help---
-	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
-	  support for Fn-Fx key combinations, Bluetooth control, video
-	  output switching, ThinkLight control, UltraBay eject and more.
-	  For more information about this driver see <file:Documentation/ibm-acpi.txt>
-	  and <http://ibm-acpi.sf.net/> .
-
-	  If you have an IBM ThinkPad laptop, say Y or M here.
-
-config ACPI_IBM_DOCK
-	bool "Legacy Docking Station Support"
-	depends on ACPI_IBM
-	depends on ACPI_DOCK=n
-	default n
-	---help---
-	  Allows the ibm_acpi driver to handle docking station events.
-	  This support is obsoleted by CONFIG_HOTPLUG_PCI_ACPI.  It will
-	  allow locking and removing the laptop from the docking station,
-	  but will not properly connect PCI devices.
-
-	  If you are not sure, say N here.
-
-config ACPI_IBM_BAY
-	bool "Legacy Removable Bay Support"
-	depends on ACPI_IBM
-	default y
-	---help---
-	  Allows the ibm_acpi driver to handle removable bays.  It will allow
-	  disabling the device in the bay, and also generate notifications when
-	  the bay lever is ejected or inserted.
-
-	  If you are not sure, say Y here.
-
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5956e9f..92642ab 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
-obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 80b199f..5d2bcbf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -122,4 +122,41 @@ config SONY_LAPTOP
 
 	  Read <file:Documentation/sony-laptop.txt> for more information.
 
+config ACPI_IBM
+	tristate "IBM ThinkPad Laptop Extras"
+	depends on X86 && ACPI
+	select BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
+	  support for Fn-Fx key combinations, Bluetooth control, video
+	  output switching, ThinkLight control, UltraBay eject and more.
+	  For more information about this driver see <file:Documentation/ibm-acpi.txt>
+	  and <http://ibm-acpi.sf.net/> .
+
+	  If you have an IBM ThinkPad laptop, say Y or M here.
+
+config ACPI_IBM_DOCK
+	bool "Legacy Docking Station Support"
+	depends on ACPI_IBM
+	depends on ACPI_DOCK=n
+	default n
+	---help---
+	  Allows the ibm_acpi driver to handle docking station events.
+	  This support is obsoleted by CONFIG_HOTPLUG_PCI_ACPI.  It will
+	  allow locking and removing the laptop from the docking station,
+	  but will not properly connect PCI devices.
+
+	  If you are not sure, say N here.
+
+config ACPI_IBM_BAY
+	bool "Legacy Removable Bay Support"
+	depends on ACPI_IBM
+	default y
+	---help---
+	  Allows the ibm_acpi driver to handle removable bays.  It will allow
+	  disabling the device in the bay, and also generate notifications when
+	  the bay lever is ejected or inserted.
+
+	  If you are not sure, say Y here.
+
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7793ccd..848b398 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
+obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/misc/ibm_acpi.c
similarity index 100%
rename from drivers/acpi/ibm_acpi.c
rename to drivers/misc/ibm_acpi.c
diff --git a/drivers/acpi/ibm_acpi.h b/drivers/misc/ibm_acpi.h
similarity index 100%
rename from drivers/acpi/ibm_acpi.h
rename to drivers/misc/ibm_acpi.h
-- 
1.5.0.3

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
