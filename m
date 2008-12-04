From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.28-rc7 acpi error messages
Date: Thu, 4 Dec 2008 14:49:52 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
 <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
 <20081203230332.GA26733@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
 <20081203233557.GA27180@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com>
 <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51432 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758913AbYLDWt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 17:49:59 -0500
In-Reply-To: <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>

Well, lo and behold! With a newer version of acpidump, we do get both the RSDT and XSDT and there are indeed two different FADTs.

Acpidump should post a version number to prevent this kind of thrash in the future.

The FADT within the RSDT seems much more reasonable. It is a short (rev 1) FADT with no 64-bit register addresses to cause issues. I still suspect the GPE0 block length (0x10) however.

Incorrect table checksum is often caused by BIOS tweaking the table and forgetting to recompute it.


[000h 000  4]                    Signature : "FACP"    /* Fixed ACPI Description Table */
[004h 004  4]                 Table Length : 00000074
[008h 008  1]                     Revision : 01
[009h 009  1]                     Checksum : C1     /* Incorrect checksum, should be 0E */
[00Ah 010  6]                       Oem ID : "COMPAQ"
[010h 016  8]                 Oem Table ID : "BEARLX38"
[018h 024  4]                 Oem Revision : 00000001
[01Ch 028  4]              Asl Compiler ID : "    "
[020h 032  4]        Asl Compiler Revision : 00000000

[024h 036  4]                 FACS Address : BEFC1E00
[028h 040  4]                 DSDT Address : BEFC2647
[02Ch 044  1]                        Model : 01
[02Dh 045  1]                   PM Profile : 00
[02Eh 046  2]                SCI Interrupt : 0009
[030h 048  4]             SMI Command Port : 000000B2
[034h 052  1]            ACPI Enable Value : 02
[035h 053  1]           ACPI Disable Value : 03
[036h 054  1]               S4BIOS Command : 00
[037h 055  1]              P-State Control : 00
[038h 056  4]     PM1A Event Block Address : 0000F800
[03Ch 060  4]     PM1B Event Block Address : 00000000
[040h 064  4]   PM1A Control Block Address : 0000F804
[044h 068  4]   PM1B Control Block Address : 00000460
[048h 072  4]    PM2 Control Block Address : 00000000
[04Ch 076  4]       PM Timer Block Address : 0000F808
[050h 080  4]           GPE0 Block Address : 0000F820
[054h 084  4]           GPE1 Block Address : 00000000
[058h 088  1]       PM1 Event Block Length : 04
[059h 089  1]     PM1 Control Block Length : 02
[05Ah 090  1]     PM2 Control Block Length : 00
[05Bh 091  1]        PM Timer Block Length : 04
[05Ch 092  1]            GPE0 Block Length : 10
[05Dh 093  1]            GPE1 Block Length : 00
[05Eh 094  1]             GPE1 Base Offset : 00
[05Fh 095  1]                 _CST Support : 00
[060h 096  2]                   C2 Latency : 0032
[062h 098  2]                   C3 Latency : 03E9
[064h 100  2]               CPU Cache Size : 0000
[066h 102  2]           Cache Flush Stride : 0020
[068h 104  1]            Duty Cycle Offset : 01
[069h 105  1]             Duty Cycle Width : 03
[06Ah 106  1]          RTC Day Alarm Index : 0D
[06Bh 107  1]        RTC Month Alarm Index : 00
[06Ch 108  1]            RTC Century Index : 32
[06Dh 109  2]      Boot Architecture Flags : 0000
[06Fh 111  1]                     Reserved : 00
[070h 112  4]        Flags (decoded below) : 000000AD
                     WBINVD is operational : 1
                WBINVD does not invalidate : 0
                       All CPUs support C1 : 1
                     C2 works on MP system : 1
                   Power button is generic : 0
                   Sleep button is generic : 1
                      RTC wakeup not fixed : 0
                RTC wakeup/S4 not possible : 1
                           32-bit PM Timer : 0
                         Docking Supported : 0

Raw Table Data

  0000: 46 41 43 50 74 00 00 00 01 C1 43 4F 4D 50 41 51  FACPt.....COMPAQ
  0010: 42 45 41 52 4C 58 33 38 01 00 00 00 20 20 20 20  BEARLX38....    
  0020: 00 00 00 00 00 1E FC BE 47 26 FC BE 01 00 09 00  ........G&......
  0030: B2 00 00 00 02 03 00 00 00 F8 00 00 00 00 00 00  ................
  0040: 04 F8 00 00 60 04 00 00 00 00 00 00 08 F8 00 00  ....`...........
  0050: 20 F8 00 00 00 00 00 00 04 02 00 04 10 00 00 00   ...............
  0060: 32 00 E9 03 00 00 20 00 01 03 0D 00 32 00 00 00  2..... .....2...
  0070: AD 00 00 00                                      ....



>-----Original Message-----
>From: Koornstra, Reinoud [mailto:koornstra@hp.com]
>Sent: Thursday, December 04, 2008 11:04 AM
>To: Moore, Robert; Matthew Garrett
>Cc: linux-acpi@vger.kernel.org; Brown, Len; Lin, Ming M
>Subject: RE: 2.6.28-rc7 acpi error messages
>
>So this machine doesn't have a RSDT?
>Isn't this ultimately a bios problem, these two tables should be generated
>by the bios at boot time?
>
