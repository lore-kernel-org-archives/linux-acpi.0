From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: 23 Jun 2003 18:37:15 -0700
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <1056418635.5977.20.camel@sherkaner.pao.digeo.com>
References: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com>
	 <20030623133834.GA2330@brodo.de> <20030623161136.GG19556@poupinou.org>
	 <1056388336.15250.62.camel@ixodes.goop.org>
	 <1056398545.10322.111.camel@aldebaran.caltech.edu>
	 <20030623213726.GA1317@brodo.de>
	 <1056417280.10323.148.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <1056417280.10323.148.camel-cfibRQahR+cF6I9xFAAkN5QCsf4PZ8us@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-06-23 at 18:14, David Moore wrote:
> speedstep-centrino.c is very picky about the precise CPU because its
> tables are hard-coded with no margin for error.  With ACPI, the test for
> Enhanced Speedstep would be more general:
> if cpu_has(cpu, X86_FEATURE_EST) is true, and after calling _PDC, if
> _PTC returns FFH registers, then treat those registers as MSRs instead
> of IO ports.  Thus, it supports any Enhanced Speedstep hardware with a
> correct BIOS, not just the ones enumerated by speedstep-centrino.c.

Hardly any of the code in speedstep-centrino has to do with actually
setting the speed; nor is much of it to do with identifying the CPU and
selecting the right table.  Most of it is to do with being a
well-behaved cpufreq driver.  You would need to move more code than just
the "wrmsr" into acpi.c.

> I guess my main point is that in order for speedstep-centrino.c to call
> ACPI as a library, it would basically need to use every function already
> written in acpi.c.  Why not just dispatch the wrmsr() from acpi.c rather
> than the other way around?  It would take probably a 15-line patch to
> add Enhanced Speedstep support to acpi.c, but probably would be much
> more complicated to query ACPI from speedstep-centrino.c.  For AMD and
> Transmeta processors, there would be no point in specific support for
> them in acpi.c since ACPI doesn't really provide useful information for
> their performance control anyway.

The driver as it stands still has to exist for the case where you're not
using ACPI, but if ACPI is available, using its table is certainly a
useful thing to have.  If the ACPI code for getting that table
information is so complicated, then how about a nice simple entrypoint
which provides the appropiate frequency points with the corresponding
PERF_CTL values?

The core of the tension is whether to put ACPI code under
arch/i386/kernel/cpu/cpufreq or put cpufreq code into drivers/acpi. 
There doesn't seem to be much to choose between the two, but if ACPI is
a mechanism which is supposed to supply services to other drivers, it
doesn't make much sense to migrate all those drivers into drivers/acpi.

	J
