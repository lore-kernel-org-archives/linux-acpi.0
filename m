From: "Luck, Tony" <tony.luck@intel.com>
Subject: some new unaligned access while booting ia64 (HP rx2620)
Date: Thu, 2 Feb 2006 11:46:04 -0800
Message-ID: <200602021946.k12Jk446028921@agluck-lia64.sc.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:54694 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751178AbWBBTqF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Feb 2006 14:46:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-ia64@vger.kernel.org

Booting a snapshot of Linus' tree this morning I saw a few (new?)
kernel unaligned access warnings:

ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003af8c0
kernel unaligned access to 0xe00000407ec5a23c, ip=0xa0000001003af8c0
kernel unaligned access to 0xe00000407ec5a28c, ip=0xa0000001003af8c0
kernel unaligned access to 0xe00000407ec5a1fc, ip=0xa0000001003ae6c1
kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003ae6d1
ACPI: PCI Interrupt Routing Table [\_SB_.SBA0.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:20)

The first three at ip=0xa0000001003af8c0 are in acpi_rs_get_resource_source()
while zeroing a 64-bit value:
a0000001003af8c0:       dc 00 00 46 98 11       [MFB] (p06) st8 [r35]=r0

Which looks from the assembly code like we are doing a:
   resource_source->string_ptr = 0;
but I don't see anything quite like that in the C source (but
there may be macros & inlining happening).

The other two, ip=0xa0000001003ae6c1 and ip=0xa0000001003ae6d1 are in
acpi_resource_to_address64() close together in this little
block:

a0000001003ae6c6:       50 02 58 30 20 00                   ld8 r37=[r22]
a0000001003ae6cc:       00 00 00 20                         nop.b 0x0;;
a0000001003ae6d0:       19 00 94 1e 98 11       [MMB]       st8 [r15]=r37
a0000001003ae6d6:       70 02 40 30 20 00                   ld8 r39=[r16]

These loads are dereferencing the acpi_resource structure that was passed
as the first argument (offsets 40 and 48 bytes).

-Tony
