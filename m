From: linux-JhLEnvuH02M@public.gmane.org
Subject: Re: [ACPI] [PATCHES] ACPI Processor update [idle, throttling,
	thermal, cpufreq]
Date: Tue, 9 Sep 2003 19:21:35 +0200
Sender: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030909172135.GA4106@brodo.de>
References: <20030904222434.GC6350@brodo.de>
	<20030908132939.GD3944@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030908132939.GD3944-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
Errors-To: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

Glad you liked [at least parts] of my patches.

On Mon, Sep 08, 2003 at 03:29:40PM +0200, Pavel Machek wrote:
> http://www.brodo.de/cpufreq_tmp/acpi-2.6.0-test4-processor_thermal_throttling
> > 	Move throttling into its own submodule, and register it with the new
> > 	passive cooling module. Also, the now-useless "limit" interface is
> > 	removed.
> > 
> 
> Actually I liked to be able to echo 0:7 > limit and conserve battery/
> make sure machine does not overheat  with it...

echo 7 > throttling should do the same thing. However, don't expect any
battey conservation if ACPI C2 throttling works, and to set custom levels
against "overheating" there's a write access to
/proc/acpi/thermal/*/trip_points too...

	Dominik
