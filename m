From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Now Can't Play avi/mov files [was Success  : S4 Suspend to Disk on D600]
Date: Tue, 2 Mar 2004 17:53:21 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6F14@wdmyexch02.my.asia.wdc.com>
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
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Ow Mun Heng=20
> Sent: Monday, March 01, 2004 11:42 AM
> To: Acpi-List (E-mail)
> Subject: [ACPI] Success : S4 Suspend to Disk on D600
>=20
>=20
> Hi All,
>=20
> RH9 + D600 + 2.6.3 kernel (acpi-20040211 patch + laptop mode)
> suspend is compiled into the kernel
> tg3/sound/usb as modules
>=20
> I just want to report success with this configuration.
> To suspend, I need to 1st, remove tg3 (ethernet) modules.
> Then I blank the display (xset, though it's not really good since
> we go back to console and ACPI spits out messages)
> USB is dead after resuming.. but doing a rmmod uhci_hcd and then
> modprobing it resurrected the usb.
>=20
>=20
> Suspend is initiated using echo 4 > /proc/acpi/sleep and using=20
> the Fn-Suspend key passing to acpid events. Kinda long to=20
> write 500+Mb=20
> but.. oh what the heck. it's Good)
>=20
>=20
> I've tried S1 and S3..no Dice. The suspend works ok.. but=20
> on powering on.. hard disk spins up.. no Console/X11.
> (I guess this is a known issue)
>=20
> I've yet to try removing sound and usb modules from the kernel.
> More experimenting needed to see if S1 and S3 works.
>=20
>=20
> PS : S3/S1 is useful only because it resumes Fast right? but still
> draws power. hmm.. might not be so useful for me. :)


Few more things..

USB will work okay once I get the control script to rmmod and modprobe
them back in.

However, I just found out that Video will not work. Eg: Playing any
AVI/MOV etc files. Sound will be Ok but no picture. Xine/Mplayer is=20
the same.=20

running Xine from the command line I see that it can't load any of
the video drivers.

eg: failed to load video output plugins aadxr3=20
						    dxr3
						    xv
						    /dev/em8300-0
It'll work fine once I perform proper reboot.

Any Ideas?


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
