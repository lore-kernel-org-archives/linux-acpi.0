From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]  ACPI / Video: Fix initial brightness problem on Acer Ferrari One
Date: Thu, 1 Apr 2010 21:59:05 +0200
Message-ID: <201004012159.05980.rjw@sisk.pl>
References: <201004010319.19366.rjw@sisk.pl> <1270106322.24064.4496.camel@rzhang1-desktop> <201004012145.07898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50233 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923Ab0DAT4J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Apr 2010 15:56:09 -0400
In-Reply-To: <201004012145.07898.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>

On Thursday 01 April 2010, Rafael J. Wysocki wrote:
> On Thursday 01 April 2010, Zhang Rui wrote:
> > On Thu, 2010-04-01 at 09:34 +0800, Zhang Rui wrote:
> > > On Thu, 2010-04-01 at 09:19 +0800, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
...
> > > > +		if (!br->flags._BCL_no_ac_battery_levels)
> > > > +			level = power_supply_is_system_supplied() ?
> > > > +
> > > > 						br->levels[0] : br->levels[1];
> > > 
> > > this doesn't work currently.
> > > br->levels[0] and br->levels[1] doesn't equal the "AC power" value and
> > > "Battery" value, because the "AC power" and "Battery" value is not
> > > exported by many BIOS at all.
> 
> But if the BIOS doesn't export these values,
> br->flags._BCL_no_ac_battery_levels will be true, won't it?
> 
> > I mean, for these laptops, br->levels[0] and br->levels[1] equals the
> > first and second elements in _BCL package.
> > But we can not use them as the "AC power" and "Battery" value.
> 
> In that cases the if (!br->flags._BCL_no_ac_battery_levels) condition won't
> be satisfied.
> 
> On a second thought, though, something like this also works and is simpler.

OK, Matthew wanted me to make the second expression using the ternary operator
more readable.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / Video: Fix initial brightness problem on Acer Ferrari One (v. 2)

On Acer Ferrari One, when _BQC is invoked for the first time, the
minimum brightness is returned, so the ACPI video drivers sets the
minimum brightness on boot.  This is not desirable, so use the
following rule:
	Set brightness to either the level supposed to be used on
	AC power, or the brightness level supposed to be used on
	battery, depending on whether or not the system is on AC
	power.  If these values are not exported by the BIOS, use the
	brightness level initially returned by _BQC.  If that value
	is invalid, use the maximum brightness level.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/video.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

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
 
@@ -915,6 +916,18 @@ acpi_video_init_brightness(struct acpi_v
 
 	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
 
+	/*
+	 * Set brightness to the "AC power" value if on AC power or to the
+	 * "battery" value otherwise.  If these vaules are not exported, try
+	 * to use the value returned by the initial _BQC and fall back to
+	 * max_level.
+	 */
+	if (!br->flags._BCL_no_ac_battery_levels) {
+		level = power_supply_is_system_supplied() ?
+					br->levels[0] : br->levels[1];
+		goto set_level;
+	}
+
 	if (!br->flags._BQC_use_index) {
 		/*
 		 * Set the backlight to the initial state.
@@ -930,7 +943,8 @@ acpi_video_init_brightness(struct acpi_v
 
 	if (br->flags._BCL_reversed)
 		level_old = (br->count - 1) - level_old;
-	level = br->levels[level_old];
+	level = (level_old >= 0 && level_old < br->count) ?
+				br->levels[level_old] : max_level;
 
 set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
