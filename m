From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/9] ACPI: DMI init_set_sci_en_on_resume for multiple Lenovo
 ThinkPads
Date: Thu, 06 May 2010 03:03:16 -0400
Message-ID: <07bedca29b0973f36a6b6db36936deed367164ed.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:48985 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab0EFHDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:43 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00FHFKXPYEA0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:26 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@canonical.com>, stable@kernel.org, Colin King <colin.king@canonical.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@canonical.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index f74834a..0fc91a9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -450,6 +450,126 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
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
-- 
1.6.0.6

