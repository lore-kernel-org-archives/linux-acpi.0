From: peng huang <huangpeng.linux@gmail.com>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Tue, 26 Jan 2010 21:41:00 +0900
Message-ID: <1264509660.29891.7.camel@huang-laptop>
References: <20100126084740.GA5265@jgarrett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:62211 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0AZMlE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2010 07:41:04 -0500
In-Reply-To: <20100126084740.GA5265@jgarrett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi,
can you show me the file /proc/acpi/processor/CPU*/power.
and are you sure your cpu usage is 0 or nearly zero.

this is the info of my laptop(using core 2 processors):
powertop's output:
Cn                Avg residency       P-states (frequencies)
C0 (cpu running)        (10.6%)         2.00 Ghz     1.9%
C0                0.0ms ( 0.0%)         1.67 Ghz     0.1%
C1 mwait          0.0ms ( 0.0%)         1333 Mhz     0.0%
C2 mwait          0.0ms ( 0.0%)         1000 Mhz    98.0%
C3 mwait          1.1ms (89.4%)


and power things:
huang@huang-laptop:~$ cat /proc/acpi/processor/CPU0/power=20
active state:            C0
max_cstate:              C8
maximum allowed latency: 2000000000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--]
latency[001] usage[00002364] duration[00000000000000000000]
    C2:                  type[C2] promotion[--] demotion[--]
latency[001] usage[00070662] duration[00000000000006013816]
    C3:                  type[C3] promotion[--] demotion[--]
latency[017] usage[04774185] duration[00000000010838418152]

you can see C3 with powertop,so i think your BIOS has enabled Deep=20
C-state.

-huang

2010-01-26 (=E7=81=AB) =E3=81=AE 02:47 -0600 =E3=81=AB Jeff Garrett =E3=
=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=E3=81=97=E3=81=9F:
> Hi,
>=20
> I was trying to chase down a theory that my desktop machine (a core i=
7)
> is running warm (the fan sounds like it's at full speed all the time,
> and I think it's not always acted this way -- hence the theory).
>=20
> powertop is never showing it spending any time in C3...
>=20
> I compiled a kernel without USB/sound/radeon, and ran without X.  I w=
as
> able to get the wakeups/sec down below 20, but no time is spent in C3=
=2E
>=20
> sysfs looks to agree with powertop here (time =3D 0 on C3):
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc: CPUIDLE CORE POLL I=
DLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency: 0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name: C0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power: 4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time: 457
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage: 59
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc: ACPI FFH INTEL MWAI=
T 0x0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency: 1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name: C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power: 1000
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time: 308177
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage: 3975
> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc: ACPI FFH INTEL MWAI=
T 0x10
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency: 17
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name: C2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power: 500
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time: 873440787
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage: 239038
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc: ACPI FFH INTEL MWAI=
T 0x20
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency: 17
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name: C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power: 350
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time: 0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage: 0
>=20
> This may be a complete red herring, but I added some printk logic to
> acpi_idle_bm_check(), and it is getting called often, but bm_status i=
s
> always 1.  [I infer from this that the idle logic is trying to go int=
o
> C3, but this check is stopping it...  Unless I misread something.]
>=20
> Is this expected behavior or is this a legitimate problem?
>=20
> How might I investigate this further?
>=20
> Attaching dmesg, /proc/cpuinfo, powertop -d output.
>=20
> Thanks,
> Jeff Garrett


--=20
peng huang <huangpeng.linux@gmail.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
