From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Status of ACPI on IBM T40p & D600
Date: Tue, 10 Feb 2004 10:07:30 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9E580@wdmyexch02.my.asia.wdc.com>
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
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ajp-vB92YU/q1whiLUuM0BA3LQ@public.gmane.org
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Ow Mun Heng=20
> >=20
> > Am Freitag, 6. Februar 2004 21:17 schrieb Bruno Ducrot:
> > > > can you tell me how to remove usb so that my Laptop can=20
> > > > get into C3? It keeps being in C2 and usage of C3 is [000000000]
> > > >
> > > > bus master activity =3D fffffffff all the time..
> > >
> > > Recompiling kernel without any kind of usb things, even=20
> > modules perhap ?
> >=20

Okay.. went back and did just that.. I recompiled my kernel=20
2.4.24 without any usb support at all.

Kernel booted fine.

watch cat /proc/acpi/processor/CPU0/power

yields these sort of bus-master activity.. I don't see the fffffff =
anymore=20
but values for the bus-master changes Every second (eg  below)

bus master : a24as34
bus master : 3ar34f1
bus master : 34a2414

As for C1/C2/C3 states... I still see majority of the time being spent=20
in C2

<snipped from Ari pollak email>
active state:            C2
default state:           C1
bus master activity:     02000008
states:
 C1:      promotion[C2] demotion[--] latency[000] usage[00000010]
*C2:      promotion[C3] demotion[C1] latency[001] usage[01048795]
 C3:      promotion[--] demotion[C2] latency[085] usage[01977750]
</snipped>

Mine shows something like this
 C1:      promotion[C2] demotion[--] latency[000] usage[00022310]
*C2:      promotion[C3] demotion[C1] latency[050] usage[00248795]
 C3:      promotion[--] demotion[C2] latency[050] usage[00000090]

Note the differnce in usage of C3 vs C2 and also the latency.
What the heck is latency anyway? and how come mine's different from=20
Ari's T41??=20

I also created a small bash script to determine my batt life/power
usage from /proc/acpi/battery/BAT0/state

batt-power	- compiled with USB support.
batt-power2 - compiled w/o USB support.

battery life  =3D 2h26m13s	ave power drain =3D 15647mW
battery life2 =3D 2h28m35s	ave power drain =3D 15391mW

batt Life SUCKS.. I'm raring to find out if C3 will help.

Another thing, should I expect the P states to change when going
from AC to Batt? (I seee it's still stucked in P2 which is 1.4Ghz
even if I run on batt.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
