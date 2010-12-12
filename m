From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Do not save/restore NVS on Sony Vaio VGN-NW130D
Date: Sun, 12 Dec 2010 21:10:42 +0100
Message-ID: <201012122110.42717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Adriano <adriano.vilela@yahoo.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The saving of the NVS memory area during suspend and restoring it
during resume causes problems to appear on Sony Vaio VGN-NW130D, so
blacklist that machine to avoid those problems.

Addresses https://bugzilla.kernel.org/show_bug.cgi?id=23002

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Adriano <adriano.vilela@yahoo.com>
---

Hi Len,

Another Vaio needing acpi_sleep=nonvs, please apply.

Thanks,
Rafael

---
 drivers/acpi/sleep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -427,6 +427,14 @@ static struct dmi_system_id __initdata a
 		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEB1Z1E"),
 		},
 	},
+	{
+	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VGN-NW130D",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NW130D"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
