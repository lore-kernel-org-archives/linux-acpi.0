From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 14:27:32 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030623122732.GY19556@poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A301@orsmsx401.jf.intel.com> <1056354807.10323.71.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1056354807.10323.71.camel-cfibRQahR+cF6I9xFAAkN5QCsf4PZ8us@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 12:53:27AM -0700, David Moore wrote:
> On Mon, 2003-06-23 at 00:11, Grover, Andrew wrote:
> > > From: David Moore [mailto:dcm-HInyCGIudOg@public.gmane.org] 
> > > Given this document, I think I have enough information now to patch
> > > processor.c to support Enhanced Speedstep on Pentium M for 
> > > those BIOSes
> > > that have a correctly written _PDC method in the DSDT.  Would the
> > > maintainers of the ACPI driver be willing to accept such a patch?
> > 
> > I don't think so, at least not right now.
> > 
> > However, since the recently added non-vendor-supported Pentium M cpufreq
> > driver uses hardcoded tables and cpuid instead of relying on ACPI for
> > this information anyways, adding _PDC support to processor.c would not
> > affect its behavior. If that driver were changed to use ACPI for
> > determining platform capabilities, like Windows and our released binary
> > driver do, then yes, adding _PDC support would be important.
> > 
> 
> My intention was not for processor.c and cpufreq to cooperate, but
> rather for processor.c to be able to control Enhanced Speedstep solely
> with P-states -- no cpufreq necessary.  Cpufreq is certainly useful for
> those systems not running the ACPI driver, but in the long run, ACPI and
> processor.c seem to be the right way to get maximum compatibility with
> many platforms.
> 
> If my understanding is correct, once _PDC is called, the only change
> necessary to drive Enhanced Speedstep with P-states is simply to
> interpret the registers returned by _PCT and if they are of type
> FixedHardware, to use wrmsr() instead of outb().  I'm slightly
> oversimplifying, but such an approach works on my system.
> 
> I only have two concerns:
> 1) If the processor is an AMD or a Transmeta, it looks like _PCT may
> also return FixedHardware registers for their respective power
> management systems.  Do we need to read cpuid to treat these cases
> differently in processor.c, or will the blind wrmsr() do the trick?

For AMD athlons, most of the time, the returned values for _PCT
are FixedHardware address 0.  Therefore, this will not work (writing to
msr 0 will be probably 'interessting', but I doubt that will
change the freq/voltage for this cpu).

More, actually, Athlons with PowerNow have to write to 2 MSRs, not
only one.

You have to consider that all of this returned values after calling
the _PCT() and _PSS() methods, *when FixedHardware is returned by
_PCT*, have to be passed to an *external, per cpu, driver*.
No way to make the acpi processor generic, or you have to consider
all cases (PowerNow, LongRun, Enhanced SpeedStep, what ever) after
retrieving the correct cpu model.

And even in that situation, you are not assured that better
tables may be retrieven by other means (only 5 states by ACPI in
one of my laptops, a PB laptop, but 9 states by parsing a BIOS
table for an AMD mobile Athlon 2200+, which seems to be used
even by Windows OS, not ACPI).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
