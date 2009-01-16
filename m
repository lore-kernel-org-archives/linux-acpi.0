From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/23] ACPI: thinkpad-acpi: handle HKEY event 6030
Date: Fri, 16 Jan 2009 15:25:01 -0500
Message-ID: <54926ce8d2db7ebcbc4b80aae2cec571cd793e46.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:41180 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759895AbZAPUZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK002UAZBT58N4@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:23:53 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

HKEY event 0x6030 is a helper for Lenovo's Advanced Thermal Management
Windows driver, which is, of course, completely undocumented.

Silence any warnings about it being an unknown alarm, and report it
unmodified for userspace.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 213219d..886a430 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2702,6 +2702,12 @@ static bool hotkey_notify_thermal(const u32 hkey,
 			"a sensor reports something is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		return true;
+	case 0x6030:
+		printk(TPACPI_INFO
+			"EC reports that Thermal Table has changed\n");
+		/* recommended action: do nothing, we don't have
+		 * Lenovo ATM information */
+		return true;
 	default:
 		printk(TPACPI_ALERT
 			 "THERMAL ALERT: unknown thermal alarm received\n");
-- 
1.5.6.6

