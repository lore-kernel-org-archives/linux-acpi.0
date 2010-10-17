From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Blacklist another machine that needs acpi_sleep=nonvs
Date: Sun, 17 Oct 2010 21:01:21 +0200
Message-ID: <201010172101.21576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54287 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531Ab0JQTCW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Oct 2010 15:02:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Sony Vaio VPCEB1Z1E is reported to require acpi_sleep=nonvs for
suspend/resume to work on it correctly, so blacklist it.

Reported-by: Emanuele Bigiarini <pulmro@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -419,6 +419,14 @@ static struct dmi_system_id __initdata a
 		DMI_MATCH(DMI_PRODUCT_NAME, "Everex StepNote Series"),
 		},
 	},
+	{
+	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VPCEB1Z1E",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEB1Z1E"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
