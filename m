From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 23:37:26 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030623213726.GA1317@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com> <20030623133834.GA2330@brodo.de> <20030623161136.GG19556@poupinou.org> <1056388336.15250.62.camel@ixodes.goop.org> <1056398545.10322.111.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1056398545.10322.111.camel-cfibRQahR+cF6I9xFAAkN5QCsf4PZ8us@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 01:02:25PM -0700, David Moore wrote:
> Thanks for all the responses on this issue.  Forgive my ignorance in
> many cases, I've been involved in this code much less time than most
> people here.

"Fresh", new ideas are always most welcome :-) 


Firstly, please let me explain the goal of the cpufreq project: it is a
cross-architecture, _generic framework_ which provides

a) a standard userspace interface to select certain processor speeds
	(sysfs based in 2.5)
b) another interface to "governors" which decide what speed to set
	(e.g. based on userspace input), and
c) common core functions (so-called notifiers) which update essential
	timing code in the kernel, such as the Time Stamp Counter (TSC) 
	timer.

So, to make life simple for the user (a), to offer him some cool features
(b), and to assure the kernel won't break switching the core frequency
(c) all "processor drivers" which change the processor core frequency should
register themselves as cpufreq drivers.[*]


Because of this, the ACPI P-States driver became a "cpufreq driver" in the
_development_ series -- see arch/i386/kernel/cpu/cpufreq/acpi.c in latest 
2.5. kernels.


Also, you should try to think of ACPI as a "library" which provides useful
helpers for other kernel services -- CPU enumeration, information on how 
IRQs can be routed, information on how a specific device can be put to
sleep. It shouldn't be the ACPI code which is in "control of things", as
there are too many broken BIOSes around, and too many "legacy" systems
can't even spell ACPI at all. Instead, it should but the specific 
__device drivers__  which are in "control of things". Nonetheless, these 
_may_ use ACPI to obtain information/control of the hardware.

> What about this approach as a possible solution to everything that's
> been discussed:
> 
> Patch ACPI as follows: In the case where _PCT returns FFH as the
> register type in processor.c, we would simply call a processor-specific
> function in /arch/i386/ instead of using outb() for the state changes. 

IMO the ACPI P-States driver should only include the ACPI 2.0 P-States driver,
and not try to support all other sorts of legacy support and become one
"mega-driver". Instead, the other information stored in _PCT you talk about 
should be available to other processor-specific cpufreq drivers which see 
a need to obtain this information -- ACPI as a library, available to those 
who want it.

> For those who want to use cpufreq and ACPI simultaneously, they could
> use the cpufreq-ACPI driver, which would now be capable of using the
> appropriate processor-specific functions for state changes with little
> ACPI overhead.

Using some sort of method to switch the core frequency of the processor
without informing the cpufreq core is dangerous. The cpufreq core makes 
sure the timing code in other areas of the kernel is updated.
 
> The only big drawback of this approach is the duplication of code
> between the existing cpufreq drivers and these new processor-specific
> state changing drivers. 

Indeed, and it is unnecessary. What's worth having, though, is a way to pass
the information ACPI possesses to the cpufreq drivers whenever these think
it's necessary.

	Dominik


[*] I know the newly-added drivers/acpi/processor.c in 2.4.22-pre contains
the ACPI P-States 2.0 driver which can't register itself to any cpufreq core
as cpufreq is only part of 2.5. kernels. But this is a different issue.
