From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode-HP-Pavilion-dv9560eg
Date: Sun, 20 Jan 2008 14:22:40 -0500
Message-ID: <200801201422.40485.lenb@kernel.org>
References: <1191819601.6239.0.camel@Pavilion.famklein.net> <200801182323.27714.lenb@kernel.org> <1200734029.3907.6.camel@Pavilion.famklein.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45969 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbYATTWz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:22:55 -0500
In-Reply-To: <1200734029.3907.6.camel@Pavilion.famklein.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans-Joachim Klein <klein.hans@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 04:13, Hans-Joachim Klein wrote:
> 
> Am Freitag, den 18.01.2008, 23:23 -0500 schrieb Len Brown:
> > On Monday 08 October 2007 01:00, Hans-Joachim Klein wrote:
> > > System Information
> > >         Manufacturer: Hewlett-Packard
> > >         Product Name: HP Pavilion dv9500 Notebook PC    
> > >         Version: Rev 1
> > >         Serial Number: CNF7301PB5
> > >         UUID: 434E4637-3330-3150-4235-001B246D0EFF
> > >         Wake-up Type: Power Switch
> > >         SKU Number: GP650EA#ABD 
> > >         Family: 103C_5335KV
> > > 
> > > Handle 0x0002, DMI type 2, 8 bytes.
> > > Base Board Information
> > >         Manufacturer: Quanta
> > >         Product Name: 30CB
> > 
> > Thanks for the dmidecode output.
> > 
> > Do you notice any functional difference when booting with
> > 
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> > 
> No, I didn't notice any changes in system behaviour, just the output of
> dmesg told that the bios requests "acpi_osi=Linux".
> 
> Fedora-kernel: Linux Pavilion.famklein.net 2.6.23.9-85.fc8 #1 SMP Fri
> Dec 7 15:49:36 EST 2007 x86_64 x86_64 x86_64 GNU/Linux
> 
> kernel command line:
> kernel /boot/vmlinuz-2.6.23.9-85.fc8 ro acpi_osi=Linux pci=routeirq
> root=/dev/sdb8 rhgb  quiet
> 

thanks for the acpidump.
The ASL sets LINX, but never references it,
so OSI(Linux) is a NOP on this machine.

-Len


    OperationRegion (GNVS, SystemMemory, 0x7FEDEDBC, 0x0100)
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
            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }
