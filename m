From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] resend Andrew de Quincey patch, that resolve
	hangs problems
Date: 21 Nov 2003 22:06:18 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069470377.2880.27.camel@dhcppc4>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84DC4@pdsmsx403.ccr.corp.intel.com>
	 <1068179499.3555.26.camel@darkstar.portugal>
	 <1068506148.1703.52.camel@darkstar.portugal>
	 <1068531948.2682.1076.camel@dhcppc4>
	 <1068599493.2115.34.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068599493.2115.34.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-11-11 at 20:11, S=E9rgio Monteiro Basto wrote:
> Windows run with APIC mode (at least is what windows says) and in linux
> we must disable APIC in kernel.

Does Windows have ACPI enabled?  (Device Manager will show ACPI devices,
power button and sleep button will work gracefully).  Does winmsd show
that windows is running in IOAPIC mode?  see this bug report for example
screen shots of what you're looking for:

http://bugzilla.kernel.org/show_bug.cgi?id=3D1164

> > If Windows can run a box in IO-APIC mode, then Linux should be able t=
o
> > do the same.
> >=20
> > I hesitate to integrate Andrew's automatic pic-fallback workaround in=
to
> > the baseline kernel because I'm concerned that it will function
> > perfectly.  If we drop into PIC mode automatically, we may not realiz=
e
> > that we have a significant Linux-specific problem that we might be ab=
le
> > to solve.
>=20
> But we have many reports, for VIA or athlon boards, that resolves the
> problems and we have many problem that wasnt yet resolved.
> In my case, the laptop has 2 years and it is history, so I am not worry
> about what is the real problem.
> Conclusion if you put debug information when drop into pic mode, for me
> it better.=20

The system in the bug report above has a totally screwed up _PRT, and a
broken SCI OVER_RIDE entry in the MADT, yet XP still runs with ACPI
enabled and working, with IOAPIC enabled, and the devices with the
screwed up _PRT entries are working!

PIC-fallback will not get us there.  When we detect a bad _PRT, I think
we need to drop all the way down to pci=3Dnoacpi -- automatically.

This would cover the older machines with IOAPIC that is configured
properly with MPS -- and still allow them to run ACPI.  The newer
machines with IOAPIC and no MPS will need ACPI to get into APIC mode,
and if XP can do it, then Linux should be able to figure out how to do
it too.

So tell me, does booting with "pci=3Dnoacpi" allow your system to boot
with correct interrupts in IOAPIC mode, and with ACPI enabled?

thanks,
-Len




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
