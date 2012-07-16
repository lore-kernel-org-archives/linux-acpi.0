From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCI ACPI/IRQ-routing broken on H77 chipset + Ivy Bridge (kernel
 3.5-rc7 and earlier)
Date: Mon, 16 Jul 2012 10:14:56 -0600
Message-ID: <CAErSpo6Ka6XBakVZH7ge-==XY86FrOHP_dqGoa+zAFNgnnnFTA@mail.gmail.com>
References: <5002BC55.3050107@gmx.de> <201207152225.49154.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201207152225.49154.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

[CC +tglx]

On Sun, Jul 15, 2012 at 2:25 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> CC-ing linux-pci and Bjorn.
>
> On Sunday, July 15, 2012, Malte Schr=F6der wrote:
>> Hello,
>> this is yet another try to get someone to look at this ;)
>>
>> I can't get PCI-devices to work on my DH77KC mainboard. I tested thi=
s
>> using an AVM B1 ISDN card, a Fritz!PCI card and an old 3Com 905c NIC=
=2E
>> I attached some dumps in case it helps. The CPU is a Core i7 3770.
>>
>> PCI hardware is detected by the kernel, but it gives IRQ errors. Usi=
ng
>> irqpoll allows the PCI card to somewhat work, but it is unreliable.
>>
>> There are some reports in Intel's support forums that also report
>> PCI-problems with this mainboard, but Intel doesn't seem to be
>> interested. So I hope this is something that is fixable on the kerne=
l side.
>>
>> If there is more information needed, please let me know.
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
