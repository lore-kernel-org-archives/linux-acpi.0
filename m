From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/21] i7300_idle: Kconfig, show menu only on x86_64
Date: Thu, 06 Nov 2008 23:39:05 -0500
Message-ID: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37201 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbYKGEj2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:28 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00LPV4XRPDO0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:27 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

...since today it contains only a single driver
which is visible to just x86_64

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index 108264d..f15e90a 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -1,5 +1,6 @@
 
 menu "Memory power savings"
+depends on X86_64
 
 config I7300_IDLE_IOAT_CHANNEL
 	bool
@@ -7,7 +8,7 @@ config I7300_IDLE_IOAT_CHANNEL
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
 	select I7300_IDLE_IOAT_CHANNEL
-	depends on X86_64 && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Enable memory power savings when idle with certain Intel server
 	  chipsets. The chipset must have I/O AT support, such as the
-- 
1.5.6.5

