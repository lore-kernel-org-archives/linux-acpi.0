From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI thermal: do not always return THERMAL_TREND_RAISING
 for active trip points
Date: Tue, 23 Apr 2013 20:27:09 +0800
Message-ID: <1366720029.2094.2.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57205 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab3DWM1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Apr 2013 08:27:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>

=46rom 2e678ef60a7926daa9217ac7eaedea33043f2e35 Mon Sep 17 00:00:00 200=
1
=46rom: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 16 Apr 2013 13:54:27 +0800
Subject: [PATCH] ACPI thermal: do not always return THERMAL_TREND_RAISI=
NG for
 active trip points

Commit 4ae46befb49d4173122e0afa995c4e93d01948a2
introduces a regression that the fan is always on
even if the system is in idle state.

My original idea in that commit is that:
when the current temperature is above the trip point,
keep the fan on, even if the temperature is dropping.
when the current temperature is below the trip point,
turn on the fan when the temperature is raising,
turn off the fan when the temperature is dropping.

But this is what the code actually does:
when the current temperature is above the trip point,
the fan keeps on.
when the current temperature is below the trip point,
the fan is always on because thermal_get_trend()
in driver/acpi/thermal.c returns THERMAL_TREND_RAISING.
Thus the fan keeps running even if the system is idle.

=46ix this in drivers/acpi/thermal.c.

https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
https://bugzilla.kernel.org/show_bug.cgi?id=3D56601
https://bugzilla.kernel.org/show_bug.cgi?id=3D50041#c45

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Matthias <morpheusxyz123@yahoo.de>
Tested-by: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
---
 drivers/acpi/thermal.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8470771..b846ce0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -723,9 +723,18 @@ static int thermal_get_trend(struct thermal_zone_d=
evice *thermal,
 		return -EINVAL;
=20
 	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
-		/* aggressive active cooling */
-		*trend =3D THERMAL_TREND_RAISING;
-		return 0;
+		unsigned long trip_temp;
+		unsigned long temp =3D KELVIN_TO_MILLICELSIUS(tz->temperature,
+							tz->kelvin_offset);
+		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
+			return -EINVAL;
+
+		if (temp > trip_temp) {
+			*trend =3D THERMAL_TREND_RAISING;
+			return 0;
+		} else
+			/* Fall back on default trend */
+			return -EINVAL;
 	}
=20
 	/*
--=20
1.7.9.5



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
