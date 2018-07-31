From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] ACPI / EC: Use ec_no_wakeup on ThinkPad X1 Yoga 3rd
Date: Tue, 31 Jul 2018 18:52:39 +0800
Message-ID: <20180731105239.22008-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, aaron.ma@canonical.com
List-Id: linux-acpi@vger.kernel.org

Like on X1C6, on X1Y3 EC interrupts constantly wake up system from
s2idle, the power consumption is extremely high.
So make ec_no_wakeup be true as default to keep system in s2idle mode
and reduce power consumption.

Power button works when ec_no_wakeup=true.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/acpi/ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 917f77f4cb55..6291d5c77267 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2045,6 +2045,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
 		},
 	},
+	{
+		.ident = "ThinkPad X1 Yoga 3rd",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.1
