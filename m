From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/6] ACPI: DMI init_set_sci_en_on_resume for HP-Compaq C700
Date: Wed, 25 Nov 2009 01:11:55 -0500
Message-ID: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:41102 "EHLO
	vms173001.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751244AbZKYGMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KTN00MORIK31LG0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:09 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

...else ACPI thermal controls fail after resume.

http://bugzilla.kernel.org/show_bug.cgi?id=13745

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4cc1b81..5f2c379 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -430,6 +430,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	},
 	{
 	.callback = init_set_sci_en_on_resume,
+	.ident = "Hewlett-Packard Compaq Presario C700 Notebook PC",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Compaq Presario C700 Notebook PC"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
 	.ident = "Hewlett-Packard Compaq Presario CQ40 Notebook PC",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-- 
1.6.0.6

