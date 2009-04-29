From: Marcin Gozdalik <gozdal@gmail.com>
Subject: Re: ACPI Exception
Date: Wed, 29 Apr 2009 11:51:26 +0200
Message-ID: <fab5b76e0904290251m7d7cb01arae437de5fc944661@mail.gmail.com>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
	<1240448177.7661.515.camel@rzhang-dt> <fab5b76e0904230312o2c59d007nb865cff87dbae58e@mail.gmail.com>
	<1240556138.7661.592.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:40092 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbZD2Jvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 05:51:46 -0400
Received: by yx-out-2324.google.com with SMTP id 3so628523yxj.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2009 02:51:46 -0700 (PDT)
In-Reply-To: <1240556138.7661.592.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I am running the modified DSDT for the last 24 hours and the trip
point has not been triggered. Sometimes it happen after longer time
though.
The fixed DSDT does not help for "ACPI: Unable to turn cooling device
[ffff88006f851800] 'off'" messages after S3 suspend/resume cycle.

Best regards

2009/4/24 Zhang Rui <rui.zhang@intel.com>
>
> [ =C2=A0 =C2=A01.380272] ACPI Warning (nspredef-0858): \_TZ_.THRM._PS=
L: Return
> Package type mismatch at index 0 - found [NULL Object Descriptor],
> expected Reference [20080926]
> [ =C2=A0 =C2=A01.380278] ACPI: Expecting a [Reference] package elemen=
t, found type
> 0
> [ =C2=A0 =C2=A01.380498] thermal LNXTHERM:01: registered as thermal_z=
one0
> [ =C2=A0 =C2=A01.780152] ACPI: Thermal Zone [THRM] (41 C)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_PSL, Package (0x01)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\_PR.CPU0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})
> but
> =C2=A0 =C2=A0Scope (\_PR)
> =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Processor (\_PR.C000, 0x00, 0x00000000, 0x=
00) {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Processor (\_PR.C001, 0x01, 0x00000000, 0x=
00) {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Processor (\_PR.C002, 0x02, 0x00000000, 0x=
00) {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Processor (\_PR.C003, 0x03, 0x00000000, 0x=
00) {}
> =C2=A0 =C2=A0}
>
> CPU0 is not defined, the _PSL should be
> =EF=BB=BF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_PSL, Package (0x01)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\_PR.C000
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})
> this is a BIOS bug to me, please try the customized DSDT attached, an=
d
> attach the dmesg output.
>
> thanks,
> rui
>
> On Thu, 2009-04-23 at 18:12 +0800, Marcin Gozdalik wrote:
> > acpidump (compressed) is attached to the previous mail.
> >
> > I attach the compressed dmesg output. ACPI exception happens during
> > boot but as you can see quite late in the process - around 40 secon=
ds
> > after power up.
> >
> > Currently the kernel is booted with thermal.nocrt=3D1 (otherwise it
> > reboots after a while)
> >
> > Additionaly I noted a problem after resume from S3 - every 2 second=
s
> > such a line lands in kern.log:
> >
> > Apr 23 12:00:22 myth kernel: [22439.016355] ACPI: Unable to turn
> > cooling device [ffff88006f841800] 'off'
> >
> > I attach the full dmesg-suspend.log with full suspend & resume cycl=
e.
> >
> > gozdal@myth:~$ grep . /sys/class/thermal/*/*
> > /sys/class/thermal/cooling_device0/cur_state:1
> > /sys/class/thermal/cooling_device0/max_state:1
> > /sys/class/thermal/cooling_device0/type:Fan
> > /sys/class/thermal/cooling_device1/cur_state:0
> > /sys/class/thermal/cooling_device1/max_state:3
> > /sys/class/thermal/cooling_device1/type:Processor
> > /sys/class/thermal/cooling_device2/cur_state:0
> > /sys/class/thermal/cooling_device2/max_state:3
> > /sys/class/thermal/cooling_device2/type:Processor
> > /sys/class/thermal/thermal_zone0/cdev0_trip_point:1
> > /sys/class/thermal/thermal_zone0/mode:kernel
> > /sys/class/thermal/thermal_zone0/temp:27000
> > /sys/class/thermal/thermal_zone0/trip_point_0_temp:90000
> > /sys/class/thermal/thermal_zone0/trip_point_0_type:critical
> > /sys/class/thermal/thermal_zone0/trip_point_1_temp:80000
> > /sys/class/thermal/thermal_zone0/trip_point_1_type:passive
> > /sys/class/thermal/thermal_zone0/type:acpitz
> >
> >
> > 2009/4/23 Zhang Rui <rui.zhang@intel.com>
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 does the ACPI Exception happen during o=
r after the boot time?
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 please attach the acpidump and full dme=
sg output.
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 please attach the output of "grep . /sy=
s/class/thermal/*/*"
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 thanks,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 rui
> >
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, 2009-04-22 at 23:58 +0800, Marc=
in Gozdalik wrote:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Hi
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > I am seeing the following in logs:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 16:00:07 myth kernel: [ =C2=A0=
 39.354031] ACPI Exception
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > (thermal-0479): AE_ERROR, ACPI therma=
l trip point state
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 changed
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 16:00:07 myth kernel: [ =C2=A0=
 39.354040] Please send
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpidump to
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > linux-acpi@vger.kernel.org
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 16:00:07 myth kernel: [ =C2=A0=
 39.354045] =C2=A0[20080926]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > I am using Ubuntu 9.04:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > root@myth:/home/gozdal# uname -a
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Linux myth 2.6.28-11-generic #42-Ubun=
tu SMP Fri Apr 17
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 01:58:03 UTC
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > 2009 x86_64 GNU/Linux
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Motherboard is Abit AN-M2HD(MCP68) fl=
ashed with the latest
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIOS.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > The machine powers down sometimes bec=
ause of an ACPI trip
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 point:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 17:27:19 myth kernel: [ 5272.0=
04934] ACPI: Critical
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 trip point
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 17:27:19 myth kernel: [ 5272.0=
04952] Critical
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 temperature
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > reached (121 C), shutting down.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 17:27:19 myth kernel: [ 5272.0=
04973] ACPI: Unable to
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 turn
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > cooling device [ffff88006f841800] 'on=
'
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Apr 22 17:27:26 myth kernel: [ 5278.2=
04238] Critical
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 temperature
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > reached (34 C), shutting down.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > although I believe this is an error i=
n measurement, as the
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 temperature
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > probably wouldn't cool in 7 seconds f=
rom 121 to 34 Celsius.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Best regards
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > --
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Marcin Gozdalik <gozdal@gmail.com>
> >
> >
> >
> >
> >
> > --
> > Marcin Gozdalik <gozdal@gmail.com>



--
Marcin Gozdalik <gozdal@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
