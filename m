From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Wrong AC state
Date: Wed, 26 May 2004 15:16:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055E093AE@orsmsx403.amr.corp.intel.com>
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
To: Martin Ginkel <martin.ginkel-jy7zG81Tlw8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>#define ACPI_OS_NAME               "Microsoft Windows NT"

This has recently been changed to the default ACPI_OS_NAME for all
versions of the ACPI CA code -- for exactly the reasons you describe
below.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Martin Ginkel
> Sent: Wednesday, May 26, 2004 3:09 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org
> Subject: Re: [ACPI] Wrong AC state
>=20
> Martin Ginkel wrote:
> > On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be
partially
> > broken.
> > The /proc/ac_adapter/AC0/state has a value on-line or off-line from
> > boot-time and doesn't change later on.
>=20
> OK found a solution while reading the disassembled DSDT:
> The Code ist checking the OS-Version:
>=20
>      Method (_PSR, 0, NotSerialized)
>      {
>        If (LNot (LEqual (FAKE, 0x00)))
>        {
>          Return (0x00)
>        }
>        Else
>        {
>          If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
>            {
>               Store (\_SB.PCI0.SBRG.EC0.XCIN, Local0)
>                                      }
>           Else
>            {
>               Store (ACIN, Local0)
>            }
>=20
>               Return (Local0)
>            }
>       }
>=20
>=20
> OSFL is returning 0x00 for win2000 and 0x04 for windows nt.
> I defined as a dirty fix:
> ./include/acpi/platform/aclinux.h:50:
> #define ACPI_OS_NAME               "Microsoft Windows NT"
>=20
> Now the Power Monitor reacts instantly.
>=20
> Well: the Bios seems to be designed for Microsoft Windows ;-P
>=20
>=20
> 	CU
> 	Martin
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle
10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
