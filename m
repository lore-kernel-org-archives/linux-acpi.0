From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: [PATCH] thermal.c below zero degree celcius
Date: Tue, 01 Oct 2002 10:49:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021002024824.CAPJC0A8264C.1C79D883@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I don't know whether there is a PC which works under zero degree celcius,
but it's possible...:)

--- acpi-2419/drivers/acpi/thermal.c	25 Aug 2002 01:34:14 -0000	1.1.1.1.8.1
+++ acpi-2419/drivers/acpi/thermal.c	1 Oct 2002 17:26:56 -0000
@@ -59,7 +59,8 @@
 
 #define ACPI_THERMAL_MAX_ACTIVE	10
 
-#define KELVIN_TO_CELSIUS(t)	((t-2732+5)/10)
+#define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732>=0) ? ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
+
 
 static int acpi_thermal_add (struct acpi_device *device);
 static int acpi_thermal_remove (struct acpi_device *device, int type);
@@ -774,7 +775,7 @@
 	if (result)
 		goto end;
 
-	p += sprintf(p, "temperature:             %lu C\n", 
+	p += sprintf(p, "temperature:             %ld C\n", 
 		KELVIN_TO_CELSIUS(tz->temperature));
 	
 end:
@@ -810,15 +811,15 @@
 		goto end;
 
 	if (tz->trips.critical.flags.valid)
-		p += sprintf(p, "critical (S5):           %lu C\n",
+		p += sprintf(p, "critical (S5):           %ld C\n",
 			KELVIN_TO_CELSIUS(tz->trips.critical.temperature));
 
 	if (tz->trips.hot.flags.valid)
-		p += sprintf(p, "hot (S4):                %lu C\n",
+		p += sprintf(p, "hot (S4):                %ld C\n",
 			KELVIN_TO_CELSIUS(tz->trips.hot.temperature));
 
 	if (tz->trips.passive.flags.valid) {
-		p += sprintf(p, "passive:                 %lu C: tc1=%lu tc2=%lu tsp=%lu devices=",
+		p += sprintf(p, "passive:                 %ld C: tc1=%lu tc2=%lu tsp=%lu devices=",
 			KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
 			tz->trips.passive.tc1,
 			tz->trips.passive.tc2, 
@@ -833,7 +834,7 @@
 	for (i=0; i<ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!(tz->trips.active[i].flags.valid))
 			break;
-		p += sprintf(p, "active[%d]:               %lu C: devices=",
+		p += sprintf(p, "active[%d]:               %ld C: devices=",
 			i, KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
 		for (j=0; j<tz->trips.active[i].devices.count; j++) 
 			p += sprintf(p, "0x%p ",
@@ -1231,7 +1232,7 @@
 
 	init_timer(&tz->timer);
 
-	printk(KERN_INFO PREFIX "%s [%s] (%lu C)\n",
+	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
 		acpi_device_name(device), acpi_device_bid(device),
 		KELVIN_TO_CELSIUS(tz->temperature));
 

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
