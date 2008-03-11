From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: thermal fixup for broken BIOS which has invalid
	trip points
Date: Tue, 11 Mar 2008 15:52:51 +0800
Message-ID: <1205221971.2240.11.camel@acpi-hp-zz.sh.intel.com>
References: <1205114031.10256.193.camel@acpi-hp-zz.sh.intel.com>
	 <200803110235.55358.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lghFkw7vzmRPFslchyBx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32861 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbYCKIDp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 04:03:45 -0400
In-Reply-To: <200803110235.55358.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>


--=-lghFkw7vzmRPFslchyBx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, 2008-03-11 at 14:35 +0800, Len Brown wrote:
> On Sunday 09 March 2008, Zhang, Rui wrote:
> > thermal fixup for broken BIOS which has invalid trip points.
> > http://bugzilla.kernel.org/show_bug.cgi?id=8544
> > http://marc.info/?l=linux-kernel&m=120496222629983&w=2
> >
> > Signed-off-by: Zhang Rui<rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Index: linux-2.6/drivers/acpi/thermal.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/thermal.c
> > +++ linux-2.6/drivers/acpi/thermal.c
> > @@ -326,7 +326,9 @@ static int acpi_thermal_set_cooling_mode
> >  #define ACPI_TRIPS_ACTIVE    0x08
> >  #define ACPI_TRIPS_DEVICES   0x10
> > 
> > -#define ACPI_TRIPS_REFRESH_THRESHOLDS        (ACPI_TRIPS_PASSIVE |
> ACPI_TRIPS_ACTIVE)
> > +#define ACPI_TRIPS_REFRESH_THRESHOLDS        (ACPI_TRIPS_PASSIVE |
> \
> > +                                      ACPI_TRIPS_ACTIVE |    \
> > +                                      ACPI_TRIPS_DEVICES)
> >  #define ACPI_TRIPS_REFRESH_DEVICES   ACPI_TRIPS_DEVICES
> > 
> >  #define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT
> | \
> >
> >
> 
> I don't like re-evaluating _AL0 on notify 0x81 as a workaround
> to notice that there _is_ no _AL0.  We should re-evaluate _AL0
> on notify x82 -- per the spec.
I agree.
> 
> We should print out a single exeception at boot time when
> we realize that the BIOS has a bug of no _AL0 for the _AC0.
> At run time, we should have no concept of a valid _AC0
> and thus a notify x81 should not try to use it.
OK.
With the refreshed patch applied, ACPI thermal driver will not try to
evaluate any invalid trip points for notification 0X81. And a warn
message is printed out at boot time.

Marton, can you try this patch and attach the dmesg output please? :)

thermal fixup for broken BIOS which has invalid trip points.

ACPI thermal driver only re-evaluate valid trip points.
For the broken BIOS show in
http://bugzilla.kernel.org/show_bug.cgi?id=8544
the active[0] is set to invalid at boot time
and it will not be re-evaluated again.
We can still get a warning message at boot time.

http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -401,7 +401,8 @@ static int acpi_thermal_trips_update(str
 	}
 
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -440,8 +441,11 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_WARNING PREFIX
+				"Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
+		}
 		else
 			tz->trips.passive.flags.valid = 1;
 
@@ -465,7 +469,8 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+			tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 				name, NULL, &tz->trips.active[i].temperature);
 			if (ACPI_FAILURE(status)) {
@@ -497,8 +502,11 @@ static int acpi_thermal_trips_update(str
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING PREFIX
+					"Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
+			}
 			else
 				tz->trips.active[i].flags.valid = 1;
 


--=-lghFkw7vzmRPFslchyBx
Content-Disposition: attachment; filename=thermal-fix
Content-Type: text/plain; name=thermal-fix; charset=UTF-8
Content-Transfer-Encoding: 7bit

thermal fixup for broken BIOS which has invalid trip points.

ACPI thermal driver only re-evaluate valid trip points.
For the broken BIOS show in
http://bugzilla.kernel.org/show_bug.cgi?id=8544
the active[0] is set to invalid at boot time
and it will not be re-evaluated again.
We can still get a warning message at boot time.

http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -401,7 +401,8 @@ static int acpi_thermal_trips_update(str
 	}
 
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -440,8 +441,11 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_WARNING PREFIX
+				"Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
+		}
 		else
 			tz->trips.passive.flags.valid = 1;
 
@@ -465,7 +469,8 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+			tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 				name, NULL, &tz->trips.active[i].temperature);
 			if (ACPI_FAILURE(status)) {
@@ -497,8 +502,11 @@ static int acpi_thermal_trips_update(str
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING PREFIX
+					"Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
+			}
 			else
 				tz->trips.active[i].flags.valid = 1;
 

--=-lghFkw7vzmRPFslchyBx--

