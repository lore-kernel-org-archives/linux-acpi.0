From: Heiko =?ISO-8859-1?Q?Ettelbr=FCck?= <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: ACPI & APIC
Date: 16 Oct 2002 19:12:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034788350.1055.7.camel@speedy-gonzales>
References: <20021014105058.7898C2063B@mail.uboot.com>
	<1034711544.1511.2.camel@speedy-gonzales> <3DAD2270.A97616D7@monetplus.cz>
	<200210160913.43931@-mixdown.ca>  <1034785645.3dad936d0b9f2@webmail.sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1034785645.3dad936d0b9f2-2RFepEojUI03ju2hA3itMQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My Compaq Evo N160 hangs while booting even with Local APIC support
disabled. SMP support is disabled, too, according to a hint some nice
guy on this list gave me some weeks ago.

Heiko

Am Mit, 2002-10-16 um 18.27 schrieb =3D?ISO-8859-1?Q?S=3DE9rgio_Montei?=3Dr=
o
Basto:
> Citando Andrew Kohlsmith <akohlsmith-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>:
>=20
> =20
> } You're saying that if you compile the kernel WITHOUT
> } APIC support that you=20
> } don't need pci=3Dnoacpi?  This is a valuable clue I
> } think!  I think I'm going=20
> } to try that in the next day or so and see if it's the
> } same here.
> }=20
> } Maybe the Compaq laptops have bad entries for the
> } APIC initialization in the=20
> } ACPI tables or something.
>=20
> I Have one compaq pressario 706EA.
> even without ACPI pacthes, I have problems with boot and reboot,
> if APIC is enabled.
> The first time that I had install red hat 7.2 on my laptop,
> sometimes give me oops, I after many kernel installations I
> discovered that the problem is with APIC enabled.
> I had try kernel 2.5.x and I had same problem.
>=20
> Btw: as anyone know who or where is develop APIC for kernel 2.4?
>=20
>=20
> S=E9rgio Monteiro Basto
> 	=09
>=20
> --------------------------------------------
> SAPO ADSL.PT Agora o kit apenas por 75 Eur. e tr=E1fego ilimitado at=E9 a=
o final de 2002!
> Mais informa=E7=F5es em http://www.sapo.pt/kitadsl
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by: viaVerio will pay you up to
> $1,000 for every account that you consolidate with us.
> http://ad.doubleclick.net/clk;4749864;7604308;v?
> http://www.viaverio.com/consolidator/osdn.cfm
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel





-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
