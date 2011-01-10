From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI: update CONFIG_ACPI_PROCFS description
Date: Mon, 10 Jan 2011 11:16:26 +0800
Message-ID: <1294629386.1866.50.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15188 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab1AJDRt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Jan 2011 22:17:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Update CONFIG_ACPI_PROCFS description because the processor,
video and thermal zone procfs I/F have been removed.

Some ACPI drivers, e.g. button, have their procfs I/F always built in,
because we don't have sysfs I/F replacement at the moment.
But once we finish developing the sysfs I/F for these driver,
we need CONFIG_ACPI_PROCFS to enabled/disable the corresponding procfs I/F.

So just updating the description rather than removing this option,
although there is no procfs I/F depends on it for now.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -51,12 +51,7 @@ config ACPI_PROCFS
 	  For backwards compatibility, this option allows
 	  deprecated /proc/acpi/ files to exist, even when
 	  they have been replaced by functions in /sys.
-	  The deprecated files (and their replacements) include:
 
-	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
-		cooling_device*/*)
-	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
-	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 


