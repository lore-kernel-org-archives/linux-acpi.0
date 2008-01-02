From: Dominique Michel <dominique.michel@citycable.ch>
Subject: Re: controlling ACPI IRQ routing
Date: Wed, 2 Jan 2008 15:11:42 +0100
Message-ID: <20080102151142.73362648@citycable.ch>
References: <47742083.5060903@howardsilvan.com>
	<477489B8.20700@howardsilvan.com>
	<1198821979.20548.9.camel@sli10-desk.sh.intel.com>
	<200712290339.48354.lenb@kernel.org>
	<47769494.3080503@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.110]:60852 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752716AbYABOJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 09:09:47 -0500
In-Reply-To: <47769494.3080503@howardsilvan.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>, linux-acpi@vger.kernel.org

Le Sat, 29 Dec 2007 10:40:20 -0800,
Lee Howard <faxguy@howardsilvan.com> a =C3=A9crit :


> # cat /proc/interrupts
>            CPU0     =20
>   0: 1051464247   IO-APIC-edge      timer
>   1:          8   IO-APIC-edge      i8042
>   8:          0   IO-APIC-edge      rtc
>   9:          0   IO-APIC-fasteoi   acpi
>  12:        104   IO-APIC-edge      i8042
>  14:    9414304   IO-APIC-edge      ide0
>  16: 1051172722   IO-APIC-fasteoi   wct4xxp
>  19:          1   IO-APIC-fasteoi   eth1
>  21:  158008518   IO-APIC-fasteoi   eth0
>  22:    6974044   IO-APIC-fasteoi   libata
>  23:    7071112   IO-APIC-fasteoi   libata
> NMI:          0
> LOC: 1051371544
> ERR:          0
>=20
>=20

Based on that, you may want to use rtirq. It is a boot script (need sch=
edutils
as dependency) with associated config scripts. http://alsa.opensrc.org/=
Rtirq

In /etc/conf.d/rtirq, you will find:

# IRQ thread service names
# (space separated list, from higher to lower priority).
RTIRQ_NAME_LIST=3D"rtc snd usb i8042"

The most important things is that the devices listed here doesn't have =
any
shared IRQ with some other device and that the rtc remain the first lis=
ted
device (the one with the higer priority), or the system will hang soon =
or later.

This setup is for audio workstation but is very easy to adapt to any ki=
nd of
work.

Dominique
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
