From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Thu, 9 Feb 2006 08:56:12 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E044B8C69@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:40425 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932303AbWBIQ42 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 11:56:28 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-ia64@vger.kernel.org

I'm wondering if the resource structures are being inadvertently packed.

You might try removing this code from actypes.h:

/*
 * If possible, pack the following structures to byte alignment
 */
#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
#pragma pack(1)
#endif

Please send the dsdt or acpidump for this machine
Thanks,
Bob



> -----Original Message-----
> From: Moore, Robert
> Sent: Thursday, February 02, 2006 2:29 PM
> To: Luck, Tony; linux-acpi@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
> 
> The ACPICA resource manager was mostly rewritten around the 20051021
time
> frame, and we may have disturbed some of the aligned access support.
I'll
> look at these, it looks like enough info to fix them.
> 
> Thanks,
> Bob
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Luck, Tony
> > Sent: Thursday, February 02, 2006 11:46 AM
> > To: linux-acpi@vger.kernel.org
> > Cc: linux-ia64@vger.kernel.org
> > Subject: some new unaligned access while booting ia64 (HP rx2620)
> >
> > Booting a snapshot of Linus' tree this morning I saw a few (new?)
> > kernel unaligned access warnings:
> >
> > ACPI: Subsystem revision 20060127
> > ACPI: Interpreter enabled
> > ACPI: Using IOSAPIC for interrupt routing
> > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003af8c0
> > kernel unaligned access to 0xe00000407ec5a23c, ip=0xa0000001003af8c0
> > kernel unaligned access to 0xe00000407ec5a28c, ip=0xa0000001003af8c0
> > kernel unaligned access to 0xe00000407ec5a1fc, ip=0xa0000001003ae6c1
> > kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003ae6d1
> > ACPI: PCI Interrupt Routing Table [\_SB_.SBA0.PCI0._PRT]
> > ACPI: PCI Root Bridge [PCI1] (0000:20)
> >
> > The first three at ip=0xa0000001003af8c0 are in
> > acpi_rs_get_resource_source()
> > while zeroing a 64-bit value:
> > a0000001003af8c0:       dc 00 00 46 98 11       [MFB] (p06) st8
[r35]=r0
> >
> > Which looks from the assembly code like we are doing a:
> >    resource_source->string_ptr = 0;
> > but I don't see anything quite like that in the C source (but
> > there may be macros & inlining happening).
> >
> > The other two, ip=0xa0000001003ae6c1 and ip=0xa0000001003ae6d1 are
in
> > acpi_resource_to_address64() close together in this little
> > block:
> >
> > a0000001003ae6c6:       50 02 58 30 20 00                   ld8
> r37=[r22]
> > a0000001003ae6cc:       00 00 00 20                         nop.b
0x0;;
> > a0000001003ae6d0:       19 00 94 1e 98 11       [MMB]       st8
> [r15]=r37
> > a0000001003ae6d6:       70 02 40 30 20 00                   ld8
> r39=[r16]
> >
> > These loads are dereferencing the acpi_resource structure that was
> passed
> > as the first argument (offsets 40 and 48 bytes).
> >
> > -Tony
> > -
> > To unsubscribe from this list: send the line "unsubscribe
linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
