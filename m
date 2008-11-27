From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/11] ACPI suspend: Blacklist boxes that require us to set
 SCI_EN directly on resume
Date: Thu, 27 Nov 2008 02:25:09 -0500
Message-ID: <65df78473ffbf3bff5e2034df1638acc4f3ddd50.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:42195 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYK0HZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:23 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ003DKDYA85H1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:23 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some Apple boxes evidently require us to set SCI_EN on resume
directly, because if we don't do that, they hung somewhere in the
resume code path.  Moreover, on these boxes it is not sufficient to
use acpi_enable() to turn ACPI on during resume.  All of this is
against the ACPI specification which states that (1) the BIOS is
supposed to return from the S3 sleep state with ACPI enabled
(SCI_EN set) and (2) the SCI_EN bit is owned by the hardware and we
are not supposed to change it.

For this reason, blacklist the affected systems so that the SCI_EN
bit is set during resume on them.

[NOTE: Unconditional setting SCI_EN for all system on resume doesn't
 work, because it makes some other systems crash (that's to be
 expected).  Also, it is not entirely clear right now if all of the
 Apple boxes require this workaround.]

This patch fixes the recent regression tracked as
http://bugzilla.kernel.org/show_bug.cgi?id=12038

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Tested-by: Tino Keitel <tino.keitel@gmx.de>
Tested-by: Bob Copeland <me@bobcopeland.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 80c0868..28a691c 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -90,6 +90,18 @@ void __init acpi_old_suspend_ordering(void)
 	old_suspend_ordering = true;
 }
 
+/*
+ * According to the ACPI specification the BIOS should make sure that ACPI is
+ * enabled and SCI_EN bit is set on wake-up from S1 - S3 sleep states.  Still,
+ * some BIOSes don't do that and therefore we use acpi_enable() to enable ACPI
+ * on such systems during resume.  Unfortunately that doesn't help in
+ * particularly pathological cases in which SCI_EN has to be set directly on
+ * resume, although the specification states very clearly that this flag is
+ * owned by the hardware.  The set_sci_en_on_resume variable will be set in such
+ * cases.
+ */
+static bool set_sci_en_on_resume;
+
 /**
  *	acpi_pm_disable_gpes - Disable the GPEs.
  */
@@ -235,7 +247,11 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	}
 
 	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
-	acpi_enable();
+	if (set_sci_en_on_resume)
+		acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
+	else
+		acpi_enable();
+
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(acpi_state);
 
@@ -323,6 +339,12 @@ static int __init init_old_suspend_ordering(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init init_set_sci_en_on_resume(const struct dmi_system_id *d)
+{
+	set_sci_en_on_resume = true;
+	return 0;
+}
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -340,6 +362,22 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP xw4600 Workstation"),
 		},
 	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Apple MacBook 1,1",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
+		},
+	},
+	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Apple MacMini 1,1",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.5.6.5

