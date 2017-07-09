From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] ACPI / X86: Add KIOX000A accelerometer on GPD win to always_present_ids array
Date: Sun,  9 Jul 2017 21:05:14 +0200
Message-ID: <20170709190514.3437-3-hdegoede@redhat.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbdGITFU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Jul 2017 15:05:20 -0400
In-Reply-To: <20170709190514.3437-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

The GPD win BIOS dated 20170320 has disabled the accelerometer, the
drivers sometimes cause crashes under Windows and this is how the
manufacturer has solved this :|

I see no other way to keep the accelerometer working under Windows then
adding it to the always_present_ids array.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index eb6caf6f708b..b4fbb9929482 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -70,6 +70,19 @@ static const struct always_present_id always_present_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
+	/*
+	 * The GPD win BIOS dated 20170320 has disabled the accelerometer, the
+	 * drivers sometimes cause crashes under Windows and this is how the
+	 * manufacturer has solved this :| Note that the the DMI data is less
+	 * generic then it seems, a board_vendor of "AMI Corporation" is quite
+	 * rare and a board_name of "Default String" also is rare.
+	 */
+	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
+	      }),
 };
 
 bool acpi_device_always_present(struct acpi_device *adev)
-- 
2.13.0

