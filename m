From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/60] ACPI: Only processor needs CPU_IDLE
Date: Mon, 25 Oct 2010 02:20:43 -0400
Message-ID: <a4084c147bd06ecc13d787eec626ff1faf8f5851.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0JYHLF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:04 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

ACPI support itself doesn't need CPU_IDLE, only ACPI_PROCESSOR does,
so only ACPI_PROCESSOR should select CPU_IDLE.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 88681ac..79f4178 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -9,7 +9,6 @@ menuconfig ACPI
 	depends on PCI
 	depends on PM
 	select PNP
-	select CPU_IDLE
 	default y
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
@@ -206,6 +205,7 @@ config ACPI_DOCK
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
+	select CPU_IDLE
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux and uses
-- 
1.7.3.2.90.gd4c43

