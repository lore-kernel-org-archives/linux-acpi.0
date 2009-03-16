From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/14] suspend: switch the Asus Pundit P1-AH2 to old ACPI sleep
 ordering
Date: Mon, 16 Mar 2009 01:23:47 -0400
Message-ID: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:65445 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZCPFYK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00FUM303E81M@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:04 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Len Brown <len.brown@intel.com>

From: Andy Whitcroft <apw@canonical.com>

Switch the Asus Pundit P1-AH2 (M2N8L motherboard) to the old ACPI 1.0
sleep ordering by default.  Without this it will not suspend/resume
correctly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Tested-by: Dustin Kirkland <kirkland@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..3ca9868 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -378,6 +378,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
 		},
 	},
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Asus Pundit P1-AH2 (M2N8L motherboard)",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.5.6.6

