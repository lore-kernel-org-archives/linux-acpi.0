From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI / blacklist: add _REV quirks for Dell Precision 5520 and 3520
Date: Fri, 28 Oct 2016 11:54:04 -0700
Message-ID: <1477680844-13965-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938665AbcJ1SyJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2016 14:54:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, alex.hung@canonical.com

Precision 5520 and 3520 either hang at login and during suspend or reboot.
This may be related to https://bugzilla.kernel.org/show_bug.cgi?id=156341
but adding them to acpi_rev_dmi_table is able to workound it now.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/blacklist.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bdc67ba..4f87fd7 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -160,6 +160,22 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
 		},
 	},
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL Precision 5520",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "Precision 5520"),
+		},
+	},
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL Precision 3520",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3520"),
+		},
+	},
 #endif
 	{}
 };
-- 
2.7.4

