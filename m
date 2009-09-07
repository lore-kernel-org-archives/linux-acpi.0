From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] acpi: make ACPI_DOCK a tristate option again (v2)
Date: Mon, 07 Sep 2009 08:59:57 +0100
Message-ID: <4AA4D99D0200007800013B7C@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:24841 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZIGH75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 03:59:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

I cannot follow the explanation in commit
898b054f3eec5921320ae8614b5bdd7b07ea5b43: If other drivers require the
dock module to be loaded before them, they sould simply have a
dependency on dock.ko. In the particular case mentioned (libata), this
already is the case.

(Change from v1 is that no adjustment to drivers/libata/Kconfig is needed;
no sure what lead me to believe that change would be necessary.)

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Shaohua Li <shaohua.li@intel.com>

---
 drivers/acpi/Kconfig  |    2 +-
 drivers/acpi/Makefile |    2 +-
 drivers/acpi/osl.c    |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.31-rc8/drivers/acpi/Kconfig	2009-08-28 14:54:27.000000000 +0200
+++ 2.6.31-rc8-acpi-dock-module/drivers/acpi/Kconfig	2009-08-19 13:28:12.000000000 +0200
@@ -171,7 +171,7 @@ config ACPI_FAN
 	  the module will be called fan.
 
 config ACPI_DOCK
-	bool "Dock"
+	tristate "Dock"
 	depends on EXPERIMENTAL
 	help
 	  This driver supports ACPI-controlled docking stations and removable
--- linux-2.6.31-rc8/drivers/acpi/Makefile	2009-06-10 05:05:27.000000000 +0200
+++ 2.6.31-rc8-acpi-dock-module/drivers/acpi/Makefile	2009-08-19 13:31:37.000000000 +0200
@@ -32,7 +32,6 @@ acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 acpi-y				+= bus.o glue.o
 acpi-y				+= scan.o
 acpi-y				+= ec.o
-acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 acpi-y				+= power.o
 acpi-y				+= system.o event.o
@@ -54,6 +53,7 @@ obj-$(CONFIG_ACPI_CONTAINER)	+= containe
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY) += acpi_memhotplug.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
+obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 
--- linux-2.6.31-rc8/drivers/acpi/osl.c	2009-08-28 14:54:27.000000000 +0200
+++ 2.6.31-rc8-acpi-dock-module/drivers/acpi/osl.c	2009-09-04 08:47:50.000000000 +0200
@@ -803,6 +803,7 @@ acpi_status acpi_os_hotplug_execute(acpi
 {
 	return __acpi_os_execute(0, function, context, 1);
 }
+EXPORT_SYMBOL_GPL(acpi_os_hotplug_execute);
 
 void acpi_os_wait_events_complete(void *context)
 {


