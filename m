From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: "TSC cannot be used as a timesource" when on battery
Date: Thu, 11 Mar 2004 13:21:27 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04A92548@wdmyexch02.my.asia.wdc.com>
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
To: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Ow Mun Heng=20
> Sent: Monday, March 01, 2004 10:39 AM
> To: Acpi-List (E-mail)
> Subject: [ACPI] "TSC cannot be used as a timesource" when on battery
>=20
>=20
> Hi All,
>=20
> D600 + RH9 + kernel 2.6.3+acpi20040211
>=20
> Was seeing these error messages when booting from battery.=20
> I've searched through google and the only thing It came up with=20
> was a reference that asks to use ACPI PM as the timesource.
>=20
> I'm currently using RTC (real time clock)
>=20
> I'm still trying to figure out what is the difference between ACPI=20
> PM timesource/RTC.
>=20
> I've not investigated further to determine if my clock is indeed=20
> running slower.=20
>=20
> =3D=3D=3D=3Dstart kernel message=3D=3D=3D=3D=3D=3D=3D
> TSC cannot be used as a timesource.
>  <4> Possible reasons for this are
> You're running with speedstep
> You don't have DMA enabled for your hard drive (See hdparm)
> Incorrect TSC synchronization on an SMP system (dee dmesg)
> Falling back to sane timesource now.
> =3D=3D=3D=3D=3D=3D=3Dend kernel messages=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> HDparm shows all my hd and cdrom are on dma
> This is uniprocessor laptop
>=20
> Yes.. running on speedstep.
> When on AC power, I don't see this error.

Sent this to the list a while back.. I've not
seen any responses. So, asking again, just in case it
was missed (busy schedules etc)

I don't really think it's an issue.. but still would like=20
to know what is triggering it.

Thanks,
Ow

=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
