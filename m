From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI_STRICT_COMPLIANCE (was RE: RE: ACPI -- Workaround
	forbroken DSDT)
Date: 12 Feb 2004 15:21:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076617296.12962.799.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6AC@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6AC-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

You must have something specific in mind, b/c I have a more
simple-minded view.  There are two modes

1. default
all workarounds in place (there actually are not very many)
minimum pedantic warnings
users and distros expected to use this mode

2. acpi=strict
all workarounds excluded
maximum pedantic warnings
OEMs, testers, and ACPI developers expected to use this mode.

This is selected at run-time by absence or presence of acpi=strict.
If there is a case where something can't really can't be turned on and
off at run time (the case you're worrying about), then we simply leave
it the way it is now -- always on.

On Thu, 2004-02-12 at 01:32, Yu, Luming wrote:
> 1. A kernel option such as ACPI_STRICT=ON will mess up ACPI CA code at
> run-time.
> For example, a small change to ACPI interpreter without strict
> regression test could break
> other part of ASL codes wich comply to ACPI spec. 

The only regression test we us today is to ship changes to the community
and see if systems run better or run worse.  I don't see this changing.

> 2. How to coordinate various workarounds which could be conflicted with
> each other?

exactly the same way we do today.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
