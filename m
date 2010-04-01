From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH]  ACPI / Video: Fix initial brightness problem on Acer Ferrari One
Date: Thu, 1 Apr 2010 03:19:19 +0200
Message-ID: <201004010319.19366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46367 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758499Ab0DABQE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Mar 2010 21:16:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

On Acer Ferrari One, when _BQC is invoked for the first time, the
minimum brightness is returned, so the ACPI video drivers sets the
minimum brightness on boot.  This is not desirable, so use the
following rule:
	If _BQC initially returns an invalid value or the minimum
	brightness, use either the brightness level supposed to be
	used on AC power, or the brightness level supposed to be
	used on battery, depending on whether or not the system is
	on AC power.  If these values are not exported by the BIOS,
	use the maximum brightness level.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/video.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/suspend.h>
+#include <linux/power_supply.h>
 
 #define PREFIX "ACPI: "
 
@@ -920,11 +928,20 @@ acpi_video_init_brightness(struct acpi_v
 		 * Set the backlight to the initial state.
 		 * On some buggy laptops, _BQC returns an uninitialized value
 		 * when invoked for the first time, i.e. level_old is invalid.
-		 * set the backlight to max_level in this case
+		 * On some other systems _BQC returns the minimum brightness
+		 * when invoked for the first time, which also usually is
+		 * undesirable.  In that cases use the "AC power" value if on AC
+		 * power or the "battery" value otherwise.  If these vaules are
+		 * not exported, use max_level.
 		 */
-		for (i = 2; i < br->count; i++)
-			if (level_old == br->levels[i])
+		for (i = 3; i < br->count; i++)
+			if (level_old == br->levels[i]) {
 				level = level_old;
+				goto set_level;
+			}
+		if (!br->flags._BCL_no_ac_battery_levels)
+			level = power_supply_is_system_supplied() ?
+						br->levels[0] : br->levels[1];
 		goto set_level;
 	}
 
