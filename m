From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: ACPI Exception
Date: Thu, 30 Apr 2009 09:06:46 +0800
Message-ID: <1241053606.3640.0.camel@localhost.localdomain>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
	 <1240448177.7661.515.camel@rzhang-dt>
	 <fab5b76e0904230312o2c59d007nb865cff87dbae58e@mail.gmail.com>
	 <1240556138.7661.592.camel@rzhang-dt>
	 <fab5b76e0904290251m7d7cb01arae437de5fc944661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61061 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbZD3BFj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2009 21:05:39 -0400
In-Reply-To: <fab5b76e0904290251m7d7cb01arae437de5fc944661@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Gozdalik <gozdal@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-04-29 at 17:51 +0800, Marcin Gozdalik wrote:
> I am running the modified DSDT for the last 24 hours and the trip
> point has not been triggered. Sometimes it happen after longer time
> though.
> The fixed DSDT does not help for "ACPI: Unable to turn cooling device
> [ffff88006f851800] 'off'" messages after S3 suspend/resume cycle.

Will you please add the boot option of "acpi.power_nocheck=3D1" and see
whether the issue still exists?
thanks.
>=20
> Best regards
>=20
> 2009/4/24 Zhang Rui <rui.zhang@intel.com>
> >
> > [    1.380272] ACPI Warning (nspredef-0858): \_TZ_.THRM._PSL: Retur=
n
> > Package type mismatch at index 0 - found [NULL Object Descriptor],
> > expected Reference [20080926]
> > [    1.380278] ACPI: Expecting a [Reference] package element, found=
 type
> > 0
> > [    1.380498] thermal LNXTHERM:01: registered as thermal_zone0
> > [    1.780152] ACPI: Thermal Zone [THRM] (41 C)
> >
> >            Name (_PSL, Package (0x01)
> >            {
> >                \_PR.CPU0
> >            })
> > but
> >    Scope (\_PR)
> >    {
> >        Processor (\_PR.C000, 0x00, 0x00000000, 0x00) {}
> >        Processor (\_PR.C001, 0x01, 0x00000000, 0x00) {}
> >        Processor (\_PR.C002, 0x02, 0x00000000, 0x00) {}
> >        Processor (\_PR.C003, 0x03, 0x00000000, 0x00) {}
> >    }
> >
> > CPU0 is not defined, the _PSL should be
> > =EF=BB=BF
> >            Name (_PSL, Package (0x01)
> >            {
> >                \_PR.C000
> >            })
> > this is a BIOS bug to me, please try the customized DSDT attached, =
and
> > attach the dmesg output.
> >
> > thanks,
> > rui
> >
> > On Thu, 2009-04-23 at 18:12 +0800, Marcin Gozdalik wrote:
> > > acpidump (compressed) is attached to the previous mail.
> > >
> > > I attach the compressed dmesg output. ACPI exception happens duri=
ng
> > > boot but as you can see quite late in the process - around 40 sec=
onds
> > > after power up.
> > >
> > > Currently the kernel is booted with thermal.nocrt=3D1 (otherwise =
it
> > > reboots after a while)
> > >
> > > Additionaly I noted a problem after resume from S3 - every 2 seco=
nds
> > > such a line lands in kern.log:
> > >
> > > Apr 23 12:00:22 myth kernel: [22439.016355] ACPI: Unable to turn
> > > cooling device [ffff88006f841800] 'off'
> > >
> > > I attach the full dmesg-suspend.log with full suspend & resume cy=
cle.
> > >
> > > gozdal@myth:~$ grep . /sys/class/thermal/*/*
> > > /sys/class/thermal/cooling_device0/cur_state:1
> > > /sys/class/thermal/cooling_device0/max_state:1
> > > /sys/class/thermal/cooling_device0/type:Fan
> > > /sys/class/thermal/cooling_device1/cur_state:0
> > > /sys/class/thermal/cooling_device1/max_state:3
> > > /sys/class/thermal/cooling_device1/type:Processor
> > > /sys/class/thermal/cooling_device2/cur_state:0
> > > /sys/class/thermal/cooling_device2/max_state:3
> > > /sys/class/thermal/cooling_device2/type:Processor
> > > /sys/class/thermal/thermal_zone0/cdev0_trip_point:1
> > > /sys/class/thermal/thermal_zone0/mode:kernel
> > > /sys/class/thermal/thermal_zone0/temp:27000
> > > /sys/class/thermal/thermal_zone0/trip_point_0_temp:90000
> > > /sys/class/thermal/thermal_zone0/trip_point_0_type:critical
> > > /sys/class/thermal/thermal_zone0/trip_point_1_temp:80000
> > > /sys/class/thermal/thermal_zone0/trip_point_1_type:passive
> > > /sys/class/thermal/thermal_zone0/type:acpitz
> > >
> > >
> > > 2009/4/23 Zhang Rui <rui.zhang@intel.com>
> > >         does the ACPI Exception happen during or after the boot t=
ime?
> > >         please attach the acpidump and full dmesg output.
> > >
> > >         please attach the output of "grep . /sys/class/thermal/*/=
*"
> > >
> > >         thanks,
> > >         rui
> > >
> > >
> > >         On Wed, 2009-04-22 at 23:58 +0800, Marcin Gozdalik wrote:
> > >         > Hi
> > >         >
> > >         > I am seeing the following in logs:
> > >         >
> > >         > Apr 22 16:00:07 myth kernel: [   39.354031] ACPI Except=
ion
> > >         > (thermal-0479): AE_ERROR, ACPI thermal trip point state
> > >         changed
> > >         > Apr 22 16:00:07 myth kernel: [   39.354040] Please send
> > >         acpidump to
> > >         > linux-acpi@vger.kernel.org
> > >         > Apr 22 16:00:07 myth kernel: [   39.354045]  [20080926]
> > >         >
> > >         > I am using Ubuntu 9.04:
> > >         >
> > >         > root@myth:/home/gozdal# uname -a
> > >         > Linux myth 2.6.28-11-generic #42-Ubuntu SMP Fri Apr 17
> > >         01:58:03 UTC
> > >         > 2009 x86_64 GNU/Linux
> > >         >
> > >         > Motherboard is Abit AN-M2HD(MCP68) flashed with the lat=
est
> > >         BIOS.
> > >         >
> > >         > The machine powers down sometimes because of an ACPI tr=
ip
> > >         point:
> > >         >
> > >         > Apr 22 17:27:19 myth kernel: [ 5272.004934] ACPI: Criti=
cal
> > >         trip point
> > >         > Apr 22 17:27:19 myth kernel: [ 5272.004952] Critical
> > >         temperature
> > >         > reached (121 C), shutting down.
> > >         > Apr 22 17:27:19 myth kernel: [ 5272.004973] ACPI: Unabl=
e to
> > >         turn
> > >         > cooling device [ffff88006f841800] 'on'
> > >         > Apr 22 17:27:26 myth kernel: [ 5278.204238] Critical
> > >         temperature
> > >         > reached (34 C), shutting down.
> > >         >
> > >         > although I believe this is an error in measurement, as =
the
> > >         temperature
> > >         > probably wouldn't cool in 7 seconds from 121 to 34 Cels=
ius.
> > >         >
> > >         > Best regards
> > >         >
> > >         > --
> > >         > Marcin Gozdalik <gozdal@gmail.com>
> > >
> > >
> > >
> > >
> > >
> > > --
> > > Marcin Gozdalik <gozdal@gmail.com>
>=20
>=20
>=20
> --
> Marcin Gozdalik <gozdal@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
