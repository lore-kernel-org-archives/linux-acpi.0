From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Fri, 05 Nov 2010 08:27:34 +0800
Message-ID: <1288916854.2234.275.camel@rui>
References: <201011041706.59046.maciej.rutecki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab0KEA1J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Nov 2010 20:27:09 -0400
In-Reply-To: <201011041706.59046.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "maciej.rutecki@gmail.com" <maciej.rutecki@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, 2010-11-05 at 00:06 +0800, Maciej Rutecki wrote:
> 1.=20
> Last known good kernel: 2.6.36
> Bad kernel: 2.6.37-rc1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 2. Problem:
> When I resume computer from s2ram/s2disk and current CPU temp is belo=
w lowest=20
> trip point, and -- from unknown reason -- fan start in maximum speed =
it=20
> doesn't turn off (it should).
>=20
could you please attach the output of "grep . /sys/class/thermal/*/*"
when this happens?

thanks,
rui

> It doesn't happen always but only when fan starts work and any of tri=
p points=20
> aren't exceed. It seems that system only check temperature when excee=
d trip=20
> point.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 3. /sys/cass/thermal/ info:
>=20
> I have:
> maciek@gumis:/sys/class/thermal$ ls
> cooling_device0  cooling_device2  cooling_device4  cooling_device6 =20
> thermal_zone1  thermal_zone3
> cooling_device1  cooling_device3  cooling_device5  thermal_zone0   =20
> thermal_zone2  thermal_zone4
>=20
> maciek@gumis:/sys/class/thermal$ cat cooling_device*/type=20
> LCD
> Processor
> Processor
> Fan
> Fan
> Fan
> Fan
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Colling device from 3 to 6 are inform what is current fan speed, for =
example:
> cooling_device3 =3D 0
> cooling_device4 =3D 0
> cooling_device5 =3D 0
> cooling_device6 =3D 0=20
> Means that fan is off.
>=20
> cooling_device3 =3D 0
> cooling_device4 =3D 0
> cooling_device5 =3D 0
> cooling_device6 =3D 1
> Means fan works on 40% of full speed (1st trip point is exceed).
>=20
> cooling_device3 =3D 1
> cooling_device4 =3D 1
> cooling_device5 =3D 1
> cooling_device6 =3D 1
> Means fan works on full speed (all (4) trip points is exceed).
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 5. State when fan works on full speed after resume:
> maciek@gumis:/sys/class/thermal$ cat cooling_device*/cur_state
> 0
> 0
> 0
> 1
> 1
> 1
> 1
> (Runs on full speed)
>=20
> maciek@gumis:/sys/class/thermal$ cat thermal_zone0/trip_point_*
> 256000
> critical
> 78000
> active
> 70000
> active
> 60000
> active
> 50000
> active
>=20
> (It's OK for current CPU temp)
>=20
> "sensors" command shows:
> maciek@gumis:/sys/class/thermal$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +37.0=C2=B0C  (crit =3D +256.0=C2=B0C)                 =20
> temp2:       +42.0=C2=B0C  (crit =3D +90.0=C2=B0C)                 =20
> temp3:       +33.0=C2=B0C  (crit =3D +105.0=C2=B0C)                 =20
> temp4:       +20.0=C2=B0C  (crit =3D +90.0=C2=B0C)                 =20
> temp5:      +100.0=C2=B0C  (crit =3D +110.0=C2=B0C)
>=20
> "temp1" in this model of HP notebook is only for debug purposes (I th=
ink).
> "temp2" shows CPU temp (fan speed depends on it)
> "temp5" shows fan speed in % of maximum speed.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 6. I run this command, to "hot" the processor:
> "while true; do echo -n; done"
> and cancel it, when I see, that first trip point was exceed, and fan =
starts=20
> working on lower speed.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 7. When it done I saw:
> maciek@gumis:/sys/class/thermal$ cat cooling_device*/cur_state
> 0
> 0
> 0
> 0
> 0
> 0
> 1
>=20
> Fan works on 40% of full speed. It's OK.
>=20
> maciek@gumis:/sys/class/thermal$ cat thermal_zone0/trip_point_*
> 256000
> critical
> 78000
> active
> 70000
> active
> 60000
> active
> 45000
> active
>=20
> Last trip point was changed from 50000 to 45000 because trip point wa=
s exceed=20
> (it's OK, fan stops working below 45*C or starts working on 60% speed=
, above=20
> 60*C).
>=20
> "sensors" show:
> maciek@gumis:/sys/class/thermal$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +50.0=C2=B0C  (crit =3D +256.0=C2=B0C)                 =20
> temp2:       +48.0=C2=B0C  (crit =3D +90.0=C2=B0C)                 =20
> temp3:       +34.0=C2=B0C  (crit =3D +105.0=C2=B0C)                 =20
> temp4:       +20.0=C2=B0C  (crit =3D +90.0=C2=B0C)                 =20
> temp5:       +40.0=C2=B0C  (crit =3D +110.0=C2=B0C)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Dmesg:
> http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/dmesg-2.6.37-=
rc1.txt
>=20
> acpidump:
> http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/acpidump.dat
>=20
> Config:
> http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/config-2.6.37=
-rc1
>=20
> Regards


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
