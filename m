From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/7] ACPI: updating the Kconfig file
Date: Mon, 06 Dec 2010 15:04:18 +0800
Message-ID: <1291619058.19296.577.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45104 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0LFHH2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Update the drivers/acpi/Kconfig file.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -52,11 +52,9 @@ config ACPI_PROCFS
 	  deprecated /proc/acpi/ files to exist, even when
 	  they have been replaced by functions in /sys.
 	  The deprecated files (and their replacements) include:
+	  /proc/acpi/ac/* (/sys/class/power_supply)
+	  /proc/acpi/battery/* (/sys/class/power_supply/)
 
-	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
-		cooling_device*/*)
-	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
-	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 


