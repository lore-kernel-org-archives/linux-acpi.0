From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: armada 1750
Date: Fri, 9 Apr 2004 15:55:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F2353@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: cristian.cimpianu-oe7qfRrRQffoK229JIzMLneTipRkpopC@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Well, _DIS isn't supposed to return a value anyway -- so don't worry
about the warnings.

You have to admit, this code is a bit funky:

            Method (_DIS, 0, NotSerialized)
            {
                If (LEqual (^_STA (), 0x0D))
                {
                    Return (0x00)
                }

                \C05E (0x02, 0x49, 0x00, 0x00)
                \C05E (0x02, 0x4A, 0x00, 0x00)
                \C05E (0x03, 0x00, 0x00, 0x00)
                Store ("Exit of _DIS in modemdev.asl", Debug)
            }

dsdt.dsl  1876:             Method (_DIS, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return a
value (_DIS)

It's all moot, since the only invocation of _DIS in your DSDT doesn't
use the return value.

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Cristian Cimpianu
> Sent: Friday, April 09, 2004 5:49 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] armada 1750
>=20
> Hi,
>=20
> ever since upgrading to 2.6.x I've been having problems with acpi in
the
> sense
> that's not really working. it's much better than letting everything
for
> apm
> to do as my processor was almost in flames and the fan wouldn't start.
> Now the most annoying thing: the fan doesn't start until the
temerature
> goes
> above 85 so I start the machine, wait until it gets hot and then
restart,
> otherwise it would shut down on it's own. After starting, the fan
won't
> stop
> and the processor stabilizes at about 60.
> I'm with a 2.6.5, I installed the patch for reading the dsdt from
initrd
> and I
> tried fixing (just a couple of removed stars *) the original dsdt and
I'm
> left with seven times the warning:
> "Not all control paths return a value (_DIS)"
> I also tried the dsdt in the database even though it's for a different
> machine, but it seems to be the same configuration. The fan still
doesn't
> stop and the next suspect is the C2 state the processor is in. How
exactly
> do
> I take that out of processor.c and what othe suggestions do you have?
>=20
>=20
> I'm just gonna attach the dsdt I tryied to fix.
> Thanks a lot,
> Cristian
> --
> http://sonty.go.ro


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
