From: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: 23 Jun 2003 13:02:25 -0700
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <1056398545.10322.111.camel@aldebaran.caltech.edu>
References: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com>
	 <20030623133834.GA2330@brodo.de>  <20030623161136.GG19556@poupinou.org>
	 <1056388336.15250.62.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <1056388336.15250.62.camel-Ir80B/JpJuPj/dU0+sc/eg@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-06-23 at 10:12, Jeremy Fitzhardinge wrote:
> On Mon, 2003-06-23 at 09:11, Ducrot Bruno wrote:
> > Yes.  It can be added.  But do we want to add it?  That's the real
> > question.
> 
> Well, the current scheme only works because there's a small number of
> easily identifiable Enhanced SpeedStep-capable processors which happen
> to use the same encoding for the PERF_CTL register.  It could get more
> complicated in future, and falling back to a table from ACPI may well be
> the appropriate solution for many people - though I would like to
> maintain the tables in speedstep-centrino so that it isn't dependent on
> ACPI.

Thanks for all the responses on this issue.  Forgive my ignorance in
many cases, I've been involved in this code much less time than most
people here.

What about this approach as a possible solution to everything that's
been discussed:

Patch ACPI as follows: In the case where _PCT returns FFH as the
register type in processor.c, we would simply call a processor-specific
function in /arch/i386/ instead of using outb() for the state changes. 
The function would be called with arguments that provide all the
information that ACPI gives us such as the control register, control
value, status value, etc.

This code in /arch/i386/ would be fairly trivial for Enhanced Speedstep:
just a call to wrmsr().  For AMD and Transmeta processors, it would be a
little more complicated since ACPI does not provide all the necessary
information to do the state changes.  Furthermore, the
processor-specific code would not need to be part of the normal ACPI
distribution if necessary -- it has minimal dependencies and could just
reside normally in the kernel.

For those who want to use cpufreq and ACPI simultaneously, they could
use the cpufreq-ACPI driver, which would now be capable of using the
appropriate processor-specific functions for state changes with little
ACPI overhead.

The only big drawback of this approach is the duplication of code
between the existing cpufreq drivers and these new processor-specific
state changing drivers.  Perhaps they could be folded into one by some
changes to the cpufreq API?

Does this seem like a sensible approach?

Regards,

David
