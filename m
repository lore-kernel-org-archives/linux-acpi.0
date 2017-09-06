From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / x86: Extend KIOX000A quirk to cover all affected BIOS versions
Date: Wed,  6 Sep 2017 15:44:25 +0200
Message-ID: <20170906134425.17449-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbdIFNo2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Sep 2017 09:44:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

Recently produced GPD win devices have a new BIOS, research into the
changes in this BIOS has found a ChangeLog which shows that the disabling
of the KIOX000A node has been done starting with the 20170221 version.

Unfortunately the GPD pocket uses the exact same DMI strings as the win
and its BIOS was copy-pasted from the GPD win, so it has a disabled
KIOX000A node which we should not enable, so we need to check for the
exact BIOS date.

This commit adds 2 extra entries to the always_present_ids quirk table
with bios_date matches for the older also affected and the latest BIOS.

Reported-by: ReddestDream <reddestdream@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index b4fbb9929482..ec5b0f190231 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -71,18 +71,34 @@ static const struct always_present_id always_present_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
 	/*
-	 * The GPD win BIOS dated 20170320 has disabled the accelerometer, the
+	 * The GPD win BIOS dated 20170221 has disabled the accelerometer, the
 	 * drivers sometimes cause crashes under Windows and this is how the
 	 * manufacturer has solved this :| Note that the the DMI data is less
 	 * generic then it seems, a board_vendor of "AMI Corporation" is quite
 	 * rare and a board_name of "Default String" also is rare.
+	 *
+	 * Unfortunately the GPD pocket also uses these strings and its BIOS
+	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
+	 * node which we should not enable, thus we also check the BIOS date.
 	 */
 	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
+	      }),
+	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
+	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		DMI_MATCH(DMI_BIOS_DATE, "05/25/2017")
+	      }),
 };
 
 bool acpi_device_always_present(struct acpi_device *adev)
-- 
2.13.4

