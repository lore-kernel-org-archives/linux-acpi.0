From: Alex Chiang <achiang@canonical.com>
Subject: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple Lenovo
 ThinkPads
Date: Tue, 20 Apr 2010 08:03:14 -0600
Message-ID: <20100420140314.GA5573@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, colin.king@canonical.com
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org

Multiple Lenovo ThinkPad models with Intel Core i5/i7 CPUs can
successfully suspend/resume once, and then hang on the second s/r
cycle.

We got confirmation that this was due to a BIOS defect. The BIOS
did not properly set SCI_EN coming out of S3. The BIOS guys
hinted that The Other Leading OS ignores the fact that hardware
owns the bit and sets it manually.

In any case, an existing DMI table exists for machines where this
defect is a known problem. Lenovo promise to fix their BIOS, but
for folks who either won't or can't upgrade their BIOS, allow
Linux to workaround the issue.

https://bugzilla.kernel.org/show_bug.cgi?id=15407
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/532374

Confirmed by numerous testers in the launchpad bug that using
acpi_sleep=sci_force_enable fixes the issue. We add the machines
to acpisleep_dmi_table[] to automatically enable this workaround.

Cc: stable@kernel.org
Cc: Colin King <colin.king@canonical.com>
Signed-off-by: Alex Chiang <achiang@canonical.com>
---
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index f74834a..ce54cd0 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -450,6 +450,46 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		},
 	},
 	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Lenovo ThinkPad T410",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T410"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Lenovo ThinkPad T510",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T510"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Lenovo ThinkPad W510",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W510"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Lenovo ThinkPad X201",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Lenovo ThinkPad X201",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
+		},
+	},
+	{
 	.callback = init_old_suspend_ordering,
 	.ident = "Panasonic CF51-2L",
 	.matches = {
