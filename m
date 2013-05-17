From: Andy Lutomirski <luto@amacapital.net>
Subject: BGRT wild pointer
Date: Fri, 17 May 2013 12:36:47 -0700
Message-ID: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:43256 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617Ab3EQThJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 May 2013 15:37:09 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so4384075lab.32
        for <linux-acpi@vger.kernel.org>; Fri, 17 May 2013 12:37:08 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matthew Garrett <mjg59@srcf.ucam.org>

My MSI 79A-GD65 (8D) (MS-7760), which is a shining example of firmware
engineering, warns like this on startup:

[    0.061363] ioremap: invalid physical address d0bb01800000001
[    0.061365] ------------[ cut here ]------------
[    0.061368] WARNING: at arch/x86/mm/ioremap.c:85
__ioremap_caller+0x35a/0x370()
[    0.061369] Hardware name: MS-7760
[    0.061370] Modules linked in:
[    0.061372] Pid: 0, comm: swapper/0 Not tainted 3.8.11-200.fc18.x86_64 #1
[    0.061373] Call Trace:
[    0.061377]  [<ffffffff8105e675>] warn_slowpath_common+0x75/0xa0
[    0.061379]  [<ffffffff8105e6ba>] warn_slowpath_null+0x1a/0x20
[    0.061381]  [<ffffffff8104779a>] __ioremap_caller+0x35a/0x370
[    0.061383]  [<ffffffff81059645>] ? efi_bgrt_init+0xc5/0x160
[    0.061385]  [<ffffffff813800b0>] ? acpi_get_table_with_size+0x5f/0xbe
[    0.061386]  [<ffffffff81047807>] ioremap_nocache+0x17/0x20
[    0.061388]  [<ffffffff81059645>] efi_bgrt_init+0xc5/0x160
[    0.061390]  [<ffffffff81d18bb6>] efi_late_init+0x9/0xb
[    0.061392]  [<ffffffff81d00c31>] start_kernel+0x3c2/0x3de
[    0.061394]  [<ffffffff81d0066e>] ? repair_env_string+0x5e/0x5e
[    0.061395]  [<ffffffff81d00356>] x86_64_start_reservations+0x131/0x135
[    0.061397]  [<ffffffff81d0045a>] x86_64_start_kernel+0x100/0x10f
[    0.061401] ---[ end trace 6a8f322ccc28a247 ]---

The BGRT table is, indeed, buggered, according to a build of iasl from git:

[000h 0000   4]                    Signature : "BGRT"    [Boot
Graphics Resource Table]
[004h 0004   4]                 Table Length : 0000003C
[008h 0008   1]                     Revision : 00
[009h 0009   1]                     Checksum : B3
[00Ah 0010   6]                       Oem ID : "ALASKA"
[010h 0016   8]                 Oem Table ID : "A M I"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 00010013

[024h 0036   2]                      Version : 0001
[026h 0038   1]                       Status : 00
[027h 0039   1]                   Image Type : 00
[028h 0040   8]                Image Address : 0D0BB01800000001
[030h 0048   4]                Image OffsetX : 00000000
[034h 0052   4]                Image OffsetY : 00000000

Raw Table Data: Length 60 (0x3C)

  0000: 42 47 52 54 3C 00 00 00 00 B3 41 4C 41 53 4B 41  BGRT<.....ALASKA
  0010: 41 20 4D 20 49 00 00 00 09 20 07 01 41 4D 49 20  A M I.... ..AMI
  0020: 13 00 01 00 01 00 00 00 01 00 00 00 18 B0 0B 0D  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00              ............

A simple "fix" would be to ignore the BGRT if the status is "invalid",
which mine is -- even if the image address actually pointed somewhere,
the contents are probably uninteresting.  Or maybe just do that if
efi_lookup_mapped_addr fails.

--Andy
