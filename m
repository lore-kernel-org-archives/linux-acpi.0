From: Alex Chiang <achiang@canonical.com>
Subject: [PATCH v2] ACPI: DMI init_set_sci_en_on_resume for multiple Lenovo
 ThinkPads
Date: Fri, 23 Apr 2010 10:20:15 -0600
Message-ID: <20100423162015.GA27760@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57184 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab0DWQUV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2010 12:20:21 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

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

Confirmed by numerous testers in the launchpad bug that using
acpi_sleep=sci_force_enable fixes the issue. We add the machines
to acpisleep_dmi_table[] to automatically enable this workaround.

https://bugzilla.kernel.org/show_bug.cgi?id=15407
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/532374

Cc: stable@kernel.org
Signed-off-by: Alex Chiang <achiang@canonical.com>
---
We want to get this patch upstream so that we can get it into
-stable. Matthew Garrett's patch titled "Fall back to manually
changing SCI_EN" is the plan for dealing with future platforms
that will likely have this same BIOS bug.

v1 -> v2:
	- remove separate X201s entry, as the X201 entry will match it too
---
 sleep.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
---
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index f74834a..317794f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -450,6 +450,38 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
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
+	.ident = "Lenovo ThinkPad X201[s]",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201"),
+		},
+	},
+	{
 	.callback = init_old_suspend_ordering,
 	.ident = "Panasonic CF51-2L",
 	.matches = {
