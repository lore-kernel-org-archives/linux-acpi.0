From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 02:19:27 -0700
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: David Moore [mailto:dcm-HInyCGIudOg@public.gmane.org]=20
> My intention was not for processor.c and cpufreq to cooperate, but
> rather for processor.c to be able to control Enhanced Speedstep solely
> with P-states -- no cpufreq necessary.  Cpufreq is certainly=20
> useful for
> those systems not running the ACPI driver, but in the long=20
> run, ACPI and
> processor.c seem to be the right way to get maximum compatibility with
> many platforms.

> I only have two concerns:
> 1) If the processor is an AMD or a Transmeta, it looks like _PCT may
> also return FixedHardware registers for their respective power
> management systems.  Do we need to read cpuid to treat these cases
> differently in processor.c, or will the blind wrmsr() do the trick?

The spec intended FixedFunctionalHW registers to be an "escape hatch".
FFH means that while ACPI is used for perf state enumeration, the
transitions will be handled in a CPU-specific driver, not via methods
described in the ACPI spec. This division (use ACPI for enum, x for
control) isn't currently supported by cpufreq; ACPI either does both
enum and control, or neither.

It is not safe to assume the CPU-specific mechanism will be the same
across vendors, or even across models from the same vendor. Indeed, the
whole point of all this was so these mechanisms could be different, and
remain proprietary.

> 2) If this capability is open-source, do you personally have=20
> a conflict
> of interest between protecting the binary-only module vs.=20
> accepting the
> patch?

Response #1 (practical):
What patch? The patch you haven't written yet? That may or may not be
against files I maintain (as opposed to
arch/i386/kernel/cpu/cpufreq/acpi.c)?

Response #2 (philosophical):
Do you really think a maintainer really has any power? Or just
responsibility?

Regards -- Andy
