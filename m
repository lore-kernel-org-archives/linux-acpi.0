From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI Thermal Shutdown on Boot
Date: Sun, 15 Feb 2004 21:29:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040215202945.GO286@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6A6@PDSMSX403.ccr.corp.intel.com> <20040213190646.GH6804@openzaurus.ucw.cz> <20040215122249.V20266@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040215122249.V20266-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > > If I understand you correctly, 30 seconds is certainly
> > > > enough time to burn
> > > > > a CPU when the fan has failed, isn't it?
> > > >
> > > > Our old default poll interval was 30 seconds so this doesn't change
> > > > anything.  I know DeadRat takes more than 30 seconds from "shutdown -h
> > > > now" to power off.  All modern CPUs have a thermal shutdown builtin.
> > > > Think of _CRT as more of "system temp too high, shut down as
> > > > soon as you
> > > > can."
> > >
> > >   If I didn't miss something,  Chris Jensen was unable to adjust
> > > critical trip point due
> > > to current policy. Anyway, 57C isn't a real critical temperature. It
> > > doesn't make sense to
> > > enter emergent shutdown/power.So we need sane checking here.( A sane
> > > _CRT ?)
> > >   If FAN is broken, at least we can use throttling to guarantee it will
> > > not be over heated.
> > > So, throttling should be included into policy about handling critical
> > > trip point.
> >
> > At critical trip point, we have to shut down, according
> > to specs. No choice here.
> >
> > If their ACPI BIOS is b0rken, blacklist them.
> 
> My point was that shutdown to poweroff takes about 10 seconds on FreeBSD
> but much longer on common Linux distributions.  So even with a little
> delay, the system gets shut down at the same time.  This is better than
> blacklisting the system (a Compaq laptop) and not having any _CRT
> protection.  But Linux can do it however you want.

Well, hardware should protect itself at the end.

Can you see if this:

fixes stuff for you? You should see 'ACPI changed its mind...' in the
logs. (I wonder how to do this properly. Hardcoding 10Celsius is
broken...)

								Pavel

--- clean/drivers/acpi/thermal.c	2004-02-05 01:54:00.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2004-02-05 02:24:15.000000000 +0100
@@ -223,8 +223,11 @@
 	tz->last_temperature = tz->temperature;
 
 	status = acpi_evaluate_integer(tz->handle, "_TMP", NULL, &tz->temperature);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		if (tz->temperature != tz->last_temperature)
+			printk(KERN_ERR "temperature damaged while processing\n");
 		return -ENODEV;
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n", tz->temperature));
 
@@ -457,7 +460,17 @@
 		return_VALUE(-EINVAL);
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
+		long old_temperature = tz->temperature;
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
+
+		result = acpi_thermal_get_temperature(tz);
+		if (!result) {
+			if (tz->temperature < (tz->trips.critical.temperature - 100)) {
+				printk(KERN_ALERT "ACPI changed its mind about temperature, was %ld C, now %ld C", 
+				       KELVIN_TO_CELSIUS(old_temperature), KELVIN_TO_CELSIUS(tz->temperature));
+				return_VALUE(0);
+			}
+		}
 		tz->trips.critical.flags.enabled = 1;
 	}
 	else if (tz->trips.critical.flags.enabled)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
