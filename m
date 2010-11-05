From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Fri, 5 Nov 2010 20:49:55 +0100
Message-ID: <201011052049.55500.maciej.rutecki@gmail.com>
References: <201011041706.59046.maciej.rutecki@gmail.com> <1288916854.2234.275.camel@rui>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42045 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0KETuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2010 15:50:02 -0400
In-Reply-To: <1288916854.2234.275.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On pi=C4=85tek, 5 listopada 2010 o 01:27:34 Zhang Rui wrote:
> On Fri, 2010-11-05 at 00:06 +0800, Maciej Rutecki wrote:
> > 1.
> > Last known good kernel: 2.6.36
> > Bad kernel: 2.6.37-rc1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > 2. Problem:
> > When I resume computer from s2ram/s2disk and current CPU temp is be=
low
> > lowest trip point, and -- from unknown reason -- fan start in maxim=
um
> > speed it doesn't turn off (it should).
>=20
> could you please attach the output of "grep . /sys/class/thermal/*/*"
> when this happens?
>

Thanks for the answer.

maciek@gumis:~$ grep . /sys/class/thermal/*/*
/sys/class/thermal/cooling_device0/cur_state:0
/sys/class/thermal/cooling_device0/max_state:10
/sys/class/thermal/cooling_device0/type:LCD
/sys/class/thermal/cooling_device1/cur_state:0
/sys/class/thermal/cooling_device1/max_state:10
/sys/class/thermal/cooling_device1/type:Processor
/sys/class/thermal/cooling_device2/cur_state:0
/sys/class/thermal/cooling_device2/max_state:10
/sys/class/thermal/cooling_device2/type:Processor
/sys/class/thermal/cooling_device3/cur_state:1
/sys/class/thermal/cooling_device3/max_state:1
/sys/class/thermal/cooling_device3/type:Fan
/sys/class/thermal/cooling_device4/cur_state:1
/sys/class/thermal/cooling_device4/max_state:1
/sys/class/thermal/cooling_device4/type:Fan
/sys/class/thermal/cooling_device5/cur_state:1
/sys/class/thermal/cooling_device5/max_state:1
/sys/class/thermal/cooling_device5/type:Fan
/sys/class/thermal/cooling_device6/cur_state:1
/sys/class/thermal/cooling_device6/max_state:1
/sys/class/thermal/cooling_device6/type:Fan
/sys/class/thermal/thermal_zone0/cdev0_trip_point:1
/sys/class/thermal/thermal_zone0/cdev1_trip_point:2
/sys/class/thermal/thermal_zone0/cdev2_trip_point:3
/sys/class/thermal/thermal_zone0/cdev3_trip_point:4
/sys/class/thermal/thermal_zone0/mode:enabled
/sys/class/thermal/thermal_zone0/passive:0
/sys/class/thermal/thermal_zone0/temp:27000
/sys/class/thermal/thermal_zone0/trip_point_0_temp:256000
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
/sys/class/thermal/thermal_zone0/trip_point_1_temp:78000
/sys/class/thermal/thermal_zone0/trip_point_1_type:active
/sys/class/thermal/thermal_zone0/trip_point_2_temp:70000
/sys/class/thermal/thermal_zone0/trip_point_2_type:active
/sys/class/thermal/thermal_zone0/trip_point_3_temp:60000
/sys/class/thermal/thermal_zone0/trip_point_3_type:active
/sys/class/thermal/thermal_zone0/trip_point_4_temp:50000
/sys/class/thermal/thermal_zone0/trip_point_4_type:active
/sys/class/thermal/thermal_zone0/type:acpitz
/sys/class/thermal/thermal_zone1/cdev0_trip_point:1
/sys/class/thermal/thermal_zone1/cdev1_trip_point:1
/sys/class/thermal/thermal_zone1/mode:enabled
/sys/class/thermal/thermal_zone1/temp:29000
/sys/class/thermal/thermal_zone1/trip_point_0_temp:90000
/sys/class/thermal/thermal_zone1/trip_point_0_type:critical
/sys/class/thermal/thermal_zone1/trip_point_1_temp:87000
/sys/class/thermal/thermal_zone1/trip_point_1_type:passive
/sys/class/thermal/thermal_zone1/type:acpitz
/sys/class/thermal/thermal_zone2/mode:enabled
/sys/class/thermal/thermal_zone2/passive:0
/sys/class/thermal/thermal_zone2/temp:23000
/sys/class/thermal/thermal_zone2/trip_point_0_temp:105000
/sys/class/thermal/thermal_zone2/trip_point_0_type:critical
/sys/class/thermal/thermal_zone2/type:acpitz
/sys/class/thermal/thermal_zone3/cdev0_trip_point:1
/sys/class/thermal/thermal_zone3/cdev1_trip_point:1
/sys/class/thermal/thermal_zone3/mode:enabled
/sys/class/thermal/thermal_zone3/temp:20000
/sys/class/thermal/thermal_zone3/trip_point_0_temp:90000
/sys/class/thermal/thermal_zone3/trip_point_0_type:critical
/sys/class/thermal/thermal_zone3/trip_point_1_temp:60000
/sys/class/thermal/thermal_zone3/trip_point_1_type:passive
/sys/class/thermal/thermal_zone3/type:acpitz
/sys/class/thermal/thermal_zone4/mode:enabled
/sys/class/thermal/thermal_zone4/passive:0
/sys/class/thermal/thermal_zone4/temp:100000
/sys/class/thermal/thermal_zone4/trip_point_0_temp:110000
/sys/class/thermal/thermal_zone4/trip_point_0_type:critical
/sys/class/thermal/thermal_zone4/type:acpitz

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
