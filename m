From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/16] ACPI: Kconfig: CONFIG_ACPI_PROCFS now defaults to N
Date: Wed, 25 Jul 2007 01:51:20 -0400
Message-ID: <11853426972055-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18276 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbXGYFvj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:39 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <fb804714560463534ebcb538a3b0a3c687a830ec.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

delete "default y" from CONFIG_ACPI_PROCFS
(effectively making the default 'N')

List exactly what /proc files this option controls,
and clarify that it doesn't change non-deprecated files.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 408b451..8e42977 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -76,17 +76,24 @@ config ACPI_SLEEP_PROC_SLEEP
 	  Deprecated by /sys/power/state
 
 config ACPI_PROCFS
-	bool "Procfs interface (deprecated)"
-	default y
+	bool "Deprecated /proc/acpi files"
+	depends on PROC_FS
 	---help---
-	  The Procfs interface for ACPI is made optional for backward compatibility.
-	  As the same functions are duplicated in the sysfs interface
-	  and this proc interface will be removed some time later,
-	  it's marked as deprecated.
-	  ( /proc/acpi/debug_layer && debug_level are deprecated by
-	    /sys/module/acpi/parameters/debug_layer && debug_level.
-	    /proc/acpi/info is deprecated by
-	    /sys/module/acpi/parameters/acpica_version )
+	  For backwards compatibility, this option allows
+	  depricated /proc/acpi/ files to exist, even when
+	  they have been replaced by functions in /sys.
+	  The deprecated files (and their replacements) include:
+
+	  /proc/acpi/info (/sys/modules/acpi/parameters/acpica_version)
+	  /proc/acpi/dsdt (/sys/firmware/acpi/tables/DSDT)
+	  /proc/acpi/fadt (/sys/firmware/acpi/tables/FACP)
+	  /proc/acpi/debug_layer (/sys/module/acpi/parameters/debug_layer)
+	  /proc/acpi/debug_level (/sys/module/acpi/parameters/debug_level)
+
+	  This option has no effect on /proc/acpi/ files
+	  and functions which do not yet exist in /sys.
+
+	  Say N to delete /proc/acpi/ files that have moved to /sys/
 
 config ACPI_AC
 	tristate "AC Adapter"
-- 
1.5.3.rc2.22.g69a9b
