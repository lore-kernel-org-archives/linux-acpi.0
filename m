From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test4 - lost ACPI
Date: Sat, 23 Aug 2003 12:47:04 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC7@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Tomasz Torcz <zdzichu-YxaM2a6SwlU@public.gmane.org>, LKML <linux-kernel-IFdL7R2G4aWny3qCrzbmXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If you're using run-time ACPI features, you'll probably want to
make sure that your MB BIOS is the latest available.

I didn't see which VIA 693 MB you've got, but it could be that a
BIOS upgrade would move it from 09/13/00 to something past 1/1/2001 --
the (yes, arbitrary) cutoff for enabling ACPI by default.

Or you could add "acpi=force" to your command line, as suggested in the
dmesg output.

Or you could change the source to alter or disable #define
ACPI_BLACKLIST_CUTOFF_YEAR 2001

If your system misbehaves when ACPI is enabled by one of these methods,
please let me know.

Thanks,
-Len


> -----Original Message-----
> From: Tomasz Torcz [mailto:zdzichu-YxaM2a6SwlU@public.gmane.org] 
> Sent: Saturday, August 23, 2003 6:53 AM
> To: LKML
> Subject: 2.6.0-test4 - lost ACPI
> 
> 
> 
> Hi,
> 
> I am using ACPI for few years now. As far as I can see, on my
> machine it is only usfeul for binding events to Power button (like
> running fbdump) and for powering off. I'm also experimenting
> with swsusp, which I run by /proc/acpi/sleep.
> 
> 2.6.0-test4 has a surprise for me:
> 
> Linux version 2.6.0-test4 (zdzichu@mother) (gcc version 
> 3.3.1) #15 Sat Aug 23 12:03:
> 02 CEST 2003
> Video mode to be used for restore is ffff
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
>  BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
>  BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 319MB LOWMEM available.
> On node 0 totalpages: 81904
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 77808 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.1 present.
> ACPI disabled because your bios is from 00 and too old
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> You can enable it with acpi=force
> ACPI: RSDP (v000 VIA693                                    ) 
> @ 0x000f70c0
> ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) 
> @ 0x13ff3000
> ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) 
> @ 0x13ff3040
> ACPI: DSDT (v001 VIA693 AWRDACPI 0x00001000 MSFT 0x0100000a) 
> @ 0x00000000
> 
> WTF? My BIOS was perfectly good all those years! And no, there is
> no upgrade for my motherboard available. Using acpi=force is ugly
> and un-understandable.
> 
> There are also some strange directories in /proc :
> dr-xr-xr-x    2 root     root            0 Aug 23 12:50 
> /proc/ac_adapter/
> dr-xr-xr-x    2 root     root            0 Aug 23 12:50 /proc/fan
> 
> they are empty, but they should be in /proc/acpi/
> 
> Attached files:
> Output from dmidecode, lspci -v, my dmesg and /proc/cpuinfo
> 
> [Please CC me on replies. Thank you].
> 
> -- 
> Tomasz Torcz                 "God, root, what's the difference?" 
> zdzichu-X3HQ1c18OqI0iLA60pu2Z2ZHpeb/A1Y/@public.gmane.org         "God is more forgiving."   
> 
