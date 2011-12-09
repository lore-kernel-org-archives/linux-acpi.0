From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Fri, 09 Dec 2011 22:54:20 +0800
Message-ID: <1323442460.20114.95.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: aflinta@gmail.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Artur,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2011-12-09 =E6=96=BC 22:41 +0800=EF=BC=8CLi=
 Joey =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
>=20
> ---------- Forwarded message ----------
> From: Artur Flinta <aflinta@gmail.com>
> Date: 2011/11/24
> Subject: [Bugreport] Screen backllight issues on FirePro M5950 (HP
> EliteBook 8560w)
> To: linux-acpi@vger.kernel.org
>=20
>=20
> Hi!
> I have HP Elitebook 8560w with FirePro M5950, Fedora 16, kernel
> 3.1.1,xorg ati driver 6.14.3 and issues with screen backlight - can't
> dimit.I can write to /sys/class/backlight/acpi_video0/brightness
> valuesfrom 0 to 20 (as stated in max_brightness), but it have no
> effect onthe screen, values in brightness as well as in
> actual_brightnessreflects written number.Before system boot, I can
> change brightness of the screen, and itpersist in operating system.
> Value of the/sys/class/backlight/acpi_video0/brightness indicates
> maximumbrightness (20) even if minimal was set before boot. Kernel
> radeon driver maintainers said, that backlight is driven by APCI
> drivers, so I'm here to ask for help :)
> How can I help to debug this issue? I'm able to recompile kernel and
> apply patches, as well as do some tests. Unfortunately I'm unable to
> write or correct driver code.
> RegardsArtur
> --
> Ka=C5=BCdy problem ma swoje rozwi=C4=85zanie, zatem
> je=C5=BCeli nie ma rozwi=C4=85zania to nie ma problemu.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
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
