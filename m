From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Mon, 8 Nov 2010 18:35:05 +0100
Message-ID: <201011081835.05733.maciej.rutecki@gmail.com>
References: <201011041706.59046.maciej.rutecki@gmail.com> <201011052049.55500.maciej.rutecki@gmail.com> <1289199532.8148.57.camel@rui>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65219 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0KHRfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2010 12:35:11 -0500
In-Reply-To: <1289199532.8148.57.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On poniedzia=C5=82ek, 8 listopada 2010 o 07:58:52 Zhang Rui wrote:
> IMO, the only one that may cause this regression is commit
> c57b62f5b1e6dd69ff8c96f6db7f86ea31c0e21f
> some app may enable polling via procfs and update the thermal zone
> status.

I revert this commit from 2.6.37-rc1. Still the same:
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
/sys/class/thermal/thermal_zone0/temp:37000
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
/sys/class/thermal/thermal_zone1/temp:36000
/sys/class/thermal/thermal_zone1/trip_point_0_temp:90000
/sys/class/thermal/thermal_zone1/trip_point_0_type:critical
/sys/class/thermal/thermal_zone1/trip_point_1_temp:87000
/sys/class/thermal/thermal_zone1/trip_point_1_type:passive
/sys/class/thermal/thermal_zone1/type:acpitz
/sys/class/thermal/thermal_zone2/mode:enabled
/sys/class/thermal/thermal_zone2/passive:0
/sys/class/thermal/thermal_zone2/temp:33000
/sys/class/thermal/thermal_zone2/trip_point_0_temp:105000
/sys/class/thermal/thermal_zone2/trip_point_0_type:critical
/sys/class/thermal/thermal_zone2/type:acpitz
/sys/class/thermal/thermal_zone3/cdev0_trip_point:1
/sys/class/thermal/thermal_zone3/cdev1_trip_point:1
/sys/class/thermal/thermal_zone3/mode:enabled
/sys/class/thermal/thermal_zone3/temp:30800
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

maciek@gumis:~$ grep . /proc/acpi/thermal_zone/*/*
/proc/acpi/thermal_zone/TZ0/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ0/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ0/state:state:                   active[0]
/proc/acpi/thermal_zone/TZ0/temperature:temperature:             37 C
/proc/acpi/thermal_zone/TZ0/trip_points:critical (S5):           256 C
/proc/acpi/thermal_zone/TZ0/trip_points:passive (forced):<not set>
/proc/acpi/thermal_zone/TZ0/trip_points:active[0]:               78 C:=20
devices=3DC325=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[1]:               70 C:=20
devices=3DC326=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[2]:               60 C:=20
devices=3DC327=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[3]:               50 C:=20
devices=3DC328=20
/proc/acpi/thermal_zone/TZ1/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ1/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ1/state:state:                   ok
/proc/acpi/thermal_zone/TZ1/temperature:temperature:             35 C
/proc/acpi/thermal_zone/TZ1/trip_points:critical (S5):           90 C
/proc/acpi/thermal_zone/TZ1/trip_points:passive:                 87 C: =
tc1=3D1=20
tc2=3D2 tsp=3D300 devices=3DCPU0 CPU1=20
/proc/acpi/thermal_zone/TZ2/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ2/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ2/state:state:                   ok
/proc/acpi/thermal_zone/TZ2/temperature:temperature:             33 C
/proc/acpi/thermal_zone/TZ2/trip_points:critical (S5):           105 C
/proc/acpi/thermal_zone/TZ2/trip_points:passive (forced):<not set>
/proc/acpi/thermal_zone/TZ3/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ3/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ3/state:state:                   ok
/proc/acpi/thermal_zone/TZ3/temperature:temperature:             31 C
/proc/acpi/thermal_zone/TZ3/trip_points:critical (S5):           90 C
/proc/acpi/thermal_zone/TZ3/trip_points:passive:                 60 C: =
tc1=3D1=20
tc2=3D2 tsp=3D300 devices=3DCPU0 CPU1=20
/proc/acpi/thermal_zone/TZ4/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ4/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ4/state:state:                   ok
/proc/acpi/thermal_zone/TZ4/temperature:temperature:             100 C
/proc/acpi/thermal_zone/TZ4/trip_points:critical (S5):           110 C
/proc/acpi/thermal_zone/TZ4/trip_points:passive (forced):<not set>

>=20
> could you please attach the output of "grep . /proc/acpi/thermal/*/*"=
 in
> 2.6.36 kernel?
>=20
2.6.36 after suspend to ram (CPU temp was above 1st trip point):

maciek@gumis:~$ grep . /proc/acpi/fan/*/*
/proc/acpi/fan/C325/state:status:                  off
/proc/acpi/fan/C326/state:status:                  off
/proc/acpi/fan/C327/state:status:                  off
/proc/acpi/fan/C328/state:status:                  on

maciek@gumis:~$ grep . /proc/acpi/thermal_zone/*/*
/proc/acpi/thermal_zone/TZ0/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ0/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ0/state:state:                   active[0]
/proc/acpi/thermal_zone/TZ0/temperature:temperature:             50 C
/proc/acpi/thermal_zone/TZ0/trip_points:critical (S5):           256 C
/proc/acpi/thermal_zone/TZ0/trip_points:passive (forced):<not set>
/proc/acpi/thermal_zone/TZ0/trip_points:active[0]:               78 C:=20
devices=3DC325=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[1]:               70 C:=20
devices=3DC326=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[2]:               60 C:=20
devices=3DC327=20
/proc/acpi/thermal_zone/TZ0/trip_points:active[3]:               45 C:=20
devices=3DC328=20
/proc/acpi/thermal_zone/TZ1/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ1/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ1/state:state:                   ok
/proc/acpi/thermal_zone/TZ1/temperature:temperature:             47 C
/proc/acpi/thermal_zone/TZ1/trip_points:critical (S5):           90 C
/proc/acpi/thermal_zone/TZ1/trip_points:passive:                 87 C: =
tc1=3D1=20
tc2=3D2 tsp=3D300 devices=3DCPU0 CPU1=20
/proc/acpi/thermal_zone/TZ2/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ2/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ2/state:state:                   ok
/proc/acpi/thermal_zone/TZ2/temperature:temperature:             40 C
/proc/acpi/thermal_zone/TZ2/trip_points:critical (S5):           105 C
/proc/acpi/thermal_zone/TZ2/trip_points:passive (forced):<not set>
/proc/acpi/thermal_zone/TZ3/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ3/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ3/state:state:                   ok
/proc/acpi/thermal_zone/TZ3/temperature:temperature:             28 C
/proc/acpi/thermal_zone/TZ3/trip_points:critical (S5):           90 C
/proc/acpi/thermal_zone/TZ3/trip_points:passive:                 60 C: =
tc1=3D1=20
tc2=3D2 tsp=3D300 devices=3DCPU0 CPU1=20
/proc/acpi/thermal_zone/TZ4/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/TZ4/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/TZ4/state:state:                   ok
/proc/acpi/thermal_zone/TZ4/temperature:temperature:             40 C
/proc/acpi/thermal_zone/TZ4/trip_points:critical (S5):           110 C
/proc/acpi/thermal_zone/TZ4/trip_points:passive (forced):<not set>

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
