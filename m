From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 00:11:49 -0700
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A301@orsmsx401.jf.intel.com>
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
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: David Moore [mailto:dcm-HInyCGIudOg@public.gmane.org]=20
> Given this document, I think I have enough information now to patch
> processor.c to support Enhanced Speedstep on Pentium M for=20
> those BIOSes
> that have a correctly written _PDC method in the DSDT.  Would the
> maintainers of the ACPI driver be willing to accept such a patch?

I don't think so, at least not right now.

_PDC is used for the OS to indicate to the firmware (the AML) if it
supports native CPU perf transitions or not. If it does, then _PCT/_PSS
returns one thing, if it doesn't, _PCT/_PSS returns something else.
Typically, if _PDC is not called, the platform will indicate ACPI 2.0
CPU perf state support instead of native support.

However, since the recently added non-vendor-supported Pentium M cpufreq
driver uses hardcoded tables and cpuid instead of relying on ACPI for
this information anyways, adding _PDC support to processor.c would not
affect its behavior. If that driver were changed to use ACPI for
determining platform capabilities, like Windows and our released binary
driver do, then yes, adding _PDC support would be important.

Regards -- Andy

btw my understanding is that _PDC will be actually in the ACPI spec in
the near future.
