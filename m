From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Tue, 10 Feb 2004 17:36:38 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9E637@wdmyexch02.my.asia.wdc.com>
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
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org [mailto:eric.piel@tremplin-utc.net]

> Quoting Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>:
> > > Some processors seems to support only C1 and C3 states, for=20
> > > instance... mine ;-)
> > > (Pentium III Coppermine). The problem is that, in this case,=20
> > > no promotion or
> > > demotion are linking those two states, therefore the=20
> > > preocessor never goes to C3!
> >=20
> > Hmmm so.. your processor only has C1 and C3 and no C2 right??
> > and you're saying since there's no C2, it will never go to c3
> Exactly. This simple logic is coded in processor.c, the patch=20
> makes it a bit
> more clever...
>=20
> If you want your processor to go to C3 state you'll need to=20
> have your bus master
> activity null (you can check it in=20
> /proc/acpi/processor/CPU0/power). On my
> laptop it requires not playing any sound and not having any=20
> usb device on... not
> so convenient but I've a script that does all those=20
> requirements as soon as I
> close the LID.

Can you post me the script? (off list maybe)
I just recompiled my kernel last night (no-usb, not even modules)
and no sound too since I use ALSA and that needs to be compiled=20
separately.

I still can't really get into C3 much. [00000090] is all I get.
(I've made a separate post about this earlier)

You mentioned Bus master activity null.. what does that mean??

with usb aware kernel     -> bus master activity =3D fffffff
with NON usb aware kernel -> bus master activity =3D aa23as2
					(this value changes very sec!)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
