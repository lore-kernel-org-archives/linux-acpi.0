From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test4 - lost ACPI
Date: Sat, 23 Aug 2003 16:58:00 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC9@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Tomasz Torcz <zdzichu-YxaM2a6SwlU@public.gmane.org>
Cc: LKML <linux-kernel-IFdL7R2G4aWny3qCrzbmXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

manually modifying ACPI_BLACKLIST_CUTOFF_YEAR and using acpi=force on
the cmdline should have the same effect.

pci=noacpi is also an option.  If it works, then it means you got burnt
by ACPI's PCI interrupt code.  We've had trouble with Award/VIA in this
area recently, so it wouldn't be surprising to have trouble with a
3-year old Award/VIA BIOS.  The puzzling thing is why ACPI enabled
worked for you before and doesn't work now.

I'd be interested in looking over a copy of your /proc/acpi/dsdt, or
even better, the output from acpidmp, which you can get from the pmtools
package here:
http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-200107
30.tar.gz


Thanks,
-Len

> -----Original Message-----
> From: Tomasz Torcz [mailto:zdzichu-YxaM2a6SwlU@public.gmane.org] 
> Sent: Saturday, August 23, 2003 12:59 PM
> To: Brown, Len
> Cc: LKML
> Subject: Re: 2.6.0-test4 - lost ACPI
> 
> 
> On Sat, Aug 23, 2003 at 12:47:04PM -0400, Brown, Len wrote:
>  
> > I didn't see which VIA 693 MB you've got, but it could be that a
> > BIOS upgrade would move it from 09/13/00 to something past 
> 1/1/2001 --
> > the (yes, arbitrary) cutoff for enabling ACPI by default.
> 
> It's Matsonic 7132A (http://www.matsonic.com/ms7132a.htm ; 
> http://206.135.80.155/manual/ms7132a.pdf).
> Pretty nice board. Latest bios for it is dated 09/13/00 and
> there is no upgrade.
>  
> > Or you could add "acpi=force" to your command line, as 
> suggested in the
> > dmesg output.
> 
> Tried this with strange results - kernel halted during boot,
> after displaying:
> 
> [... dmesg ...]
> PM: Adding info for ide:1.0
> hda: max request size: 1024KiB
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, 
> CHS=16383/255/63, UDMA(66)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> 
> HALT. No sysrq, no shift+pgup, no response for power button.
> 
> Dmesg _without_ acpi=force: 
> 
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed 
> Aug 20 20:27:13 2003 UTC).
> PCI: Found IRQ 10 for device 0000:00:0b.0
> 
> And so on.
> 
> > Or you could change the source to alter or disable #define
> > ACPI_BLACKLIST_CUTOFF_YEAR 2001
> 
> I will try this next. ACPI was working flawlessly for me almost from
> the beginning.
> 
> -- 
> Tomasz Torcz                                                  
>      72->|   80->|
> zdzichu-X3HQ1c18OqI0iLA60pu2Z2ZHpeb/A1Y/@public.gmane.org                                     
>      72->|   80->|
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
