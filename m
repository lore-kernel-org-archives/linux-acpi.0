From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI / battery: Add quirk for Asus UX360UA and UX410UAK
Date: Mon, 29 Jan 2018 13:40:36 +0800
Message-ID: <20180129054036.13599-1-kai.heng.feng@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeA2Fkn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jan 2018 00:40:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>

Same issue as other Asus laptops, ACPI incorrectly reports discharging
when battery is full and AC is plugged.

Use the same battery quirk can workaround the issue.

BugLink: https://bugs.launchpad.net/bugs/1661876
BugLink: https://bugs.launchpad.net/bugs/1745032
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/battery.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 19bc440820e6..7128488a3a72 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1209,6 +1209,22 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "UX305LA"),
 		},
 	},
+	{
+		.callback = battery_full_discharging_quirk,
+		.ident = "ASUS UX360UA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX360UA"),
+		},
+	},
+	{
+		.callback = battery_full_discharging_quirk,
+		.ident = "ASUS UX410UAK",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX410UAK"),
+		},
+	},
 	{},
 };
 
-- 
2.15.1

