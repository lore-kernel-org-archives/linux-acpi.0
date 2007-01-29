From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/3] [-mm]: ACPI: add a Kconfig option for ACPI  procfs
	interface
Date: Mon, 29 Jan 2007 11:02:30 +0800
Message-ID: <1170039750.6907.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32932 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933108AbXA2DB5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Jan 2007 22:01:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Zhang Rui <rui.zhang@intel.com>

Add a kconfig option CONFIG_ACPI_PROCFS to make procfs interface
a configurable attribute of ACPI.

No procfs interface is actually deprecated,
and no sysfs interface is added in this patch.

CONGI_ACPI_PROCFS is used to mark procfs interface as deprecated
once the same function is duplicated in sysfs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/acpi/Kconfig                       |   10 ++++++++++
 2 files changed, 19 insertions(+)

Index: linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/Kconfig	2007-01-29 09:24:14.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig	2007-01-29 09:24:17.000000000 +0800
@@ -77,6 +77,16 @@ config ACPI_SLEEP_PROC_SLEEP
 	  Create /proc/acpi/sleep
 	  Deprecated by /sys/power/state
 
+config ACPI_PROCFS
+	bool "Procfs interface (deprecated)"
+	depends on ACPI
+	default y
+	---help---
+	  Procfs interface for ACPI is made optional for back-compatible.
+	  As the same functions are duplicated in sysfs interface
+	  and this proc interface will be removed some time later,
+	  it's marked as deprecated.
+
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
Index: linux-2.6.20-rc4-mm1/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.20-rc4-mm1.orig/Documentation/feature-removal-schedule.txt	2007-01-29 09:24:14.000000000 +0800
+++ linux-2.6.20-rc4-mm1/Documentation/feature-removal-schedule.txt	2007-01-29 09:27:02.000000000 +0800
@@ -264,3 +264,12 @@ Why:   OSS drivers with ALSA replacement
 Who:   Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
+
+What:	ACPI procfs interface
+When:	July 2007
+Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
+	in sysfs and the ACPI procfs interface should be removed.
+Who:	Zhang Rui <rui.zhang@intel.com>
+
+---------------------------
+
