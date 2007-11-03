From: "Iacopo Masi" <iacopo.masi.list@gmail.com>
Subject: Re: fan control amilo m1425
Date: Sat, 3 Nov 2007 21:19:22 +0100
Message-ID: <1eca66a80711031319m72993710taeec7f2733f7109e@mail.gmail.com>
References: <1eca66a80711031316q1b133cafg20d2d84eabb93b47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:44302 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbXKCUTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Nov 2007 16:19:24 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1129621fkz
        for <linux-acpi@vger.kernel.org>; Sat, 03 Nov 2007 13:19:23 -0700 (PDT)
In-Reply-To: <1eca66a80711031316q1b133cafg20d2d84eabb93b47@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello linux-acpi user and developers,

I'm using Ubuntu Linux 7.10 with kernel 2.6.22-14-generic and I have
some strange problem with ACPI, therm and fan control.
I use ubuntu since Warty 4.10 and is the same from that distro (and so
that kernel), I think it's a bug in linux kernel or acpi to control
the fan speed of a lots of amilo fujitsu siemens laptop
so I think it is very important to solve.

=46irst of all, after CPU makes some works, the fan is at max speed
making a horrible noise and the /proc fs tells me that the CPU
thempertaure is
always 75=B0C; that is too for a CPU started from 10 min to work: in
Windows with particulare software tool and the right acpi the CPU tmp
goes from 46=B0C to 55=B0C max.

So how could I make the acpi tell the right temp. and to control the
speed of the fan?
I read to decompile that DSTD table via intel compiler. I did it, but
I am not able to rewirte the right DSTD.

=46or more details see my ubuntu post in ubuntuforums [1]
and also a post in amilo-forum [2]

I also think that this bug (of all amilo) is the same as that
launchpad bug #57617 [3]
or the closed kernel linux bug [4]

Here some listings:

$ ls /proc/acpi/
ac_adapter  button               event  info            sleep         w=
akeup
alarm       dsdt                 fadt   power_resource  thermal_zone
battery     embedded_controller  fan    processor       video


$ ls /proc/acpi/fan
$

In fan proc it is not  presente notghins so I CAN'T force fan speed lik=
e

echo -n 3 > /proc/acpi/fan/FAN/state

or like scripts as this found in the net

$ acpi -V
     Thermal 1: ok, 75.0 degrees C
  AC Adapter 1: on-line

$ ls /proc/acpi/thermal_zone/THRM/*
/proc/acpi/thermal_zone/THRM
/cooling_mode
/proc/acpi/thermal_zone/THRM/polling_frequency
/proc/acpi/thermal_zone/THRM/state
/proc/acpi/thermal_zone/THRM/temperature
/proc/acpi/thermal_zone/THRM/trip_points

$ cat /proc/acpi/thermal_zone/THRM/cooling_mode
<setting not supported>

If you want to ask me some ls or dmesg

[1] http://ubuntuforums.org/showthread.php?t=3D600891
[2] http://www.amilo-forum.com/topic,1223,b9d6c29641ad7caaf81b94d5e16f1=
469,-fan-control-on-amilo-series-with-linux.html
[3] https://bugs.edge.launchpad.net/ubuntu/+source/acpi/+bug/57617
[4] http://bugzilla.kernel.org/show_bug.cgi?id=3D5670

--=20
Iacopo Masi
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
