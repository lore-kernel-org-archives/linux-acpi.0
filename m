From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Wed, 14 May 2008 02:08:20 +0100
Message-ID: <20080514010820.GD21608@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <20080514010300.GC21608@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:34508 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757606AbYENBIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 21:08:49 -0400
Content-Disposition: inline
In-Reply-To: <20080514010300.GC21608@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

If a thermal zone is provided with a critical temperature, then there is 
obviously a concern on the part of the vendor that it may overheat. 
Currently Linux will only attempt to do something about that if the 
vendor has explicitly added a passive cooling trip point. However, it's 
clear that allowing the system to hit the critical trip point is far 
from ideal - the system will immediately shut down, and data will almost 
certainly be lost. This patch adds a default passive cooling zone if the 
platform does not provide its own, with the default being to have it be 
5 degrees below the critical shutoff temperature. This should avoid the 
kernel limiting performance unless it's genuinely likely that the 
hardware is about to overheat and shut down. The default temperature 
value can be overridden by passing the thermal.psv argument at boot or 
module load time.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

While this is clearly something of a hack, I'd argue that it's the right 
thing to do. In the real world, it's highly unlikely that a piece of 
ahrdware is going to reach equilibrium at 5 degrees below the critical 
temperature. If we've reached that temperature, the machine is in 
serious danger of powering down in the near future and we really ought 
to do something about it.

This patch associates the CPUs with the zone even if the zone may be 
relating to an entirely different part of the hardware. This is a 
pragmatic decision - right now the CPUs are the only hardware we really 
have any thermal control over, and even if the thermal zone is covering 
the GPU (for instance) then the only thing we can do to reduce the heat 
is to reduce the load on the CPU. I think this is certainly better than 
letting the machine power down.

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 93cb3e8..19acfd3 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -116,6 +116,8 @@ static const struct acpi_device_id  thermal_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
 
+extern struct acpi_handle_list acpi_processor_list;
+
 static struct acpi_driver acpi_thermal_driver = {
 	.name = "thermal",
 	.class = ACPI_THERMAL_CLASS,
@@ -418,9 +420,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 				"_PSV", NULL, &tz->trips.passive.temperature);
 		}
 
-		if (ACPI_FAILURE(status))
-			tz->trips.passive.flags.valid = 0;
-		else {
+		if (ACPI_SUCCESS(status)) {
 			tz->trips.passive.flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(
@@ -440,20 +440,48 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					tz->trips.passive.flags.valid = 0;
 			}
 		}
+
+		if (!tz->trips.passive.flags.valid) {
+			/* If there's no valid passive zone, add a fake
+			   one in order to ensure that we don't hit the
+			   critical temperature limit */
+
+			tz->trips.passive.flags.valid = 1;
+			tz->trips.passive.tc1 = 1;
+			tz->trips.passive.tc2 = 1;
+
+			/* A high rate of polling here is acceptable -
+			   if we're hitting this limit, then the
+			   system is clearly under load. A higher
+			   polling frequency means that we can weigh
+			   the load against the temperature more
+			   effeciently and overall reduce power
+			   consumption */
+
+			tz->trips.passive.tsp = 10;
+
+			/* Set the passive trip temperature to be either
+			   the option passed by the user or 5 degrees below the
+			   critical temperature. That should give us enough
+			   head room without limiting performance */
+
+			if (!psv)
+				tz->trips.passive.temperature =
+					tz->trips.critical.temperature - 50;
+		}
 	}
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
-			tz->trips.passive.flags.valid = 0;
-		else
-			tz->trips.passive.flags.valid = 1;
-
-		if (memcmp(&tz->trips.passive.devices, &devices,
+		if (ACPI_FAILURE(status)) {
+			memcpy(&tz->trips.passive.devices,
+			       &acpi_processor_list,
+			       sizeof (struct acpi_handle_list));
+		} else if (memcmp(&tz->trips.passive.devices, &devices,
 				sizeof(struct acpi_handle_list))) {
 			memcpy(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list));
+			       sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
 		}
 	}

-- 
Matthew Garrett | mjg59@srcf.ucam.org
