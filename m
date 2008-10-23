From: Len Brown <lenb@kernel.org>
Subject: [PATCH 081/122] panasonic-laptop: depends on ACPI
Date: Thu, 23 Oct 2008 02:38:55 -0400
Message-ID: <7ba427c2363d91d4221843a9ae601f90f8d928b9.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYJWGkV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FJ2IJ09H14@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:13 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

panasonic-laptop uses many acpi_*() functions so it should
depend on ACPI; otherwise there are approximately 70
warnings/errors generated.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4ed8357..ec21994 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -247,7 +247,7 @@ config MSI_LAPTOP
 
 config PANASONIC_LAPTOP
 	tristate "Panasonic Laptop Extras"
-	depends on X86 && INPUT
+	depends on X86 && INPUT && ACPI
         depends on BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to backlight control and hotkeys
-- 
1.5.5.1

