From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [kernel 3.13.0-06058-g2d08cd0] Strange ACPI error messages
Date: Sun, 26 Jan 2014 17:31:51 +0800
Message-ID: <52E4D607.6090509@linux.intel.com>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com> <4387759.ffnsEjDaad@vostro.rjw.lan> <20140125161817.GB25531@khazad-dum.debian.net> <2010872.ETICEKhYmO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34450 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbaAZJby (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Jan 2014 04:31:54 -0500
In-Reply-To: <2010872.ETICEKhYmO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, jrg.otte@gmail.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi all,
	I will take care of this issue and send out a patch soon.
Thanks!
Gerry

On 2014/1/26 6:31, Rafael J. Wysocki wrote:
> On Saturday, January 25, 2014 02:18:17 PM Henrique de Moraes Holschuh=
 wrote:
>> On Sat, 25 Jan 2014, Rafael J. Wysocki wrote:
>>> On Saturday, January 25, 2014 02:53:24 PM Rafael J. Wysocki wrote:
>>>> On Saturday, January 25, 2014 11:03:09 AM J=C3=B6rg Otte wrote:
>>>>> Kernel 3.13.0-06058-g2d08cd0 displays following errors on the con=
sole:
>>>>>
>>>>> ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
>>>>> ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
>>>>> ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
>>>>> ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
>>>>>
>>>>> I don't have CPUs 4..7! Error messages regarding not existing
>>>>> CPUs should not be displayed.
>>>>> kernel 3.13.0-05617-g3aacd62 and before did'nt show this messages=
=2E
>>>>>
>>>>> This is a regression. I never saw this messages before.
>>>>
>>>> Does your system show any other suspicious symptoms or are you wor=
ried about
>>>> those messages only?
>>>
>>> Gerry, this is your commit b981513f806d (ACPI / scan: bail out earl=
y if failed
>>> to parse APIC ID for CPU).  Apparently, the BIOS has room for 4 CPU=
s more than
>>> there actually are in the system.  Maybe we can reduce the log leve=
l of those
>>> messages to avoid ringing bells unnecessarily?
>>
>> It is standard practice (at least in SuperMicro boxes, but I've also=
 seen it
>> elsewhere) for the BIOS to have ACPI tables mentioning all cores sup=
ported
>> by the biggest core-count CPU topology possible by the motherboard. =
 The
>> cores you don't have are reported as if they were hotpluggable but a=
bsent,
>> even if they will *never* show up at runtime.  Meh.
>>
>> So yes, such warnings will get annoying *very* quickly.
>=20
> Well, what about using acpi_handle_debug() in there, then?
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
