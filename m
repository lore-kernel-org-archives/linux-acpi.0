From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 22:03:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040819200305.GA10659@dreamland.darkstar.lan>
References: <1091139240.26511.9.camel@6-allhosts> <200408052153.25467.stefandoesinger@gmx.at> <20040819174319.GB6913@dreamland.darkstar.lan> <200408192038.26959.stefandoesinger@gmx.at>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408192038.26959.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Il Thu, Aug 19, 2004 at 08:38:26PM +0200, Stefan D=F6singer ha scritto:=20
> *This message was transferred with a trial version of CommuniGate(tm) P=
ro*
> > > *the boot-radeon.c program can ROM-post the radeon card(compile wit=
h gcc
> > > boot-radeon.c -o boot-radeon -llrmi) You need the lrmi libs+headers=
. Call
> > > it after resuming from S3.
> >
> > Is this radeon specific? AFAICS it should POST any card, right?
> Ole Rohne says it's an old IBM PC feature:
>=20
> "It is an old IBM PC like feature...
>=20
> If the adapter has BIOS at $0xc000, it is supposed to contain a POST
> entry point at $0xc000,$3 and int10/e6 is supposed to point to it."
>=20
> Just give it a try. Note that the boot-radeon.c has the PCI information=
 1:0:0=20
> hardcoded, so you'll have to edit it if your video card is somewhere el=
se.

I'll give it a try when my notebook comes back from RMA...
The BIOS on my desktop runs the VGA BIOS on S3 resume by itself.

Luca
--=20
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
