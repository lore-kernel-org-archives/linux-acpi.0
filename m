From: Andreas Noever <andreas.noever@gmail.com>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
Date: Tue, 15 Mar 2016 19:03:05 +0100
Message-ID: <CAMxnaaU0B_47xZuD+vi0=b1_U7kPr7YVF5-Y0q3GP3ez_eo3CQ@mail.gmail.com>
References: <56D0085B.60402@jscinoz.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35602 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcCOSD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2016 14:03:26 -0400
In-Reply-To: <56D0085B.60402@jscinoz.so>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Coulter <jscinoz@jscinoz.so>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>

Hi Jack,

On Fri, Feb 26, 2016 at 9:10 AM, Jack Coulter <jscinoz@jscinoz.so> wrot=
e:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi Andreas,
>
> I was asking around on #linux-pci on OFTC and it was mentioned that y=
ou
> were the maintainer for Linux Thunderbolt support, and that I should
> direct my query to you and the linux-pci & linux-kernel lists.
>
> I'm attempting to use the Thunderbolt 3 (which has a USB Type-C
> connector) port on my laptop, a Dell XPS 15 (9550). The external devi=
ce
> I'm attempting to use is a gigabit ethernet + USB 3.0 hub, of an unkn=
own
> / generic brand, but bears model number KY-688 if that's of any use.
>
> When the device is present at system startup, everything works
> correctly, and shows up in lspci as a USB controller, which lsusb sho=
ws
> having a hub and ethernet NIC attached, which the r8152 driver binds =
and
> uses without issue:
>
> lspci -v:
>> 0a:00.0 USB controller: Intel Corporation Device 15b5 (prog-if 30 [X=
HCI])
>>     Subsystem: Device 2222:1111
>>     Flags: bus master, fast devsel, latency 0, IRQ 131
>>     Memory at c4200000 (32-bit, non-prefetchable) [size=3D64K]
>>     Capabilities: [80] Power Management version 3
>>     Capabilities: [88] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
>>     Capabilities: [c0] Express Endpoint, MSI 00
>>     Capabilities: [100] Device Serial Number a3-21-b5-60-a7-23-04-00
>>     Capabilities: [200] Advanced Error Reporting
>>     Capabilities: [300] Virtual Channel
>>     Capabilities: [400] Power Budgeting <?>
>>     Capabilities: [500] Vendor Specific Information: ID=3D1234 Rev=3D=
1
> Len=3D0d8 <?>
>>     Capabilities: [600] Latency Tolerance Reporting
>>     Capabilities: [700] #19
>>     Kernel driver in use: xhci_hcd
>
>
> lspci -tv (Thunderbolt device is 15b5)
>> -[0000:00]-+-00.0  Intel Corporation Sky Lake Host Bridge/DRAM Regis=
ters
>>            +-01.0-[01]----00.0  NVIDIA Corporation GM107M [GeForce G=
TX
> 960M]
>>            +-02.0  Intel Corporation Device 191b
>>            +-04.0  Intel Corporation Device 1903
>>            +-14.0  Intel Corporation Sunrise Point-H USB 3.0 xHCI
> Controller
>>            +-14.2  Intel Corporation Sunrise Point-H Thermal subsyst=
em
>>            +-15.0  Intel Corporation Sunrise Point-H LPSS I2C
> Controller #0
>>            +-15.1  Intel Corporation Sunrise Point-H LPSS I2C
> Controller #1
>>            +-16.0  Intel Corporation Sunrise Point-H CSME HECI #1
>>            +-1c.0-[02]----00.0  Broadcom Corporation BCM43602 802.11=
ac
> Wireless LAN SoC
>>            +-1c.1-[03]----00.0  Realtek Semiconductor Co., Ltd. Devi=
ce
> 525a
>>            +-1d.0-[04]----00.0  Samsung Electronics Co Ltd Device a8=
02
>>            +-1d.4-[05]--
>>            +-1d.6-[06-3e]----00.0-[07-0a]--+-00.0-[08]--
>>            |                               +-01.0-[09]--
>>            |                               \-02.0-[0a]----00.0  Inte=
l
> Corporation Device 15b5
>>            +-1f.0  Intel Corporation Sunrise Point-H LPC Controller
>>            +-1f.2  Intel Corporation Sunrise Point-H PMC
>>            +-1f.3  Intel Corporation Sunrise Point-H HD Audio
>>            \-1f.4  Intel Corporation Sunrise Point-H SMBus
>
> lsusb -tv:
>> /:  Bus 04.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 50=
00M
>>     |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
>>         |__ Port 1: Dev 3, If 0, Class=3DVendor Specific Class,
> Driver=3Dr8152, 5000M
>> /:  Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 48=
0M
>>     |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
>>         |__ Port 3: Dev 3, If 0, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>>         |__ Port 3: Dev 3, If 1, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>>         |__ Port 3: Dev 3, If 2, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>>         |__ Port 3: Dev 3, If 3, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/8p, 50=
00M
>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/16p, 4=
80M
>>     |__ Port 4: Dev 2, If 0, Class=3DVendor Specific Class,
> Driver=3Dbtusb, 12M
>>     |__ Port 4: Dev 2, If 1, Class=3DVendor Specific Class,
> Driver=3Dbtusb, 12M
>>     |__ Port 4: Dev 2, If 2, Class=3DVendor Specific Class,
> Driver=3Dbtusb, 12M
>>     |__ Port 4: Dev 2, If 3, Class=3DApplication Specific Interface,
> Driver=3D, 12M
>>     |__ Port 12: Dev 3, If 0, Class=3DVideo, Driver=3Duvcvideo, 480M
>>     |__ Port 12: Dev 3, If 1, Class=3DVideo, Driver=3Duvcvideo, 480M
>
>
> However, if the device is connected after the system boots (or
> disconnected and reconnected), it is not detected at all. No messages
> show up in dmesg upon connection and no additional devices show up in
> the output of lspci & lsusb. Strangely enough, USB devices connected =
to
> the external hub do still receive power.
>
> I also have the following options relating to PCI hotplug set in my
> kernel config:
>
>> CONFIG_HOTPLUG_PCI_PCIE=3Dy
>> CONFIG_HOTPLUG_PCI=3Dy
>> CONFIG_HOTPLUG_PCI_ACPI=3Dy
>> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dy
>
> I'm running the 4.4.2 kernel, booted via EFI. From what I've read,
> Thunderbolt hotplug has been working since 3.17, controlled by the
> CONFIG_THUNDERBOLT option. However regardless of whether this option =
is
> enabled or disabled, hotplug does not appeare to work on my hardware.
> From reading the in-kernel help text for this option, I suspect that
> it's only relevant for the older Cactus Ridge Thunderbolt controller
> present in 2012-era MacBooks.

That is correct. On your device TB should be handled by the firmware.

Bj=C3=B6rn suggested that we might not be reacting to acpi notification=
s
(or pci hotplug interrupts) properly. To confirm this you could try to
issue a manual pci rescan via

echo "1" > /sys/bus/pci/rescan

This should make the device appear (if the issue lies with our
handling of hotplug events).

Otherwise you might want to take a look at the ACPI tables and search
for code which turn off thunderbolt or something like that. Does
hotplug work under Windows (without additional drivers)?

Regards,
Andreas



> How can I go about finding additional information about just what's
> going on, hopefully to assist with improving support for this newer
> hardware?
>
>
> Kind regards,
> Jack
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQIcBAEBCAAGBQJW0AhWAAoJEP0XuxcIDSnP9lwP/i/wNuNTQOKM40FZdcslJ4u1
> uztebCxlMTt9MIQteZDSK5Srfof/EN9sT9TKQB8eBa7szzBC6ve37W+n5sKh189+
> fMMOHBxVg10okCZk6WhyIrY1Q0kdIsOqCY80SoVRHZ0/1anP0+wBr1GAELhYVkrz
> ZoFTjvVG/fvuqXxs4es0S9wD7q9xgnMpSEHWjsc2h+XR1JvRyaifh6YrYQ0Y/sb7
> XJ5TuaNb+LKT5RACuMLSPb+LeYoRd+KOD9O/5hZOunJdglFjr1SsPTMLE7OgSPgC
> JhQGc6jaRbI9xYfe95V+YiVG/R1rVmWyPO5K22XWvB96F2ecS+L9lTtSdvEMG3z8
> AxxBoG+nu5b396Fk6+7Mt5tqyI6/pqxHf+sr2+znK7tzBxugz89IaGjN7AzQFFqc
> Y0529G+YcBegXhYkUJ4KWvjAnmXK0ovhMZg4+SMAxPK9KHlHfJtpHWdteyQwGYmJ
> LiwvbxskDXESUs+5W2CMPaJymcxp4MiRCrZvTKGojtCQh8TgPBYmFMwocDQ14kgI
> s8fW0GLchh9pcCpPZDifpnHOZUAS2V7ebP3eJnmC7N6XpCpvqOmR1+BXr9KMK4fb
> D2sQW1H2s5biBnsWZKsKj0ZIn5vMojMH1zbrUG7lqtdO4xNt6AN1H/Wp1Rqsgu5u
> D0x1areDAEKuToqgb0wJ
> =3DAU/v
> -----END PGP SIGNATURE-----
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
