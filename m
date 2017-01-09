From: Ladislav Michl <ladis@linux-mips.org>
Subject: ACPI Error: Method parse/execution failed on HP ZBook 17 G3
Date: Mon, 9 Jan 2017 11:55:43 +0100
Message-ID: <20170109105543.2lnj5ram6u5nbtyz@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41720 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbdAIKzs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 05:55:48 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991532AbdAIKzpv30Fw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 11:55:45 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi there,

I'm getting various ACPI Errors with 4.10-rc3 on HP ZBook 17 G3:

efi: EFI v2.40 by HP
efi:  ACPI=0x3defe000  ACPI 2.0=0x3defe014  SMBIOS=0x3d8db000  MPS=0x3d975000  ESRT=0x3d06b660 
SMBIOS 2.7 present.
DMI: HP HP ZBook 17 G3/80D6, BIOS N81 Ver. 01.11 09/07/2016
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
e820: last_pfn = 0x2be000 max_arch_pfn = 0x400000000
MTRR default type: write-back
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0080000000 mask 7F80000000 uncachable
  1 base 0040000000 mask 7FC0000000 uncachable
  2 disabled
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
  8 disabled
  9 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
e820: last_pfn = 0x3df00 max_arch_pfn = 0x400000000
efi: requested map not found.
esrt: ESRT header is not in the memory map.

And here goes error messages filtered (I can send full bootlog when needed):

ACPI Error: Field [CAP1] at 96 exceeds Buffer [NULL] size 64 (bits) (20160930/dsopcode-236)
ACPI Error: Method parse/execution failed [\_SB._OSC] (Node ffff989c350dea28), AE_AML_BUFFER_LIMIT (20160930/psparse-543)
nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 001228 [ IBUS ]
tpm tpm0: A TPM error (7) occurred attempting to read a pcr value
ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff989c33f0bea0 (20160930/exresop-594)
ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff989c350ab618), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff989c350ab190), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff989c33f0bb40 (20160930/exresop-594)
ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff989c350ab618), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff989c350ab190), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff989c33f0b288 (20160930/exresop-594)
ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff989c350ab618), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff989c350ab190), AE_AML_OPERAND_TYPE (20160930/psparse-543)
ACPI Error: Attempt to CreateField of length zero (20160930/dsopcode-168)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPI] (Node ffff989c350abac8), AE_AML_OPERAND_VALUE (20160930/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff989c350ab190), AE_AML_OPERAND_VALUE (20160930/psparse-543)

I would appreciate if anyone could point me the right direction where to
start debugging as I lived happily without any ACPI knowledge till these
days...

Thank you,
	ladis
