From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] restore _OS object to "Linux" for ia64
Date: Mon, 13 Sep 2004 15:59:05 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501FB4ABB@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Gerald Pfeifer <gp-l3A5Bk7waGM@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Here's an example:

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-=20
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Martin Ginkel
> Sent: Wednesday, May 26, 2004 3:09 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org
> Subject: Re: [ACPI] Wrong AC state
>=20
> Martin Ginkel wrote:
> > On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be=20
> > partially broken. The /proc/ac_adapter/AC0/state has a value on-line

> > or off-line from boot-time and doesn't change later on.
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
> Get certified on the hottest thing ever to hit the market... Oracle=20
> 10g. Take an Oracle 10g class now, and we'll give you the exam FREE.=20
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

> -----Original Message-----
> From: Moore, Robert
> Sent: Monday, September 13, 2004 3:11 PM
> To: 'Gerald Pfeifer'
> Cc: Brown, Len; Alex Williamson; linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ACPI
> Developers
> Subject: RE: [ACPI] [PATCH] restore _OS object to "Linux" for ia64
>=20
> I don't know what the specific machines were.  There was lots of
> discussion on the Linux/ACPI list before we did this.  I think they
were
> all 32-bit machines, however.
>=20
>=20
> > -----Original Message-----
> > From: Gerald Pfeifer [mailto:gp-l3A5Bk7waGM@public.gmane.org]
> > Sent: Monday, September 13, 2004 2:30 PM
> > To: Moore, Robert
> > Cc: Brown, Len; Alex Williamson; linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ACPI
> > Developers
> > Subject: RE: [ACPI] [PATCH] restore _OS object to "Linux" for ia64
> >
> > On Mon, 13 Sep 2004, Moore, Robert wrote:
> > > Not only is the !Windows code path apparently untested for the
most
> > > part, we have discovered many machines that simply do not work
> properly
> > > unless we report "Microsoft Windows NT" for the _OS string.
> >
> > Can you name some of these (broken) systems?
> >
> > Given that we apparently did not encounter this with our 2.6.5-based
> SLES9
> > kernel so far, I'm a bit sceptical that many (if any) ia64 machines
are
> > affected.
> >
> > Gerald


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
