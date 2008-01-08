From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: controlling ACPI IRQ routing
Date: Tue, 08 Jan 2008 11:49:05 -0500
Message-ID: <4783A981.9060003@redhat.com>
References: <47742083.5060903@howardsilvan.com> <47769494.3080503@howardsilvan.com> <20080102151142.73362648@citycable.ch> <200801050051.20947.lenb@kernel.org> <478103EA.6070503@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYAHQtj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jan 2008 11:49:39 -0500
In-Reply-To: <478103EA.6070503@howardsilvan.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On 01/06/2008 11:38 AM, Lee Howard wrote:
> Len Brown wrote:
>> On Wednesday 02 January 2008 09:11, Dominique Michel wrote:
>> =20
>>> Le Sat, 29 Dec 2007 10:40:20 -0800,
>>> Lee Howard <faxguy@howardsilvan.com> a =C3=A9crit :
>>>
>>>
>>>   =20
>>>> # cat /proc/interrupts
>>>>            CPU0        0: 1051464247   IO-APIC-edge      timer
>>>>   1:          8   IO-APIC-edge      i8042
>>>>   8:          0   IO-APIC-edge      rtc
>>>>   9:          0   IO-APIC-fasteoi   acpi
>>>>  12:        104   IO-APIC-edge      i8042
>>>>  14:    9414304   IO-APIC-edge      ide0
>>>>  16: 1051172722   IO-APIC-fasteoi   wct4xxp
>>>>  19:          1   IO-APIC-fasteoi   eth1
>>>>  21:  158008518   IO-APIC-fasteoi   eth0
>>>>  22:    6974044   IO-APIC-fasteoi   libata
>>>>  23:    7071112   IO-APIC-fasteoi   libata
>>>> NMI:          0
>>>> LOC: 1051371544
>>>> ERR:          0
>>>>
>>>>
>>>>      =20
>>> Based on that, you may want to use rtirq. It is a boot script (need
>>> schedutils
>>> as dependency) with associated config scripts.
>>> http://alsa.opensrc.org/Rtirq
>>>
>>> In /etc/conf.d/rtirq, you will find:
>>>
>>> # IRQ thread service names
>>> # (space separated list, from higher to lower priority).
>>> RTIRQ_NAME_LIST=3D"rtc snd usb i8042"
>>>
>>> The most important things is that the devices listed here doesn't
>>> have any
>>> shared IRQ with some other device and that the rtc remain the first
>>> listed
>>> device (the one with the higer priority), or the system will hang
>>> soon or later.
>>>
>>> This setup is for audio workstation but is very easy to adapt to an=
y
>>> kind of
>>> work.
>>>
>>>    =20
>>
>> I've got no experience with the thread priority thing above.
>> However, the better way to handle quality of service contention
>> is to not do the things you don't care about.
>>
>> Does the system really need HZ=3D1000?  you could slow that down to =
100,
>> or run CONFIG_NO_HZ to reduce it even more...
>> Also, on a UP, the LAPIC timer interrupt is redundant --
>> you could build your kernel w/o APIC support or boot with nolapic.
>>
>> This would get rid of the only interrupts which are frequent
>> enough to be competing with the device, clock ticks.
>=20
> If I boot with nolapic then XT-PIC is used, and the wcfxo device ends=
 up
> sharing an IRQ with libata which results in worse performance than wi=
th
> it the way that it is.
>=20

Try nolapic_timer ?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
