From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI / blacklist:  blacklist Win8 OSI for Dell Inspiron 7437
Date: Thu, 23 Apr 2015 11:24:35 +0800
Message-ID: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38895 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbbDWDYp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2015 23:24:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, alex.hung@canonical.com

Dell Inspiron 7437's ACPI events does not work well with Win8 OSI.
Disabling Win8 OSI can fix wireless hotkey and ACPI battery.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 37925a3..e2db565 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -306,6 +306,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3546"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 7437",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7437"),
+		},
+	},
 
 	/*
 	 * The brightness hotkeys do not work on those machines when
-- 
1.7.9.5

