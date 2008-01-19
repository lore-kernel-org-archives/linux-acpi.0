From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - HP Pavilion dv9410us - 30B9
Date: Sat, 19 Jan 2008 02:22:21 -0500
Message-ID: <200801190222.22125.lenb@kernel.org>
References: <553eb53a0710142117u1e82c642pae8d82d7ae2e31b7@mail.gmail.com> <200801182343.49613.lenb@kernel.org> <553eb53a0801182146j1e2d199ej928264f14104eaec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59768 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbYASHWf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 02:22:35 -0500
In-Reply-To: <553eb53a0801182146j1e2d199ej928264f14104eaec@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fred Bauer <fred.w.bauer@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 00:46, Fred Bauer wrote:
> I have not had consistent booting with any kernel boot parameters.
> Sometimes it freezes even with noapic. acpi=off always works, tho.
> Booting with acpi_osi="Linux" vs. acpi_osi="!Linux" is not consistent.
> Irq 7 seems to be an issue. I get spurious interrupts w/o noapic.
> I have zillions of irqs on 7 with nothing plugged into usb even with
> noapic. (I wish I could be more help. I'm starting to think this laptop
> is just junk.)

Indeed.  If it had and Intel processor or chipset
I might be better equiped to help debug it...;-)

> 
> fred@dv9410us:~/Desktop/pmtools-20071116/acpidump$ cat /proc/interrupts
>            CPU0       CPU1
>   0:     440894      55905    XT-PIC-XT        timer
>   1:       1448        245    XT-PIC-XT        i8042
>   2:          0          0    XT-PIC-XT        cascade
>   5:      39072       7554    XT-PIC-XT        sata_nv
>   7:     187754    1077498    XT-PIC-XT        ehci_hcd:usb1
>   8:          0          1    XT-PIC-XT        rtc
>   9:     157857      45581    XT-PIC-XT        acpi, ndiswrapper

of course you're on your own when using ndiswrapper...

>  10:     164961      30370    XT-PIC-XT        HDA Intel, eth0
>  11:     102179      16337    XT-PIC-XT        ohci1394, ohci_hcd:usb2, nvidia
>  12:     158406      27747    XT-PIC-XT        i8042
>  14:      12995       4254    XT-PIC-XT        ide0
> NMI:          0          0   Non-maskable interrupts
> LOC:      55926     440826   Local timer interrupts
> RES:     131130     172445   Rescheduling interrupts
> CAL:         91        181   function call interrupts
> TLB:        554        654   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> THR:          0          0   Threshold APIC interrupts
> SPU:          0          0   Spurious interrupts
> ERR:    1165746

ERR interrupts are not a good sign.

Really a box with multiple CPUs should not be run in noapic mode...

> On Jan 18, 2008 11:43 PM, Len Brown <lenb@kernel.org> wrote:
> > On Monday 15 October 2007 00:17, Fred Bauer wrote:
> > > System Information
> > > Manufacturer: Hewlett-Packard
> > > Product Name: HP Pavilion dv9000 (GA355UA#ABA)
> > > Version: Rev 1
> > > Serial Number: CNF7282S2L
> > > UUID: 434E4637-3238-3253-324C-001B2469B587
> > > Wake-up Type: Power Switch
> > > SKU Number: GA355UA#ABA
> > > Family: 103C_5335KV
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: Quanta
> > > Product Name: 30B9
> >

Thanks for the acpidump output.

The code below makes OSI(Linux) clearly a NOP on this box,
since the value it writes would get over-written by any
of the Windows OSI strings -- and Linux sets all the Windows OSI strings....

I'll add this box to the NOP DMI list.

thanks,
-Len

        Device (PCI0)
        {
            Name (_ADR, 0x00)
            Name (_HID, EisaId ("PNP0A03"))
            Name (_UID, 0x01)
            Method (_INI, 0, NotSerialized)
            {
                Store (0x07D0, OSYS)
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }

                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x07D1, OSYS)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x07D1, OSYS)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x07D2, OSYS)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x07D6, OSYS)
                    }
                }
            }
