From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/11] ACPI / PM: Blacklist Averatec machine known to require acpi_sleep=nonvs
Date: Thu, 6 Jan 2011 23:37:01 +0100
Message-ID: <201101062337.01589.rjw@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Apparently, Averatec AV1020-ED2 does not resume correctly without
acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.

References: https://bugzilla.kernel.org/show_bug.cgi?id=16396#c86
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -435,6 +435,14 @@ static struct dmi_system_id __initdata a
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
