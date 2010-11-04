From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Thu, 4 Nov 2010 17:06:58 +0100
Message-ID: <201011041706.59046.maciej.rutecki@gmail.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

1.=20
Last known good kernel: 2.6.36
Bad kernel: 2.6.37-rc1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

2. Problem:
When I resume computer from s2ram/s2disk and current CPU temp is below =
lowest=20
trip point, and -- from unknown reason -- fan start in maximum speed it=
=20
doesn't turn off (it should).

It doesn't happen always but only when fan starts work and any of trip =
points=20
aren't exceed. It seems that system only check temperature when exceed =
trip=20
point.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

3. /sys/cass/thermal/ info:

I have:
maciek@gumis:/sys/class/thermal$ ls
cooling_device0  cooling_device2  cooling_device4  cooling_device6 =20
thermal_zone1  thermal_zone3
cooling_device1  cooling_device3  cooling_device5  thermal_zone0   =20
thermal_zone2  thermal_zone4

maciek@gumis:/sys/class/thermal$ cat cooling_device*/type=20
LCD
Processor
Processor
=46an
=46an
=46an
=46an

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Colling device from 3 to 6 are inform what is current fan speed, for ex=
ample:
cooling_device3 =3D 0
cooling_device4 =3D 0
cooling_device5 =3D 0
cooling_device6 =3D 0=20
Means that fan is off.

cooling_device3 =3D 0
cooling_device4 =3D 0
cooling_device5 =3D 0
cooling_device6 =3D 1
Means fan works on 40% of full speed (1st trip point is exceed).

cooling_device3 =3D 1
cooling_device4 =3D 1
cooling_device5 =3D 1
cooling_device6 =3D 1
Means fan works on full speed (all (4) trip points is exceed).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

5. State when fan works on full speed after resume:
maciek@gumis:/sys/class/thermal$ cat cooling_device*/cur_state
0
0
0
1
1
1
1
(Runs on full speed)

maciek@gumis:/sys/class/thermal$ cat thermal_zone0/trip_point_*
256000
critical
78000
active
70000
active
60000
active
50000
active

(It's OK for current CPU temp)

"sensors" command shows:
maciek@gumis:/sys/class/thermal$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +37.0=B0C  (crit =3D +256.0=B0C)                 =20
temp2:       +42.0=B0C  (crit =3D +90.0=B0C)                 =20
temp3:       +33.0=B0C  (crit =3D +105.0=B0C)                 =20
temp4:       +20.0=B0C  (crit =3D +90.0=B0C)                 =20
temp5:      +100.0=B0C  (crit =3D +110.0=B0C)

"temp1" in this model of HP notebook is only for debug purposes (I thin=
k).
"temp2" shows CPU temp (fan speed depends on it)
"temp5" shows fan speed in % of maximum speed.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

6. I run this command, to "hot" the processor:
"while true; do echo -n; done"
and cancel it, when I see, that first trip point was exceed, and fan st=
arts=20
working on lower speed.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

7. When it done I saw:
maciek@gumis:/sys/class/thermal$ cat cooling_device*/cur_state
0
0
0
0
0
0
1

=46an works on 40% of full speed. It's OK.

maciek@gumis:/sys/class/thermal$ cat thermal_zone0/trip_point_*
256000
critical
78000
active
70000
active
60000
active
45000
active

Last trip point was changed from 50000 to 45000 because trip point was =
exceed=20
(it's OK, fan stops working below 45*C or starts working on 60% speed, =
above=20
60*C).

"sensors" show:
maciek@gumis:/sys/class/thermal$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +50.0=B0C  (crit =3D +256.0=B0C)                 =20
temp2:       +48.0=B0C  (crit =3D +90.0=B0C)                 =20
temp3:       +34.0=B0C  (crit =3D +105.0=B0C)                 =20
temp4:       +20.0=B0C  (crit =3D +90.0=B0C)                 =20
temp5:       +40.0=B0C  (crit =3D +110.0=B0C)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Dmesg:
http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/dmesg-2.6.37-rc=
1.txt

acpidump:
http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/acpidump.dat

Config:
http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/config-2.6.37-r=
c1

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
