From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/48] ACPI / PM: Blacklist Averatec machine known to require
 acpi_sleep=nonvs
Date: Wed, 12 Jan 2011 05:19:18 -0500
Message-ID: <7b330707dddab1ad772898c1c82516342a551173.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1ALRA1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:27 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:21 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Apparently, Averatec AV1020-ED2 does not resume correctly without
acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.

References: https://bugzilla.kernel.org/show_bug.cgi?id=16396#c86
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index febb153..ddc5cce 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -435,6 +435,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NW130D"),
 		},
 	},
+	{
+	.callback = init_nvs_nosave,
+	.ident = "Averatec AV1020-ED2",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "AVERATEC"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "1000 Series"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.7.4.rc1.7.g2cf08

