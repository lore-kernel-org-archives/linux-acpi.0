From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Can't Play avi/mov files after S4 Resume
Date: Fri, 12 Mar 2004 10:25:25 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04A925FF@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Nils Faerber [mailto:nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org]
> Sent: Thursday, March 11, 2004 7:08 PM
> To: Ow Mun Heng
> Cc: Acpi-List (E-mail)
> Subject: Re: [ACPI] Can't Play avi/mov files after S4 Resume
>=20
>=20
> Am Do, den 11.03.2004 schrieb Ow Mun Heng um 06:19:
> > > > -----Original Message-----
> > > > From: Ow Mun Heng=20
> > > > Hi All,
> > > >=20
> > > > RH9 + D600 + 2.6.3 kernel (acpi-20040211 patch + laptop mode)
> > > > suspend is compiled into the kernel
> > > > tg3/sound/usb as modules
> > >   S4 Suspend and resume works Great
> > >
> > > > I've tried S1 and S3..no Dice. The suspend works ok.. but=20
> > > > on powering on.. hard disk spins up.. no Console/X11.
> > > > (I guess this is a known issue)
> > > >=20
> > However, I just found out that Video will not work(after
> > resuming from S4 suspend). Eg: Playing any
> > AVI/MOV etc files. Sound will be Ok but no picture. Xine/Mplayer is=20
> > the same.=20
> > It'll work fine once I perform proper reboot.
> > Any Ideas?
>=20
> Is this using X11/XFree86?
> If yes then check (after resume) with xvinfo if your XVideo extensions
> are still online, I suspect not. Another clue would be to try the x11
> mplayer driver instead of the probable deafult xv driver.
>=20
> If this helps then the video driver of your card is a little=20
> broken and
> does not reinitialise the XV...


Yes.. X11/XFree86

Diff -Nau /tmp/xvinfo-boot /tmp/xvinfo-resume
--- /tmp/xvinfo-boot	2004-03-12 09:19:23.119722264 +0800
+++ /tmp/xvinfo-resume	2004-03-12 09:15:31.000000000 +0800
@@ -27,19 +27,19 @@
               client gettable attribute (current value is 1)
       "XV_BRIGHTNESS" (range -1000 to 1000)
               client settable attribute
-              client gettable attribute (current value is 0)
+              client gettable attribute (current value is -2)
       "XV_CONTRAST" (range -1000 to 1000)
               client settable attribute
-              client gettable attribute (current value is 0)
+              client gettable attribute (current value is -12)
       "XV_SATURATION" (range -1000 to 1000)
               client settable attribute
-              client gettable attribute (current value is 0)
+              client gettable attribute (current value is -2)
       "XV_COLOR" (range -1000 to 1000)
               client settable attribute
-              client gettable attribute (current value is 0)
+              client gettable attribute (current value is -2)
       "XV_HUE" (range -1000 to 1000)
               client settable attribute
-              client gettable attribute (current value is 0)
+              client gettable attribute (current value is -2)
       "XV_RED_INTENSITY" (range -1000 to 1000)
               client settable attribute
               client gettable attribute (current value is 0)

So.. Seems to me that everything's OK I guess. Unless the "-2"
are at fault.

I've tried all drivers I guess. I'm using "Auto" in Xine.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
