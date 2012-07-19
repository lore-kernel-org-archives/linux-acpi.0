From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>
Subject: Re: PCI ACPI/IRQ-routing broken on H77 chipset + Ivy Bridge (kernel
 3.5-rc7 and earlier)
Date: Thu, 19 Jul 2012 20:14:35 +0200
Message-ID: <50084E8B.3070508@gmx.de>
References: <5002BC55.3050107@gmx.de> <201207152225.49154.rjw@sisk.pl> <CAErSpo6Ka6XBakVZH7ge-==XY86FrOHP_dqGoa+zAFNgnnnFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6Ka6XBakVZH7ge-==XY86FrOHP_dqGoa+zAFNgnnnFTA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Galen Seitz <galens@seitzassoc.com>
List-Id: linux-acpi@vger.kernel.org

On 16.07.2012 18:14, Bjorn Helgaas wrote:

> [CC +tglx]
>=20
> On Sun, Jul 15, 2012 at 2:25 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> CC-ing linux-pci and Bjorn.
>>
>> On Sunday, July 15, 2012, Malte Schr=F6der wrote:
>>> Hello,
>>> this is yet another try to get someone to look at this ;)
>>>
>>> I can't get PCI-devices to work on my DH77KC mainboard. I tested th=
is
>>> using an AVM B1 ISDN card, a Fritz!PCI card and an old 3Com 905c NI=
C.
>>> I attached some dumps in case it helps. The CPU is a Core i7 3770.
>>>
>>> PCI hardware is detected by the kernel, but it gives IRQ errors. Us=
ing
>>> irqpoll allows the PCI card to somewhat work, but it is unreliable.
>>>
>>> There are some reports in Intel's support forums that also report
>>> PCI-problems with this mainboard, but Intel doesn't seem to be
>>> interested. So I hope this is something that is fixable on the kern=
el side.
>>>
>>> If there is more information needed, please let me know.
>>>


I was pointed to https://bugzilla.kernel.org/show_bug.cgi?id=3D43238.
I tried the modifications to the DSDT that where proposed there and
voil=E0, the 3c905c started to work :)
So it seems Intel messed up their ACPI-stuff really bad for this
mainboard. I plan to do more testing during the weekend.

--=20
Gru=DF
Malte Schr=F6der
---------------------------------------------------------------------
MalteSch@gmx.de
