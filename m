From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-20031203-2.6.0.diff brokes the battery status readings with 2.6.0 in DELL Inspiron 8500
Date: Fri, 19 Dec 2003 11:11:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8931@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Pere_Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

dmesg from before and after would help, plus the info under =
/proc/acpi/battery.

Thanks,
-Len

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Pere Casta=F1er
> Sent: Thursday, December 18, 2003 7:00 PM
> To: acpi-devel
> Subject: [ACPI] acpi-20031203-2.6.0.diff brokes the battery=20
> status readings with 2.6.0 in DELL Inspiron 8500
>=20
>=20
> I've just aplyied last patch into 2.6.0 stable release and it=20
> brokes the battery monitor from acpi in=20
> /proc/acpi/battery/BAT0/status...because of this=20
> gnome-battery applet don't shows any information.
>=20
> Do you need more information?
>=20
> PS:with acpi included on 2.6.0 all works fine.
>=20
>=20
> --=20
> "Soy una piedra, no muevo ni un m=FAsculo,lentamente me pongo nieve=20
> en la boca para que no vea mi aliento , me tomo mi tiempo,=20
> dejo que se acerque, s=F3lo tengo una bala, apunto a sus ojos, muy=20
> suavemente mi dedo presiona el gatillo,mi pulso no tiembla, no=20
> tengo miedo: ahora ya soy mayor"
> 					     Enemy at gates
> ------
> Pere Casta=F1er Sard=E0=A0 - http://xarz.no-ip.org
> GnuPG Public key available - http://xarz.no-ip.org/keys.html
> Computer Science Student on UOC - http://www.uoc.edu
> Linux Registered User #232073=20
> Debian/GNU User - http://www.debian.org
> ---------------------
>=20


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
