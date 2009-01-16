From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/23] thermal fixup for broken BIOS which has invalid trip
 points.
Date: Fri, 16 Jan 2009 15:25:05 -0500
Message-ID: <0e4240d94628530a912d216cad1e32d2e3827327.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:49435 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759841AbZAPUZg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK0085GZE8XNR3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:26 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

=46rom: Zhang Rui <rui.zhang@intel.com>

ACPI thermal driver only re-evaluate VALID trip points.

=46or the broken BIOS show in
http://bugzilla.kernel.org/show_bug.cgi?id=3D8544
the active[0] is set to invalid at boot time
and it will not be re-evaluated again.
We can still get a single warning message at boot time.

http://marc.info/?l=3Dlinux-kernel&m=3D120496222629983&w=3D2

http://bugzilla.kernel.org/show_bug.cgi?id=3D12203

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
Tested-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 073ff09..99e6f1f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -416,7 +416,8 @@ static int acpi_thermal_trips_update(struct acpi_th=
ermal *tz, int flag)
 	}
=20
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+		(flag =3D=3D ACPI_TRIPS_INIT)) {
 		valid =3D tz->trips.passive.flags.valid;
 		if (psv =3D=3D -1) {
 			status =3D AE_SUPPORT;
@@ -462,8 +463,11 @@ static int acpi_thermal_trips_update(struct acpi_t=
hermal *tz, int flag)
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status =3D acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_WARNING PREFIX
+				"Invalid passive threshold\n");
 			tz->trips.passive.flags.valid =3D 0;
+		}
 		else
 			tz->trips.passive.flags.valid =3D 1;
=20
@@ -487,7 +491,8 @@ static int acpi_thermal_trips_update(struct acpi_th=
ermal *tz, int flag)
 		if (act =3D=3D -1)
 			break; /* disable all active trip points */
=20
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if ((flag =3D=3D ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+			tz->trips.active[i].flags.valid)) {
 			status =3D acpi_evaluate_integer(tz->device->handle,
 							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
@@ -521,8 +526,11 @@ static int acpi_thermal_trips_update(struct acpi_t=
hermal *tz, int flag)
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status =3D acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING PREFIX
+					"Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid =3D 0;
+			}
 			else
 				tz->trips.active[i].flags.valid =3D 1;
=20
--=20
1.5.6.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
