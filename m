From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH] ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(2016)
Date: Tue, 10 Apr 2018 23:07:51 +0800
Message-ID: <20180410150751.31580-1-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Robin Lee <robinlee.sysu@gmail.com>, Hans de Goede <jwrdegoede@fedoraproject.org>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

ThinkPad X1 Tablet(2016) is reported to have issues with
the Low Power S0 Idle _DSM interface and since this machine
model generally can do ACPI S3 just fine, and user would
like to use S3 as default sleep model, add a blacklist
entry to disable that interface for ThinkPad X1 Tablet(2016).

Reported-and-tested-by: Robin Lee <robinlee.sysu@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/sleep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 46cde0912762..465f33aa0bd8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -364,6 +364,19 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
 		},
 	},
+	/*
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057
+	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using the Low Power
+	 * S0 Idle firmware interface.
+	 */
+	{
+	.callback = init_no_lps0,
+	.ident = "ThinkPad X1 Tablet(2016)",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
+		},
+	},
 	{},
 };
 
-- 
2.13.6
