From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: ACPI + Laptop Power Management
Date: Mon, 1 Dec 2003 09:20:02 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA0338650A@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
> Sent: Friday, November 28, 2003 11:47 PM
> To: Ow Mun Heng
> Cc: Micha Feigin; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI + Laptop Power Management
>=20
>=20
> > I took a look at laptop mode. However, as the author said "it adds a
> > non-significant" amount of battery time.
>=20
> Where have you read that?
> Have you looked at linux/Documentation/laptop-mode.txt?

I took another look at the kernel docs. It _does_ say it adds like 10% =
of
batt time. The initial post about the "NON-significant ..etc" was =
actually
gathered from one website that had the laptop-mode's author email.

=20
>=20
> > The thing here is, even though it's flushing the buffers=20
> when there are
> > others to flush, it makes not difference if the drive is=20
> still spinning and
> > not in standby-mode! I can't figure out what is making the=20
> HD _not_ spin
> > down.
>=20
> man hdparm, hdparm -S something.

That's just for power savings. eg: power management of the HD.. I spin =
the
HD down manually using hdparm -y /dev/hda




>=20
> > BTW, Laptop_mode is merged into the 2.4.23-rc5 kernel (based on the
> > changelogs)
>=20
> As already said.

I took a swipe at kernel 2.4.23 yesterday night. Laptop mode is in..
_however_ cpu frequency scaling is not in there and that's most =
certainly
something that I _need_ ton conserve batt life. I used to get it from =
the
-ac branch but seems like Alan is busy and heven't released anything =
after
2.4.22-ac4.

BTW, anyone know how to get cpufreq into the main kernel. Where can I =
find a
diff or is there another method of cpu freq scaling now??


>=20
> > With regard to ACPId events, can you tell me how yo get it=20
> to work? I'm
> > having problems getting it running. It gets lodaded up=20
> during init, and it's
> > running as root, but after logging in (GDM desktop), the=20
> events won't fire
> > until I kill the acpid process and re-run it again. (once I=20
> logged in)
> > I can't figure out how to get it to work. I read in one=20
> page where the
> > auther said to put xhost +local somewhere at the end of=20
> /etc/X11/xinitrc.
> > That didn't work either.
>=20
> I don't know.  All my scripts for power managements via acpid=20
> certainly
> do not use X.  I am wondering what is inside yours, but if they come
> as default with a distribution, it is probably better to use another
> distribution.
>=20

Fudge that.. I found out how to use xhost properly (finally) yesterday. =
It
seems I missed the ":" in "xhost +local:"

Now screen blanking works great and so does acpid and it's events.

 BTW, I use RedHat 9

Cheers=20

OW


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
