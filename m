From: Adam Lee <adam.lee@canonical.com>
Subject: [PATCH] ACPI: blacklist Win8 OSI for Dell Vostro 3546
Date: Mon, 27 Oct 2014 13:55:45 +0800
Message-ID: <1414389345-4723-1-git-send-email-adam.lee@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50640 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJ0Fzb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2014 01:55:31 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so4826174pab.0
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2014 22:55:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The wireless hotkey of Dell Vostro 3546 does not work with Win8 OSI. Due
to insufficient documentation for the driver implementation, blacklist
it as a workaround.

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/acpi/blacklist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index ed122e1..7556e7c 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -290,6 +290,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Vostro 3546",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3546"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
2.1.1

