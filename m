From: Len Brown <lenb@kernel.org>
Subject: [PATCH 95/98] ACPI: suspend: Add the Pansonic CF51 box to the dmi
 check table
Date: Sat, 28 Mar 2009 00:32:10 -0400
Message-ID: <c25226640b244902a50e1f9674503f33da5221d4.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38357 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822AbZC1Ed6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700ALZ8ODC8SW@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:49 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The Pansonic CF51-2L box can't be resumed if the boot option of
"acpi_sleep=old_ordering" is not added.

Add the Pansonic CF51-2L to the dmi check table so that the old suspend
order is used.

http://bugzilla.kernel.org/show_bug.cgi?id=12561

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 00456fc..5c8c2a4 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -394,6 +394,24 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L300"),
 		},
 	},
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Pansonic CF51-2L",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR,
+				"Matsushita Electric Industrial Co.,Ltd."),
+		DMI_MATCH(DMI_BOARD_NAME, "CF51-2L"),
+		},
+	},
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Pansonic CF51-2L",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR,
+				"Matsushita Electric Industrial Co.,Ltd."),
+		DMI_MATCH(DMI_BOARD_NAME, "CF51-2L"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.6.0.6

