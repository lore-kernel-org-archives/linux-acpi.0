From: Michael Pobega <mpobega@neverware.com>
Subject: [PATCH] Fix for Dell Latitude 3350 ethernet not working.
Date: Fri, 11 Nov 2016 22:29:14 -0500
Message-ID: <20161112032914.hg24zqqlkwirxx7z@hotbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33674 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbcKLD3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2016 22:29:17 -0500
Received: by mail-qk0-f194.google.com with SMTP id x190so4022628qkb.0
        for <linux-acpi@vger.kernel.org>; Fri, 11 Nov 2016 19:29:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The Dell Latitude 3350's ethernet card attempts to use a reserved IRQ (18),
resulting in ACPI being unable to enable the ethernet.

This patch forces a specific _REV (ACPI revision) value as a workaround
to allow the Dell Latitude 3350's board to work correctly.

The approach is similar to 18d78b64fddc11eb336f01e46ad3303a3f55d039

Signed-off-by: Michael Pobega <mpobega@neverware.com>
---
 drivers/acpi/blacklist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bdc67ba..05cd61f 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -160,6 +160,18 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
 		},
 	},
+	/*
+	 * Resolves a quirk with the Dell Latitude 3350 that
+	 * causes the ethernet adapter to not function.
+	 */
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL Latitude 3350",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
+		},
+	},
 #endif
 	{}
 };
-- 
2.9.3

