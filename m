From: peng huang <huangpeng.linux@gmail.com>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Wed, 27 Jan 2010 22:27:17 +0900
Message-ID: <1264598837.32649.9.camel@huang-laptop>
References: <20100126084740.GA5265@jgarrett.org>
	 <1264509660.29891.7.camel@huang-laptop>
	 <20100126145951.GA4987@jgarrett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:45662 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab0A0N1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2010 08:27:20 -0500
In-Reply-To: <20100126145951.GA4987@jgarrett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, huangpeng.linux@gmail.com

2010-01-26 (=E7=81=AB) =E3=81=AE 08:59 -0600 =E3=81=AB Jeff Garrett =E3=
=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=E3=81=97=E3=81=9F:
> On Tue, Jan 26, 2010 at 09:41:00PM +0900, peng huang wrote:
> > Hi,
> > can you show me the file /proc/acpi/processor/CPU*/power.
> > and are you sure your cpu usage is 0 or nearly zero.
>=20
> Yea, I'm pretty sure my cpu usage is nearly zero.  powertop shows few=
er
> than 20 wakeups per second, shows 99% C2 residency, top shows 100% id=
le,
> perf top shows acpi_idle_enter_simple as the most common function
> (~50%).  Very little is running on the box, and I've compiled out the
> heavier parts of the kernel (such as USB)...
>=20
> (It still has ordinary userspace running, e.g. udev & hal, and still =
has
> sshd and network traffic, as examples.)
>=20
> This is all consistent with a very idle machine, I think.

yes,you processor is always in c2,it does means your system is nearly
ilde.

> > this is the info of my laptop(using core 2 processors):
> > powertop's output:
> > Cn                Avg residency       P-states (frequencies)
> > C0 (cpu running)        (10.6%)         2.00 Ghz     1.9%
> > C0                0.0ms ( 0.0%)         1.67 Ghz     0.1%
> > C1 mwait          0.0ms ( 0.0%)         1333 Mhz     0.0%
> > C2 mwait          0.0ms ( 0.0%)         1000 Mhz    98.0%
> > C3 mwait          1.1ms (89.4%)
>=20
> Yea, my laptop also (also core 2) has 700-1000 wakeups/sec and spends
> greater than 80% of its time in C3...  That's partly why I'm curious
> about what my core i7 desktop is doing.

So I think it is a core i7 thing.I have heard that some intel cpu have =
a
problem when in c2-state,maybe that is why you cpu cant enter c3-state.
I think there is some configuration about deep c-state in the bios,may
be you can try it(it cannot solve this problem...).
And in some bios there is a enhanced idle state configuration ,but i
dont known if it is the reason why the cpu cannot enter c3-state.You ca=
n
try it anyway.

With disable the deep c-state you BIOS will not give c3-info to the
OS,then you would see there is no c3-state in the OS.

> > and power things:
> > huang@huang-laptop:~$ cat /proc/acpi/processor/CPU0/power=20
> > active state:            C0
> > max_cstate:              C8
> > maximum allowed latency: 2000000000 usec
> > states:
> >     C1:                  type[C1] promotion[--] demotion[--]
> > latency[001] usage[00002364] duration[00000000000000000000]
> >     C2:                  type[C2] promotion[--] demotion[--]
> > latency[001] usage[00070662] duration[00000000000006013816]
> >     C3:                  type[C3] promotion[--] demotion[--]
> > latency[017] usage[04774185] duration[00000000010838418152]
> >=20
> > you can see C3 with powertop,so i think your BIOS has enabled Deep=20
> > C-state.
>=20
> Here's my power files...
>=20
> /proc/acpi/processor/CPU0/power:
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>     C1:                  type[C1] promotion[--] demotion[--] latency[=
001] usage[00001470] duration[00000000000000000000]
>     C2:                  type[C2] promotion[--] demotion[--] latency[=
017] usage[00234416] duration[00000000017165798539]
>     C3:                  type[C3] promotion[--] demotion[--] latency[=
017] usage[00000000] duration[00000000000000000000]
> /proc/acpi/processor/CPU1/power:
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>     C1:                  type[C1] promotion[--] demotion[--] latency[=
001] usage[00000481] duration[00000000000000000000]
>     C2:                  type[C2] promotion[--] demotion[--] latency[=
017] usage[00090169] duration[00000000017188463157]
>     C3:                  type[C3] promotion[--] demotion[--] latency[=
017] usage[00000000] duration[00000000000000000000]
> /proc/acpi/processor/CPU2/power:
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>     C1:                  type[C1] promotion[--] demotion[--] latency[=
001] usage[00000418] duration[00000000000000000000]
>     C2:                  type[C2] promotion[--] demotion[--] latency[=
017] usage[00068874] duration[00000000017193805291]
>     C3:                  type[C3] promotion[--] demotion[--] latency[=
017] usage[00000000] duration[00000000000000000000]
> /proc/acpi/processor/CPU3/power:
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>     C1:                  type[C1] promotion[--] demotion[--] latency[=
001] usage[00001356] duration[00000000000000000000]
>     C2:                  type[C2] promotion[--] demotion[--] latency[=
017] usage[00362752] duration[00000000017156707397]
>     C3:                  type[C3] promotion[--] demotion[--] latency[=
017] usage[00000000] duration[00000000000000000000]
>=20
> >=20
> > -huang
> >=20
> > 2010-01-26 (=E7=81=AB) =E3=81=AE 02:47 -0600 =E3=81=AB Jeff Garrett=
 =E3=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=E3=81=97=E3=81=9F=
:
> > > Hi,
> > >=20
> > > I was trying to chase down a theory that my desktop machine (a co=
re i7)
> > > is running warm (the fan sounds like it's at full speed all the t=
ime,
> > > and I think it's not always acted this way -- hence the theory).
> > >=20
> > > powertop is never showing it spending any time in C3...
> > >=20
> > > I compiled a kernel without USB/sound/radeon, and ran without X. =
 I was
> > > able to get the wakeups/sec down below 20, but no time is spent i=
n C3.
> > >=20
> > > sysfs looks to agree with powertop here (time =3D 0 on C3):
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/desc: CPUIDLE CORE PO=
LL IDLE
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/latency: 0
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/name: C0
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/power: 4294967295
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/time: 457
> > > /sys/devices/system/cpu/cpu0/cpuidle/state0/usage: 59
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/desc: ACPI FFH INTEL =
MWAIT 0x0
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/latency: 1
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/name: C1
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/power: 1000
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/time: 308177
> > > /sys/devices/system/cpu/cpu0/cpuidle/state1/usage: 3975
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/desc: ACPI FFH INTEL =
MWAIT 0x10
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/latency: 17
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/name: C2
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/power: 500
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/time: 873440787
> > > /sys/devices/system/cpu/cpu0/cpuidle/state2/usage: 239038
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/desc: ACPI FFH INTEL =
MWAIT 0x20
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/latency: 17
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/name: C3
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/power: 350
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/time: 0
> > > /sys/devices/system/cpu/cpu0/cpuidle/state3/usage: 0
> > >=20
> > > This may be a complete red herring, but I added some printk logic=
 to
> > > acpi_idle_bm_check(), and it is getting called often, but bm_stat=
us is
> > > always 1.  [I infer from this that the idle logic is trying to go=
 into
> > > C3, but this check is stopping it...  Unless I misread something.=
]
> > >=20
> > > Is this expected behavior or is this a legitimate problem?
> > >=20
> > > How might I investigate this further?
> > >=20
> > > Attaching dmesg, /proc/cpuinfo, powertop -d output.
> > >=20
> > > Thanks,
> > > Jeff Garrett
> >=20
> >=20
> > --=20
> > peng huang <huangpeng.linux@gmail.com>
> >=20


--=20
peng huang <huangpeng.linux@gmail.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
