From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Can set all but active[2] temperature via trip_points
Date: Mon, 26 Apr 2004 23:42:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040426214213.GA10794@message-id.gmane0305.slipkontur.de>
References: <20040425055737.GA7358@home.larve.net> <20040426112550.GB23616@fuchi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040426112550.GB23616-5sK/Rx+du8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2004 at 01:25:50PM +0200, Sebastian Henschel wrote:

> i had a little discussion with pavel machek about that a couple of weeks
> ago. as written in 12.3.1, the acpi spec defines 10 active states.
> the current implementation in linux is implemented for only 2 active
> states, because pavel had not seen more than that before. he also told
> me that it should not be too hard to expand this to more active states.
> so you could either nag him to do that or do it yourself and send the
> patch to this list. :)

ok, i hacked some quick solution which WorksForMe[tm]. Note: i do not
know C, so this could be terribly wrong. Anyway, this is the result:

susi:~ # cat /proc/acpi/thermal_zone/TZ1/trip_points
critical (S5):           102 C
passive:                 100 C: tc1=1 tc2=2 tsp=100 devices=0xf7fe57a0 
active[0]:               80 C: devices=0xcdf86620 
active[1]:               65 C: devices=0xcdf86580 
active[2]:               55 C: devices=0xcdf86500 
active[3]:               40 C: devices=0xcdf86480 
susi:~ # echo "102:90:100:81:66:56:41" > /proc/acpi/thermal_zone/TZ1/trip_points
susi:~ # cat /proc/acpi/thermal_zone/TZ1/trip_points
critical (S5):           102 C
passive:                 100 C: tc1=1 tc2=2 tsp=100 devices=0xf7fe57a0 
active[0]:               81 C: devices=0xcdf86620 
active[1]:               66 C: devices=0xcdf86580 
active[2]:               56 C: devices=0xcdf86500 
active[3]:               41 C: devices=0xcdf86480 

the patch is fairly trivial:

diff -ur /tmp/acpi/thermal.c drivers/acpi/thermal.c
--- /tmp/acpi/thermal.c	2004-04-06 23:51:43.000000000 +0200
+++ drivers/acpi/thermal.c	2004-04-26 23:23:55.298379102 +0200
@@ -892,8 +892,10 @@
 	struct seq_file		*m = (struct seq_file *)file->private_data;
 	struct acpi_thermal	*tz = (struct acpi_thermal *)m->private;
 
-	char			limit_string[25] = {'\0'};
-	int			critical, hot, passive, active0, active1;
+	char			limit_string[65] = {'\0'};
+	int			num, critical, hot, passive;
+	int			active[9];
+	int			i = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
 
@@ -909,7 +911,11 @@
 	
 	limit_string[count] = '\0';
 
-	if (sscanf(limit_string, "%d:%d:%d:%d:%d", &critical, &hot, &passive, &active0, &active1) != 5) {
+	num = sscanf(limit_string, "%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d",
+				&critical, &hot, &passive,
+				&active[0], &active[1], &active[2], &active[3], &active[4],
+				&active[5], &active[6], &active[7], &active[8], &active[9]);
+	if(!(num >=5 && num < (ACPI_THERMAL_MAX_ACTIVE + 3))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
 		return_VALUE(-EINVAL);
 	}
@@ -917,8 +923,11 @@
 	tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
 	tz->trips.hot.temperature = CELSIUS_TO_KELVIN(hot);
 	tz->trips.passive.temperature = CELSIUS_TO_KELVIN(passive);
-	tz->trips.active[0].temperature = CELSIUS_TO_KELVIN(active0);
-	tz->trips.active[1].temperature = CELSIUS_TO_KELVIN(active1);
+	for (i = 0; i < num - 3; i++) {
+		if (!(tz->trips.active[i].flags.valid))
+			break;
+		tz->trips.active[i].temperature = CELSIUS_TO_KELVIN(active[i]);
+	}
 	
 	return_VALUE(count);
 }


one could argue about the parameter count checking. I used ">= 5" since
the original version demands exactly 5 parameters. If you specify not
enough zones, the last ones will not be set. If you specify too many
zones, they should also be ignored. If i got something terribly wrong,
well, i told you about my C skills ;-)

Use at your own risk, YMMV.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
