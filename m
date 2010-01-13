From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: 2.6.33-rc3: pci host bridge windows ignored (works with
	pci=use_crs)
Date: Wed, 13 Jan 2010 00:45:17 -0800
Message-ID: <86802c441001130045i17f75692tb0ad5aadaabdfd2a@mail.gmail.com>
References: <20100113053736.GA6720@jgarrett.org>
	 <86802c441001130044w4026abadi3f513559f6e71cef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <86802c441001130044w4026abadi3f513559f6e71cef@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, David Airlie <airlied@linux.ie>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 13, 2010 at 12:44 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> On Tue, Jan 12, 2010 at 9:37 PM, Jeff Garrett <jeff@jgarrett.org> wro=
te:
>> Took a stab at getting the right emails. =A0If I missed anyone, sorr=
y...
>>
>> I have a desktop machine with a radeon HD 4850, and on recent kernel=
s
>> the radeon driver has failed with the message "No valid linear
>> framebuffer address". =A0lspci on the broken configuration showed th=
e
>> first memory region at d0000000 of the radeon card to be ignored. =A0=
dmesg
>> showed there to be a host bridge window at that address which was al=
so
>> ignored.
>>
>> I haven't quantified "recent" kernel. =A0I was using the Ubuntu/luci=
d
>> kernels and it broke in the 2.6.32-* timeline, at which point I swit=
ched
>> to vanilla 2.6.33-rc3 to see if that worked. =A0I could probably bis=
ect it
>> in a day or two when I get a little time.
>>
>> Following dmesg's instructions, setting pci=3Duse_crs causes the reg=
ion
>> not to be ignored, and my video works again.
>>
>> I'm attaching a dmesg from the broken & working configurations, lspc=
i
>> -vvv output from the working configuration, and the output of acpidu=
mp.
>>
>> (Between the failed/working, I also applied the patch at
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D14954
>> to get rid of the ACPI-parsing oops. =A0But that only fixed the oops=
=2E)
>
> [ =A0 =A00.000000] BIOS-provided physical RAM map:
> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000000000 - 000000000009fc00 =
(usable)
> [ =A0 =A00.000000] =A0BIOS-e820: 000000000009fc00 - 00000000000a0000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000000e0000 - 0000000000100000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000100000 - 00000000bf790000 =
(usable)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bf790000 - 00000000bf79e000 =
(ACPI data)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bf79e000 - 00000000bf7d0000 =
(ACPI NVS)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bf7d0000 - 00000000bf7e0000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bf7ec000 - 00000000c0000000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000fee00000 - 00000000fee01000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000ffb00000 - 0000000100000000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 0000000100000000 - 0000000340000000 =
(usable)
> ...
>
> [ =A0 =A00.833443] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> 0xe0000000-0xefffffff] (base 0xe0000000)
> [ =A0 =A00.835028] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reser=
ved
> in ACPI motherboard resources
> ...
>
> [ =A0 =A00.847449] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [ =A0 =A00.847470] pci_root PNP0A08:00: ignoring host bridge windows =
from
> ACPI; boot with "pci=3Duse_crs" to use them
> [ =A0 =A00.847693] pci_root PNP0A08:00: host bridge window [io
> 0x0000-0x0cf7] (ignored)
> [ =A0 =A00.847695] pci_root PNP0A08:00: host bridge window [io
> 0x0d00-0xffff] (ignored)
> [ =A0 =A00.847697] pci_root PNP0A08:00: host bridge window [mem
> 0x000a0000-0x000bffff] (ignored)
> [ =A0 =A00.847699] pci_root PNP0A08:00: host bridge window [mem
> 0x000d0000-0x000dffff] (ignored)
> [ =A0 =A00.847701] pci_root PNP0A08:00: host bridge window [mem
> 0xc0000000-0xdfffffff] (ignored)
> [ =A0 =A00.847703] pci_root PNP0A08:00: host bridge window [mem
> 0xf0000000-0xfed8ffff] (ignored)
> ...
> [ =A0 =A00.848025] IOH bus: [00, fb]
> [ =A0 =A00.848026] IOH bus: 00 index 0 io port: [0, ffff]
> [ =A0 =A00.848028] IOH bus: 00 index 1 mmio: [e0000000, fdffffff]
> ...
> [ =A0 =A00.849289] PCI: peer root bus 00 res updated from pci conf
> ...
> [ =A0 =A00.849361] pci 0000:04:00.0: reg 10: [mem 0xd0000000-0xdfffff=
ff 64bit pref]
> [ =A0 =A00.849369] pci 0000:04:00.0: reg 18: [mem 0xfbee0000-0xfbeeff=
ff 64bit]
> [ =A0 =A00.849374] pci 0000:04:00.0: reg 20: [io =A00xe000-0xe0ff]
> [ =A0 =A00.849381] pci 0000:04:00.0: reg 30: [mem 0xfbec0000-0xfbedff=
ff pref]
> [ =A0 =A00.849423] pci 0000:04:00.1: reg 10: [mem 0xfbefc000-0xfbefff=
ff 64bit]
> [ =A0 =A00.849481] pci 0000:00:07.0: PCI bridge to [bus 04-04]
> [ =A0 =A00.849484] pci 0000:00:07.0: =A0 bridge window [io =A00xe000-=
0xefff]
> [ =A0 =A00.849487] pci 0000:00:07.0: =A0 bridge window [mem 0xfbe0000=
0-0xfbefffff]
> [ =A0 =A00.849491] pci 0000:00:07.0: =A0 bridge window [mem
> 0xd0000000-0xdfffffff 64bit pref]
>
>
> it seems HW IOH only can use [e000000 - fdffffff] under that bridge..=
=2E
>
> and _CRS said the peer root bus could use [c000000 - dfffffff]
>
> could be that we need to check other register to decide if we can use
> reading from ioh reg directly.

can you send out

lspci -tvnn
lspci -vvxxxx

YH
