From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/48] ACPI: update CONFIG_ACPI_PROCFS description
Date: Wed, 12 Jan 2011 05:19:23 -0500
Message-ID: <4464ed3b05de7a41ae55c74109cec8aeb138ce14.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:27 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Update CONFIG_ACPI_PROCFS description because the processor,
video and thermal zone procfs I/F have been removed.

Some ACPI drivers, e.g. button, have their procfs I/F always built in,
because we don't have sysfs I/F replacement at the moment.
But once we finish developing the sysfs I/F for these driver,
we need CONFIG_ACPI_PROCFS to enabled/disable the corresponding procfs I/F.

So just updating the description rather than removing this option,
although there is no procfs I/F depends on it for now.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a0c0365..ad370a1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
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
 
-- 
1.7.4.rc1.7.g2cf08

