From: Sean Middleditch <elanthis-LAuFFeG505qL5ISr76wZmQ@public.gmane.org>
Subject: Re: lockup on boot
Date: 29 Sep 2002 20:23:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033345402.26395.21.camel@stargrazer>
References: <1032631567.23480.23.camel@stargrazer>
	<1033239215.3157.2.camel@stargrazer>
	<1033363249.1414.13.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033363249.1414.13.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Oh, joy.  Boy did I screw up buying this thing then.  ::sigh::

I will try disabling APIC.  Do I need to apply this kapcid patch, or is
that rolled into recent acpi patches?

Also, this lack of "performance management" - does this mean it's still
going to over-heat when left on for too long?  It gets *very* hot after
even a little while.

Thanks!

On Mon, 2002-09-30 at 01:20, S=E9rgio Monteiro Basto wrote:
> one compaq presario 7xx?
> welcome we are in black list ;)
> have you disable the APIC ?
>=20
> read this
> http://www.pps.jussieu.fr/%7Ejch/software/presario/
>=20
>=20
>=20
> On Sat, 2002-09-28 at 14:53, Sean Middleditch wrote:
> > Ack, sorry the third post, but it dawns on me I was an idiot and didn't
> > post what machine I'm using:
> >=20
> > It's a Compaq Presario 700US laptop.
> >=20
> > On Sat, 2002-09-21 at 14:06, Sean Middleditch wrote:
> > > Hi,
> > >=20
> > >  Using kernel 2.4.20-pre7 with the 20020918 ACPI patch, I'm unable to
> > > boot the machine.
> > >=20
> > >  With debugin off, it gets as far as
> > > PCI: Using configuration type 1
> > >=20
> > >  Turning debugging on, the messages following the above are
> > > (approximately - no cut and paste ~,^):
> > >=20
> > >  tbxface-0099 [03] Acpi_load_tables    : ACPI Tables successfully loa=
ded
> > > Parsing Methods: ... (many dots)
> > > Table [DSDT] - 441 Objects with 45 Devices 109 Methods 15 Regions
> > > Parsing Methods: (complete lack of dots)
> > > Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
> > > ACPI Namespace successfully loaded at root c02f705c
> > >=20
> > >  And that's it.  It's sat there for around 10 minutes and nothing els=
e
> > > has happened.  Passing pci=3Dnoacpi results in no changes.
> > >=20
> > >  Passing acpi=3Doff, the machine boots up much further, but some devi=
ces
> > > don't seem to work properly (it may just be I didn't add support to t=
he
> > > correct devices in the kernel config - my working kernel is the defau=
lt
> > > Redhat 7.3 pcmcia-cs kernel image, which is great except the laptop g=
ets
> > > rather hotter than it did in WinXP...)
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > -------------------------------------------------------
> > > This sf.net email is sponsored by:ThinkGeek
> > > Welcome to geek heaven.
> > > http://thinkgeek.com/sf
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
>=20




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
