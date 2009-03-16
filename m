From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/14] ACPI suspend: Blacklist Toshiba Satellite L300 that
 requires to set SCI_EN directly on resume
Date: Mon, 16 Mar 2009 01:23:49 -0400
Message-ID: <45e7798886af101c4a908a896bbba5a84ee5cc32.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:10491 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZCPFYH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00L8M304ST99@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:05 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

This is a supplement of commit 65df78473ffbf3bff5e2034df1638acc4f3ddd50.
http://bugzilla.kernel.org/show_bug.cgi?id=12798

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 3ca9868..00456fc 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -386,6 +386,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
 		},
 	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Toshiba Satellite L300",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L300"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.5.6.6

