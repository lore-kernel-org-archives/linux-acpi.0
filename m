From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:26:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103232621.E19750@brodo.de>
References: <000001c28231$b7cae110$c200a8c0@pikachu> <20021102171756.GD1983@elf.ucw.cz> <1036288754.2971.1.camel@localhost.localdomain> <20021103195616.GB27271@elf.ucw.cz> <20021103211607.A1555@brodo.de> <20021103202130.GB22668@atrey.karlin.mff.cuni.cz> <20021103213010.A1665@brodo.de> <20021103203949.GE22668@atrey.karlin.mff.cuni.cz> <20021103230552.A20785@brodo.de> <20021103221532.GG28704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103221532.GG28704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Sun, Nov 03, 2002 at 11:15:32PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 03, 2002 at 11:15:32PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > PS: Polling rate has strong effect  on how passive works. If you set
> > > it too fast it will basically only use "max performance" and "max
> > > throttle", which is not what you want.
> > No, it doesn't: the _trend_ is deciding, and not the fact that the temp is
> > above the limit. additionally, polling is used automatically when passive
> > cooling a.k.a. "throttle || performance" is used. Patch will follow soon.
> 
> AFAICR, its something like a * temperature + b * trend.
> 
> Assume your polling frequency is 1msec, and passive limit 50C.
> 
> t: Temp is 50C, machine is cool at P0:T0.
> t+1 msec: Temp is 51C. Trend is +, temperature is over, machine goes P0:T1.
> t+2 msec: Temp is still 51C (1 msec is too little time for temp to
> change), trend is no change, but temperature is still over, machine
> goes P0:T2.
> t+3 msec: Temp is still 51C (2 msec is too little time for temp to
> change), trend is no change, but temperature is still over, machine
> goes P0:T3.
> at t+7 msec machine reaches P0:T7.
> at t+1000msec cpu cools down, and you reach P0:T0 in 7 msec.
> 
> Not good.

No, that's wrong: 

1.) If passive cooling is active, _TSP is used _in all cases_
as polling frequency (_TSP is an integer given in 1/10th seconds) - see
acpi_thremal_check:
*
	if (tz->state.passive)
		sleep_time = tz->trips.passive.tsp * 100;
	else if (tz->polling_frequency > 0)
		sleep_time = tz->polling_frequency * 100;
*
2.) This means that in acpi_thermal_passive:
		trend = (passive->tc1 * (tz->temperature -
tz->last_temperature)) + (passive->tc2 * (tz->temperature -
passive->temperature));
    is only calculated each _TSP frequency. And only when this trend is 
   positive, throttling or perf. state is increased.
*
		if (trend > 0)
			for (i=0; i<passive->devices.count; i++)
				acpi_processor_set_thermal_limit(
					passive->devices.handles[i], 
					ACPI_PROCESSOR_LIMIT_INCREMENT);
*

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
