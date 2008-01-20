From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from Dell Vostro 1000
Date: Sun, 20 Jan 2008 13:52:43 -0500
Message-ID: <200801201352.43845.lenb@kernel.org>
References: <3a082f0c0711201915p3f10ec66mc6d8f024da8f363d@mail.gmail.com> <200801190138.53347.lenb@kernel.org> <3a082f0c0801190745k34ad76ddi83417ad56b08f0ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58525 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbYATSw6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 13:52:58 -0500
In-Reply-To: <3a082f0c0801190745k34ad76ddi83417ad56b08f0ee@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaakan Shorter <jaakanshorter@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 10:45, Jaakan Shorter wrote:
> I added acpi_osi=Linux to 2.6.24 and didn't see a change should I also
> try acpi_osi=!Linux on 2.6.24

no need, acpi_osi=!Linux is the default for 2.6.23 and later.

> jaakan@jms1000:~$ cat /var/log/dmesg | grep 0x37E80F06
> jaakan@jms1000:~$ cat /var/log/dmesg | grep BIOS
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
> [    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 0000000037e70000 (usable)
> [    0.000000]  BIOS-e820: 0000000037e70000 - 0000000037e80000 (ACPI data)

         OperationRegion (OSTY, SystemMemory, 0x37E80F06, 0x00000001)
         Field (OSTY, AnyAcc, NoLock, Preserve)
         {
             TPOS,   8
         }

Curious, Op-region OSTY sits in the (reclaimable) ACPI tables region
in the e820 map.  I guess it is a good thing that Linux never calls
the BIOS's bluff and reclaims that region after the tables are read
(we leave the tables in place and use them there) -- because otherwise
the OS could scribble on a region that is used by AML at run time.

thanks for testing.  I think we're done here.

-Len

> [    0.000000]  BIOS-e820: 0000000037e80000 - 0000000037f00000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 0000000037f00000 - 0000000040000000 (reserved)
> [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> [   15.634917] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> [   15.826827] ACPI: System BIOS is requesting _OSI(Linux)
> [   18.539020]     ide0: BM-DMA at 0x8420-0x8427, BIOS settings:
> hda:DMA, hdb:pio
> jaakan@jms1000:~$
> 
> 
> On Jan 19, 2008 1:38 AM, Len Brown <lenb@kernel.org> wrote:
> > On Friday 18 January 2008 19:08, Jaakan Shorter wrote:
> > > I didn't see any kind of changes with acpi_osi=!Linux on 2.6.22
> > >
> > >
> > > here is the current output from uname -a, I'm  now using the current Ubuntu beta
> > > Linux jms1000 2.6.24-4-generic #1 SMP Mon Jan 14 18:19:11 UTC 2008
> > > x86_64 GNU/Linux
> > >
> > > I'll try adding acpi_osi=Linux in a few and look for any changes.
> >
> > Like others, Dell Vostro 1000 sets LINX, but never checks it.
> >
> > TPOS and OSTB are also affected, but in the ASL they're referened
> > only with comparisons > 4, (NT or greater) so OSI(Linux) shouldn't
> > have any effect there either.
> >
> > That leaves the return value of OSTP(), which I see invoked
> > in several places, but the return value is never used.
> >
> > So I'll add this box to the OSI(Linux) NOP list.
> >
> > BTW.
> >
> > Where does 0x37E80F06 show up in the e820 map in dmesg?
> > I'm wondering why they put OSTY (TPOS) in a special place.
> >
> > thanks,
> > -Len
> >
> >
> >     Scope (\_SB)
> >     {
> >         Name (LINX, 0x00)
> >         Name (OSTB, Ones)
> >         OperationRegion (OSTY, SystemMemory, 0x37E80F06, 0x00000001)
> >         Field (OSTY, AnyAcc, NoLock, Preserve)
> >         {
> >             TPOS,   8
> >         }
> >
> >         Method (OSTP, 0, NotSerialized)
> >         {
> >             If (LEqual (^OSTB, Ones))
> >             {
> >                 If (CondRefOf (\_OSI, Local0))
> >                 {
> >                     Store (0x00, ^OSTB)
> >                     Store (0x00, ^TPOS)
> >                     If (\_OSI ("Windows 2001"))
> >                     {
> >                         Store (0x08, ^OSTB)
> >                         Store (0x08, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Windows 2001.1"))
> >                     {
> >                         Store (0x20, ^OSTB)
> >                         Store (0x20, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Windows 2001 SP1"))
> >                     {
> >                         Store (0x10, ^OSTB)
> >                         Store (0x10, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Windows 2001 SP2"))
> >                     {
> >                         Store (0x11, ^OSTB)
> >                         Store (0x11, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Windows 2001 SP3"))
> >                     {
> >                         Store (0x12, ^OSTB)
> >                         Store (0x12, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Windows 2006"))
> >                     {
> >                         Store (0x40, ^OSTB)
> >                         Store (0x40, ^TPOS)
> >                     }
> >
> >                     If (\_OSI ("Linux"))
> >                     {
> >                         Store (0x01, LINX)
> >                         Store (0x80, ^OSTB)
> >                         Store (0x80, ^TPOS)
> >                     }
> >                 }
> >                 Else
> >                 {
> >                     If (CondRefOf (\_OS, Local0))
> >                     {
> >                         If (^SEQL (\_OS, "Microsoft Windows"))
> >                         {
> >                             Store (0x01, ^OSTB)
> >                             Store (0x01, ^TPOS)
> >                         }
> >                         Else
> >                         {
> >                             If (^SEQL (\_OS, "Microsoft WindowsME: Millennium Edition"))
> >                             {
> >                                 Store (0x02, ^OSTB)
> >                                 Store (0x02, ^TPOS)
> >                             }
> >                             Else
> >                             {
> >                                 If (^SEQL (\_OS, "Microsoft Windows NT"))
> >                                 {
> >                                     Store (0x04, ^OSTB)
> >                                     Store (0x04, ^TPOS)
> >                                 }
> >                                 Else
> >                                 {
> >                                     Store (0x00, ^OSTB)
> >                                     Store (0x00, ^TPOS)
> >                                 }
> >                             }
> >                         }
> >                     }
> >                     Else
> >                     {
> >                         Store (0x00, ^OSTB)
> >                         Store (0x00, ^TPOS)
> >                     }
> >             Return (^OSTB)
> >         }
> >
> > ...
> >         Device (PCI0)
> >         {
> >             Name (_ADR, 0x00)
> >             Name (_UID, 0x01)
> >             Name (_BBN, 0x00)
> >             Method (_INI, 0, NotSerialized)
> >             {
> >                 \_SB.OSTP ()
> >             }
> >
> > ...
> >         Method (OSHT, 0, NotSerialized)
> >         {
> >             \_SB.OSTP ()
> >             Store (0x48, \_SB.PCI0.LPC0.BCMD)
> >             Store (Zero, \_SB.PCI0.LPC0.SMIC)
> >         }
> > ...
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
