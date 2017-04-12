From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI / blacklist: add _REV quirk for Dell Inspiron 7537
Date: Wed, 12 Apr 2017 16:12:45 +0800
Message-ID: <20170412081245.8714-1-kai.heng.feng@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdDLINJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2017 04:13:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>

The battery can only be detected after AC power adapter event.

Adding the machine to acpi_rev_dmi_table[] can workaround this issue.

BugLink: https://bugs.launchpad.net/bugs/1678590
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=105721
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/blacklist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 4421f7c9981c..bb542acc0574 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -188,6 +188,14 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
 		},
 	},
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL Inspiron 7537",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7537"),
+		},
+	},
 #endif
 	{}
 };
-- 
2.12.2

