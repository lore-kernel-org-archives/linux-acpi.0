From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Re: [BKPATCH] ACPI for 2.6
Date: Tue, 29 Jun 2004 21:51:16 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040629215116.GA19451@message-id.gmane0305.slipkontur.de>
References: <6E0C289723A0564F9A8279E236E8565F07A9E73A@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F07A9E73A-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
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

On Mon, Jun 28, 2004 at 09:30:59AM +0800, Wang, Zhenyu Z wrote:
>  
> Please update your patch on osdl bug.

done. I'm also sending the patch here for further review (can't hurt ;-)


diff -ru /tmp/acpi/thermal.c linux-2.6.7/drivers/acpi/thermal.c
--- /tmp/acpi/thermal.c	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7/drivers/acpi/thermal.c	2004-06-29 23:43:00.236341420 +0200
@@ -892,8 +892,10 @@
 	struct seq_file		*m = (struct seq_file *)file->private_data;
 	struct acpi_thermal	*tz = (struct acpi_thermal *)m->private;
 
-	char			limit_string[25] = {'\0'};
-	int			critical, hot, passive, active0, active1;
+	char			limit_string[65] = {'\0'};
+	int			num, critical, hot, passive;
+	int			active[ACPI_THERMAL_MAX_ACTIVE];
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

-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
