From: Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle instead of S3
Date: Thu, 10 Nov 2016 15:35:18 -0600
Message-ID: <1478813718-12521-1-git-send-email-mario.limonciello@dell.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:32867 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965150AbcKJVsS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Nov 2016 16:48:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario.limonciello@dell.com>

If the ACPI_FADT_LOW_POWER_S0 bit is set, this indicates the platform
should get identical or better performance using Suspend-To-Idle.

By removing S3 and S1 userspace will prefer suspend-to-idle in
these situations too.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/acpi/sleep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index deb0ff7..ff1d8f1 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -171,6 +171,12 @@ static int __init init_nvs_nosave(const struct dmi_system_id *d)
 	return 0;
 }
 
+static bool suspend_to_idle_preferred(void)
+{
+	return (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0);
+}
+
+
 static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -908,6 +914,11 @@ int __init acpi_sleep_init(void)
 		acpi_no_s5 = true;
 	}
 
+	if (suspend_to_idle_preferred()) {
+		sleep_states[ACPI_STATE_S3] = 0;
+		sleep_states[ACPI_STATE_S1] = 0;
+	}
+
 	supported[0] = 0;
 	for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
 		if (sleep_states[i])
-- 
2.7.4

