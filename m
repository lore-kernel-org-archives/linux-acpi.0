From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Tue, 2 Mar 2004 11:12:20 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6E87@wdmyexch02.my.asia.wdc.com>
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
To: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Nick Lidakis [mailto:nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org]
> Sent: Tuesday, March 02, 2004 10:57 AM
> To: Ow Mun Heng
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Desktop and S3 suspend the Holy Grail of ACPI?
>=20
>=20
> Ow Mun Heng wrote:
>=20
> > =20
> >
> >>-----Original Message-----
> >>From: Nick Lidakis [mailto:nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org]
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >>Subject: Re: [ACPI] Desktop and S3 suspend the Holy Grail of ACPI?
> >>
> >>
> >>Pavel Machek wrote:
> >>
> >>   =20
> >>
> >>>Hi!
> >>>
> >>>=20
> >>>
> >>>     =20
> >>>
> >>>>>>I tried playing with suspend to disk in kernel 2.6.3. It=20
> >>>>>>           =20
> >>>>>>
> >>was a no go. I=20
> >>   =20
> >>
> >>>>>>have highmem enabled on this machine which has 1 gig of RAM.
> >>>>>>Going to try pmdisk.
> >>>>>>=20
> >>>>>>
> >>>>>>      =20
> >>>>>>
> >>>>>>           =20
> >>>>>>
> >>>>>Forget pmdisk, that will not work anyway. Try running=20
> >>>>>         =20
> >>>>>
> >>without highmem
> >>   =20
> >>
> >>>>>(at least for a test).
> >>>>>    =20
> >>>>>
> >>>>>         =20
> >>>>>
> >>>=20
> >>>
> >>>     =20
> >>>
> >>>>Should I also disable preemption?
> >>>>  =20
> >>>>
> >>>>       =20
> >>>>
> >>>Yes.
> >>>								Pavel
> >>>
> >>>=20
> >>>
> >>>     =20
> >>>
> >>Pavel, I'm having some trouble understanding the swsusp.txt=20
> file. It=20
> >>states: " You must explicitly specify the swap partition to=20
> >>resume from with
> >>``resume=3D'' kernel option."
> >>
> >>my swap partition resides in /dev/hda4
> >>
> >>So I think  I need to do something like this?
> >># Boot up Linux by default.
> >>#
> >>default=3DLinux
> >>
> >>image=3D/vmlinuz
> >>        label=3DLinux
> >>        read-only
> >>append=3D"hda=3Dautotune resume=3D/dev/hda4"   <---- added this
> >>   =20
> >>
> >
> >That's the way I'm doing it on Grub=20
> >
> > =20
> >
> Then it should automatically resume next time the power button is=20
> pressed, no other options need to be passed at the LILO prompt?


Yep.. Er.. I'm using Grub.. but that should be not-related.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
