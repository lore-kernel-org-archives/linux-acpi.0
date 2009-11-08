From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/12] ACPI: sleep: another HP/Compaq DMI entries for
 init_set_sci_en_on_resume
Date: Sat, 07 Nov 2009 21:57:14 -0500
Message-ID: <2839d396e3ae0891c1fdd87aa1cea218e6f5c4df.1257648660.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:23526 "EHLO
	vms173001.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753502AbZKHDQj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 22:16:39 -0500
Received: from localhost.localdomain ([unknown] [74.104.150.83])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KSR002CFT3MLQJ0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 21:16:42 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vaibhav Verma <vaibhav.verma86@gmail.com>, Len Brown <len.brown@intel.com>

From: Vaibhav Verma <vaibhav.verma86@gmail.com>

http://bugzilla.kernel.org/show_bug.cgi?id=13745

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index ed9760a..4cc1b81 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -421,6 +421,22 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		},
 	},
 	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Hewlett-Packard Pavilion dv7",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv7"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Hewlett-Packard Compaq Presario CQ40 Notebook PC",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Compaq Presario CQ40 Notebook PC"),
+		},
+	},
+	{
 	.callback = init_old_suspend_ordering,
 	.ident = "Panasonic CF51-2L",
 	.matches = {
-- 
1.6.0.6

