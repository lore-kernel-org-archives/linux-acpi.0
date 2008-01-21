From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode Compaq Presario C500 (C552US)
Date: Sun, 20 Jan 2008 19:17:59 -0500
Message-ID: <200801201917.59754.lenb@kernel.org>
References: <1198084299.10729.17.camel@headhunter.avsa.net> <200801181636.53897.lenb@kernel.org> <1200756123.16044.6.camel@headhunter>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35763 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388AbYAUASQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 19:18:16 -0500
In-Reply-To: <1200756123.16044.6.camel@headhunter>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Burt <genecide@comcast.net>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 10:22, Jesse Burt wrote:
> 
> On Fri, 2008-01-18 at 16:36 -0500, Len Brown wrote:
> > i can double check this in your acpidump output too.
> > The duplicate may be identical, or Linux may be immune
> > to the differences (depends what they are)

Thanks for the acpidump output.

OSI(Linux) is indeed a NOP on this box, it sets LINX, but never checks it

    OperationRegion (GNVS, SystemMemory, 0x1F694E4C, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
        LCKF,   8,
        PRM4,   8,
        PRM5,   8,
        P80D,   32,
        LIDS,   8,
        PWRS,   8,
        DBGS,   8,
        LINX,   8,
                Offset (0x14),
...
           If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
...

Re: the duplicate APIC tables...

Linux uses the 1st one by default, and that seems to be the OEM modified
version (vs. the 2nd one which seems bo be left over from the reference code).

$ madt < APIC1.dat
ACPI: APIC (v001 HP     NISSAN   0x06040000 LOHR 0x0000005a) @ 0x(nil)
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Length 104 OK
Checksum OK
$ madt < APIC2.dat
ACPI: APIC (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0x(nil)
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Length 90 OK
Checksum OK

The Compaq added APIC table gives a 2nd processor, but it is disabled:
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)

I don't really follow this, since the specs on this box
say it has a dual core processor.  Perhaps the 2nd core is disabled?

The INT_SRC_OVR thing should be a NOP, because high/edge
is the default for legacy timer interrupts.

thanks,
-Len


