From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: 03 Sep 2003 23:44:43 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1062629083.1608.24.camel@darkstar.portugal>
References: <Pine.LNX.4.44.0309031511420.6102-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0309031511420.6102-100000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Well I am one APIC victim since Jan 2002. almost 2 years.
I suggested build one database of "APIC victims"=20
"Hi I would like make a database of the computers that have to Turning
off APIC.  Model, mother board and chip set, processor type ,  and DSDT
signature.
And put in blacklist.c to give this exactly warning."

But what I would like to say here is: I try to understand where kernel
hangs when I enable APIC and doesn't hangs when IRQ routing is setting,
but hangs before, exactly when try to:
"evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful." this message never appears.

PS: I just don't had begging  the database because, now,  I don't have
any time for that. But I had some ideas, like using  php to upload dsdt
bin and try automatically Disassemble AML to ASL using iasl as cgi etc.=
=20

thanks

On Wed, 2003-09-03 at 19:13, Marcelo Tosatti wrote:
>=20
>=20
> On Wed, 3 Sep 2003, Alan Cox wrote:
>=20
> > On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > > 2.4.22 has the ACPI from 2.6 backported into it, (which includes =
my patch for=20
> > > nforce2 boards) so it will start having the same issue with the B=
IOS bug in=20
> > > KT333/KT400  boards.
> >=20
> > It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> > basically unusable on anything I own thats not intel.=20
>=20
> I've collected a few 2.4.22 ACPI problems and sent them to the ACPI g=
uys.
>=20
> Randy, Len? Any update on any bug?=20
>=20
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.
