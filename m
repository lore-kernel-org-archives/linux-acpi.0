From: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: 23 Jun 2003 18:14:40 -0700
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <1056417280.10323.148.camel@aldebaran.caltech.edu>
References: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com>
	 <20030623133834.GA2330@brodo.de> <20030623161136.GG19556@poupinou.org>
	 <1056388336.15250.62.camel@ixodes.goop.org>
	 <1056398545.10322.111.camel@aldebaran.caltech.edu>
	 <20030623213726.GA1317@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <20030623213726.GA1317-JhLEnvuH02M@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-06-23 at 14:37, Dominik Brodowski wrote:
> 
> Firstly, please let me explain the goal of the cpufreq project: it is a
> cross-architecture, _generic framework_ which provides

Thanks for your explanation.  My fault was that I was too busy looking
at 2.4.21-ac1 and I didn't realize cpufreq had matured a lot in the
development series and resolved the duplication between it and the ACPI
drivers.

> Because of this, the ACPI P-States driver became a "cpufreq driver" in the
> _development_ series -- see arch/i386/kernel/cpu/cpufreq/acpi.c in latest 
> 2.5. kernels.
> 

Yes, I see that now.  That looks like exactly the right way to do it.

> IMO the ACPI P-States driver should only include the ACPI 2.0 P-States driver,
> and not try to support all other sorts of legacy support and become one
> "mega-driver". Instead, the other information stored in _PCT you talk about 
> should be available to other processor-specific cpufreq drivers which see 
> a need to obtain this information -- ACPI as a library, available to those 
> who want it.
> 

I see your rationale for wanting the P-state driver to be ACPI 2.0-only,
but I think there is some advantage to adding Enhanced Speedstep support
to i386/kernel/cpu/cpufreq/acpi.c rather than just added ACPI query
capabilities to speedstep-centrino.c:

speedstep-centrino.c is very picky about the precise CPU because its
tables are hard-coded with no margin for error.  With ACPI, the test for
Enhanced Speedstep would be more general:
if cpu_has(cpu, X86_FEATURE_EST) is true, and after calling _PDC, if
_PTC returns FFH registers, then treat those registers as MSRs instead
of IO ports.  Thus, it supports any Enhanced Speedstep hardware with a
correct BIOS, not just the ones enumerated by speedstep-centrino.c.

I guess my main point is that in order for speedstep-centrino.c to call
ACPI as a library, it would basically need to use every function already
written in acpi.c.  Why not just dispatch the wrmsr() from acpi.c rather
than the other way around?  It would take probably a 15-line patch to
add Enhanced Speedstep support to acpi.c, but probably would be much
more complicated to query ACPI from speedstep-centrino.c.  For AMD and
Transmeta processors, there would be no point in specific support for
them in acpi.c since ACPI doesn't really provide useful information for
their performance control anyway.

-David
