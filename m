From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/16] PM / ACPI: Blacklist systems known to require
 acpi_sleep=nonvs
Date: Tue, 28 Sep 2010 23:44:32 -0400
Message-ID: <539986482b0db07b7164ab086d167ab99b4d3061.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:36902 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab0I2DpG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00GVQP327LH2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:06 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 2a6b69765ad794389f2fc3e14a0afa1a995221c2 (ACPI: Store NVS
state even when entering suspend to RAM) changed the ACPI suspend
to RAM code so that the NVS memory area is always unconditionally
saved during suspend and restored during resume, since some systems
evidently need that for the suspend-resume to work on them.  However,
it turned out that this change broke suspend-resume on a few systems,
so commit 72ad5d77fb981963edae15eee8196c80238f5ed0 (ACPI / Sleep:
Allow the NVS saving to be skipped during suspend to RAM) introduced
the acpi_sleep=nonvs command line switch to allow their users to
work around this issue.  To keep track of the systems that require
this workaround and to make the life of their users slightly easier
blacklist them in acpisleep_dmi_table[].

https://bugzilla.kernel.org/show_bug.cgi?id=16396

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index cf82989..4754ff6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -363,6 +363,12 @@ static int __init init_old_suspend_ordering(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init init_nvs_nosave(const struct dmi_system_id *d)
+{
+	acpi_nvs_nosave();
+	return 0;
+}
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -397,6 +403,22 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "CF51-2L"),
 		},
 	},
+	{
+	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VGN-SR11M",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR11M"),
+		},
+	},
+	{
+	.callback = init_nvs_nosave,
+	.ident = "Everex StepNote Series",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Everex Systems, Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Everex StepNote Series"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.7.3.2.g9027fa

