From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Missing MODALIAS in /sys/devices/system/cpu/uevent
Date: Thu, 27 Nov 2014 21:39:42 +0100
Message-ID: <1716071.jpYXuFBQgb@vostro.rjw.lan>
References: <201411272101.11811@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201411272101.11811@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 27, 2014 09:01:11 PM Pali Roh=C3=A1r wrote:
>=20
> --nextPart2712852.Yg3XtZvm05
> Content-Type: Text/Plain;
>   charset=3D"utf-8"
> Content-Transfer-Encoding: quoted-printable
>=20
> Hello,
>=20
> on 3.18-rc5 I have empty cpu uevent file, but modalias file is=3D20
> populated. See:
>=20
> $ cat /sys/devices/system/cpu/uevent=3D20
> $ cat /sys/devices/system/cpu/modalias=3D20
> cpu:type:x86,ven0000fam0006mod003C:feature:,0000,0001,0002,0003,0004,=
0005,0=3D
> 006,0007,0008,0009,000B,000C,000D,000E,000F,0010,0011,0013,0015,0016,=
0017,0=3D
> 018,0019,001A,001B,001C,001D,001F,002B,0034,003A,003B,003D,0068,006B,=
006C,0=3D
> 06D,006F,0070,0072,0074,0075,0076,0078,007C,007D,0080,0081,0082,0083,=
0084,0=3D
> 085,0086,0087,0088,0089,008B,008C,008D,008E,008F,0091,0093,0094,0095,=
0096,0=3D
> 097,0098,0099,009A,009B,009C,009D,009E,00C0,00C5,00E0,00E1,00E3,00E5,=
00E6,0=3D
> 0E7,0100,0101,0102,0103,0104,0120,0121,0123,0124,0125,0127,0128,0129,=
012A,0=3D
> 12B,012D,0140
>=20
> =3D46or all other devices in /sys/devices/ which have modalias=3D20
> content there is also MODALIAS=3D3D line in uevent file.

/sys/devices/system/cpu/ is not a device.  It is a "collection of all C=
PUs".

> Is cpu device special? Or why it is only one device which has=3D20
> modalias file but is missing MODALIAS=3D3D line in uevent file?

Look into the uevent files under /sys/devices/system/cpu/cpu0/ etc.

> What userspace application should use for reading modalias=3D20
> string? File modalias or file uevent?

The cpu modalias is used to trigger loading of some CPU-specific module=
s
upfront IIRC.  So yes, it is special.

My advice would be to follow udev here.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
