From: =?iso-8859-1?Q?=D8ystein_Gisn=E5s?= <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
Subject: Re: Wrong AC state
Date: Fri, 28 May 2004 13:16:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040528111652.GD10998@jaguar.stud.ntnu.no>
References: <40B346FC.9090908@mpi-magdeburg.mpg.de> <40B5156F.5020409@epost.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40B5156F.5020409-jy7zG81Tlw8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Ginkel <martin.ginkel-jy7zG81Tlw8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 27, 2004 at 12:08:47AM +0200, Martin Ginkel wrote:
> Martin Ginkel wrote:
> >On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be partially=
=20
> >broken.
> >The /proc/ac_adapter/AC0/state has a value on-line or off-line from=20
> >boot-time and doesn't change later on.
>=20
> OK found a solution while reading the disassembled DSDT:
> The Code ist checking the OS-Version:
>=20
>     Method (_PSR, 0, NotSerialized)
>     {
>       If (LNot (LEqual (FAKE, 0x00)))
>       {
>         Return (0x00)
>       }
>       Else
>       {
>         If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
>           {
>              Store (\_SB.PCI0.SBRG.EC0.XCIN, Local0)
>                                     }
>          Else
>           {
>              Store (ACIN, Local0)
>           }
>=20
>              Return (Local0)
>           }
>      }
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

This did the trick with my Fujitsu-Siemens Amilo D 7830 too.

Thanks!

--=20
=D8ystein Gisn=E5s <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
NTNU, Department of Telematics
Mob: (+47) 98861515 - MSN: oysteing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
