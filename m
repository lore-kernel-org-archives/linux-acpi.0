From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Wed, 31 Jan 2018 00:40:05 -0800
Message-ID: <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38693 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeAaIkS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 03:40:18 -0500
In-Reply-To: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, jdelvare@suse.com, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org, alex.hung@canonical.com, Mario.Limonciello@dell.com

A number of Dell systems require an OEM _OSI string "Linux-Dell-Video" as
a BIOS workaround for a system hang bug caused by discrete VGA. The form of
the OEM _OSI string is discussed in Documentation/acpi/osi.txt and is
defined by each OEM.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/osi.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 76998a5..43e4349 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -477,6 +477,112 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
 	{}
 };
 
+static int __init dmi_oem_osi_add(const struct dmi_system_id *d)
+{
+	struct acpi_osi_entry *osi;
+	const char *str = d->driver_data;
+	int i;
+
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		if (!strcmp(osi->string, str)) {
+			osi->enable = true;
+			continue;
+		} else if (osi->string[0] == '\0') {
+			osi->enable = true;
+			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dmi_system_id acpi_oem_osi_dmi_table[] __initconst = {
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell Latitude 5491",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0818]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell Latitude 5591",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0819]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell Precision 3530",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0820]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell Inspiron 7777 AIO",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0850]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell Inspiron 5477 AIO",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0851]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell G5 5779",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0886]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell G5 5779",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0870]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell G5 5579",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[086F]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{
+	.callback = dmi_oem_osi_add,
+	.ident = "Dell G5 5579",
+	.matches = {
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
+		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0885]"),
+		},
+	.driver_data = "Linux-Dell-Video",
+	},
+	{}
+};
+
 static __init void acpi_osi_dmi_blacklisted(void)
 {
 	dmi_check_system(acpi_osi_dmi_table);
@@ -496,6 +602,7 @@ int __init early_acpi_osi_init(void)
 int __init acpi_osi_init(void)
 {
 	acpi_install_interface_handler(acpi_osi_handler);
+	dmi_check_system(acpi_oem_osi_dmi_table);
 	acpi_osi_setup_late();
 
 	return 0;
-- 
2.7.4

