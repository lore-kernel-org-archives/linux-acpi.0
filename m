From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: fix Kconfig entries for ibm-acpi bay and dock
Date: Sat, 30 Dec 2006 17:26:49 -0200
Message-ID: <20061230192649.13533.53575.stgit@thorin.khazad-dum.debian.net>
References: <20061230192618.13533.29790.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42022 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030301AbWL3T0r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Dec 2006 14:26:47 -0500
In-Reply-To: <20061230192618.13533.29790.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, hmh@khazad-dum.debian.net
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Support for ACPI_BAY has not been merged in mainline yet.  Usage of
"depends on FOO=n" fails if FOO is undefined, thus ibm-acpi support
for bay was being made non-available in a kernel that has no other
sort of bay support.

Fix it to use "depends on ! FOO" instead, that does the right thing
when FOO is undefined.  Fix ACPI_IBM_DOCK accordingly as well while
at it, and also improve the help text.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/Kconfig |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index aa884d8..95de81f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -213,26 +213,29 @@ config ACPI_IBM
 config ACPI_IBM_DOCK
 	bool "Legacy Docking Station Support"
 	depends on ACPI_IBM
-	depends on ACPI_DOCK=n
-	default n
+	depends on ! ACPI_DOCK
+	default y
 	---help---
 	  Allows the ibm_acpi driver to handle docking station events.
 	  This support is obsoleted by CONFIG_HOTPLUG_PCI_ACPI.  It will
 	  allow locking and removing the laptop from the docking station,
 	  but will not properly connect PCI devices.
 
-	  If you are not sure, say N here.
+	  If you are not sure, select ACPI_DOCK instead.
 
 config ACPI_IBM_BAY
 	bool "Legacy Removable Bay Support"
 	depends on ACPI_IBM
-	depends on ACPI_BAY=n
-	default n
+	depends on ! ACPI_BAY
+	default y
 	---help---
 	  Allows the ibm_acpi driver to handle removable bays.
-	  This support is obsoleted by CONFIG_ACPI_BAY.
+	  This support is obsoleted by CONFIG_ACPI_BAY.  It will allow
+	  enabling and disabling devices in the removable bays, but it
+	  will not properly add or remove the devices from the kernel,
+	  which must be done manually by userspace scripts.
 
-	  If you are not sure, say N here.
+	  If you are not sure, select ACPI_BAY instead if it is available.
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"


--  
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
