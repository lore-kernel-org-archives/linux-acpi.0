From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] [PATCHES] ACPI Processor update [idle, throttling,
	thermal, cpufreq]
Date: Wed, 10 Sep 2003 01:13:03 +0200
Sender: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030909231303.GH211@elf.ucw.cz>
References: <20030904222434.GC6350@brodo.de>
	<20030908132939.GD3944@openzaurus.ucw.cz>
	<20030909172135.GA4106@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030909172135.GA4106-JhLEnvuH02M@public.gmane.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
Errors-To: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
To: linux-JhLEnvuH02M@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Glad you liked [at least parts] of my patches.

:-). [BTW what is status of powernow-k8? is it pending or does it need
to be fixed some more?]

> On Mon, Sep 08, 2003 at 03:29:40PM +0200, Pavel Machek wrote:
> > http://www.brodo.de/cpufreq_tmp/acpi-2.6.0-test4-processor_thermal_throttling
> > > 	Move throttling into its own submodule, and register it with the new
> > > 	passive cooling module. Also, the now-useless "limit" interface is
> > > 	removed.
> > > 
> > 
> > Actually I liked to be able to echo 0:7 > limit and conserve battery/
> > make sure machine does not overheat  with it...
> 
> echo 7 > throttling should do the same thing. 

Will not first change in thermal system unthrottle it for me, behind
my back?

> However, don't expect any
> battey conservation if ACPI C2 throttling works, and to set custom levels
> against "overheating" there's a write access to
> /proc/acpi/thermal/*/trip_points too...

I'd should not expect battery conservation *when cpu is idle*. If I'm
moving windows in X, 0:7 limit will actually help. And it should allow
battery to be drained further by limiting maximum amps eaten by
CPU. [Ok, that's little evil, but being able to run for 30 minutes+ on
0% battery is nice ;-)].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
