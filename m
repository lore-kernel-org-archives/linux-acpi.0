From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Fri, 09 Dec 2011 22:49:09 +0800
Message-ID: <1323442149.20114.93.camel@linux-s257.site>
References: <3123346.jTQFjj4kVk@pali-elitebook>
	 <CAGB3EUSiZ+DqTwVQ4CMhT=LNAAWhj-VriiArmoibm0t+x5jLXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAGB3EUSiZ+DqTwVQ4CMhT=LNAAWhj-VriiArmoibm0t+x5jLXw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: pali.rohar@gmail.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Pali,

=E6=96=BC =E4=BA=94=EF=BC=8C2011-12-09 =E6=96=BC 22:36 +0800=EF=BC=8CLi=
 Joey =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
>=20
> ---------- Forwarded message ----------
> From: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Date: 2011/7/15
> Subject: Brightness on HP EliteBook 8460p
> To: linux-acpi@vger.kernel.org
>=20
>=20
> Hello,
>=20
> on my HP EliteBook 8460p is not possible to set display brightness
> when ACPI
> is enabled in kernel. Entries in sysfs is properly created without
> errors. But
> when I try write any value
> to /sys/class/backlight/acpi_video0/brightness
> nothing happened (and no error is in dmesg). When I press Fn key for
> chaining
> display brightness kernel send correct key event (tested with xev) bu=
t
> nothing
> happened too.
>=20
> When I disabled ACPI (acpi=3Doff in kernel command line) all Fn keys =
are
> broken
> and not working (no events in xev). But brightness keys working (I
> think on HW
> level, because xev does not see it) - increase and decrease display
> brightness.
>=20
> So what can I do with my notebook? I think that there is error/bug in
> BIOS or
> ACPI because with disabled ACPI brightness working. But with disabled
> ACPI is
> notebook unuseable (no battery info, no Fn keys, no WIFI rfkill, ...)=
=2E
> Can
> somebody help me with this problem?
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>=20

You can try to put kernel parameter:

	acpi_osi=3D"!Windows 2009"

to /boot/grub/menu.lst, then reboot look at maybe better.

And,=20
could you please kindly share DSDT and dmidecode to me?
Plesae login by root then:
	% acpidump > acpidump.dat
	% dmidecode > dmidecode.log


Thanks a lot!
Joey Lee=20
