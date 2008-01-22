From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode Compaq Presario C500 (C552US)
Date: Mon, 21 Jan 2008 23:07:10 -0500
Message-ID: <200801212307.10365.lenb@kernel.org>
References: <1198084299.10729.17.camel@headhunter.avsa.net> <200801201917.59754.lenb@kernel.org> <1200943223.6796.25.camel@headhunter>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55333 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYAVEHg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 23:07:36 -0500
In-Reply-To: <1200943223.6796.25.camel@headhunter>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Burt <genecide@comcast.net>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 14:20, Jesse Burt wrote:
> 
> On Sun, 2008-01-20 at 19:17 -0500, Len Brown wrote:
> > Thanks for the acpidump output.
> > 
> > OSI(Linux) is indeed a NOP on this box, it sets LINX, but never checks it
> 
> Hmm... so was this just some sort of afterthought by the mfr? What is
> the idea, it's supposed to check if the OS is Linux and if so, set
> certain parameters? I don't know too much about ACPI.

I expect it is just dead code from the example code
that they didn't bother to clean up.

> > 
> >     OperationRegion (GNVS, SystemMemory, 0x1F694E4C, 0x0100)
> >     Field (GNVS, AnyAcc, Lock, Preserve)
> >     {
> >         OSYS,   16,
> >         SMIF,   8,
> >         PRM0,   8,
> >         PRM1,   8,
> >         SCIF,   8,
> >         PRM2,   8,
> >         PRM3,   8,
> >         LCKF,   8,
> >         PRM4,   8,
> >         PRM5,   8,
> >         P80D,   32,
> >         LIDS,   8,
> >         PWRS,   8,
> >         DBGS,   8,
> >         LINX,   8,
> >                 Offset (0x14),
> > ...
> >            If (CondRefOf (_OSI, Local0))
> >             {
> >                 If (_OSI ("Linux"))
> >                 {
> >                     Store (One, LINX)
> >                 }
> > 
> >                 If (_OSI ("Windows 2001"))
> >                 {
> >                     Store (0x07D1, OSYS)
> >                 }
> > ...
> > 
> > Re: the duplicate APIC tables...
> > 
> > Linux uses the 1st one by default, and that seems to be the OEM modified
> > version (vs. the 2nd one which seems bo be left over from the reference code).
> > 
> > $ madt < APIC1.dat
> > ACPI: APIC (v001 HP     NISSAN   0x06040000 LOHR 0x0000005a) @ 0x(nil)
> > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
> > ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > Length 104 OK
> > Checksum OK
> > $ madt < APIC2.dat
> > ACPI: APIC (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0x(nil)
> > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> > ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
> > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > Length 90 OK
> > Checksum OK
> > 
> > The Compaq added APIC table gives a 2nd processor, but it is disabled:
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
> > 
> > I don't really follow this, since the specs on this box
> > say it has a dual core processor.  Perhaps the 2nd core is disabled?
> > 
> 
> Interesting...perhaps they use a somewhat generic set of tables for many
> of their devices and just don't bother to prune them on boxes like this
> one? As far as I know, however, the box does have one single core
> processor (Celeron M 520 I believe is what is reported by /proc/cpuinfo;
> Intel's site
> http://www.intel.com/products/processor_number/chart/celeron_m.htm
> doesn't seem to explicitly mention anything about this CPU being
> dual-core

Apparently they use the same BIOS and have the option to stuff
different CPUs.  I expect the BIOS discovers at init time
the actualy CPU capabilities and modifies the APIC table
that has entries to accomodate the largest they support.

> though unbeknownst to me before looking at it just now... 
> this processor is 64bit! Not sure if the BIOS and/or ACPI data reflect
> this.

The OS doesn't have to ask ACPI or the BIOS about 64-bit,
it gets that from the processor directly via CPUID.

> I know from experience with my laptop that Compaq/HP are kind of silly
> with their series/model numbers... i.e., a certain model may not have
> the same components from one unit to another. For instance mine could
> have come with one of two or three different processors (Sempron,
> Athlon64 Mobile I think?, or a Turion64, which it has).
> 
> > The INT_SRC_OVR thing should be a NOP, because high/edge
> > is the default for legacy timer interrupts.
> > 
> Thanks for looking at this Len. Being somewhat uninformed about ACPI,
> how much does Linux rely on the information it finds in these tables?
> What effects do you think any of these "defects" could cause?
> Again, thanks for looking at this.

Linux relies heavily on the information in these tables.
However, over time, we have become more and more immune to BIOS
programming defects.  I don't notice any here which would hurt you.

cheers,
-Len
