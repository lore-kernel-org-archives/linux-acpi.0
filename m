From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.28-rc7 acpi error messages
Date: Thu, 4 Dec 2008 07:50:30 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
 <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
 <20081203230332.GA26733@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
 <20081203233557.GA27180@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43492 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbYLDPuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 10:50:37 -0500
In-Reply-To: <20081203233557.GA27180@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

There appears to be one FADT on this machine, version 3:

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20081204
 *
 * Disassembly of FACP.dat, Thu Dec 04 07:30:31 2008
 *
 * ACPI Data Table [FACP]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 000  4]                    Signature : "FACP"    /* Fixed ACPI Description Table */
[004h 004  4]                 Table Length : 000000F4
[008h 008  1]                     Revision : 03
[009h 009  1]                     Checksum : 98
[00Ah 010  6]                       Oem ID : "COMPAQ"
[010h 016  8]                 Oem Table ID : "    LX38"
[018h 024  4]                 Oem Revision : BEFC2647
[01Ch 028  4]              Asl Compiler ID : "    "
[020h 032  4]        Asl Compiler Revision : 00000000

[024h 036  4]                 FACS Address : BEFC1E00
[028h 040  4]                 DSDT Address : BEFC2647
[02Ch 044  1]                        Model : 01
[02Dh 045  1]                   PM Profile : 03
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
[06Dh 109  2]      Boot Architecture Flags : 0013
[06Fh 111  1]                     Reserved : 00
[070h 112  4]        Flags (decoded below) : 000000A5
                     WBINVD is operational : 1
                WBINVD does not invalidate : 0
                       All CPUs support C1 : 1
                     C2 works on MP system : 0
                   Power button is generic : 0
                   Sleep button is generic : 1
                      RTC wakeup not fixed : 0
                RTC wakeup/S4 not possible : 1
                           32-bit PM Timer : 0
                         Docking Supported : 0
                  Reset Register Supported : 0
                               Sealed Case : 0
                       Headless - No Video : 0
                Native instr after SLP_TYP : 0
                      PCIEXP_WAK Supported : 0
                        Use Platform Timer : 0
                    RTC_STS valid after S4 : 0
                   Remote Power-on capable : 0
                        APIC Cluster Model : 0
                   APIC Physical Dest Mode : 0

[074h 116 12]               Reset Register : <Generic Address Structure>
[074h 116  1]                     Space ID : 01 (SystemIO)
[075h 117  1]                    Bit Width : 08
[076h 118  1]                   Bit Offset : 00
[077h 119  1]                 Access Width : 00
[078h 120  8]                      Address : 0000000000000CF9

[080h 128  1]         Value to cause reset : 06
[081h 129  3]                     Reserved : 000000
[084h 132  8]                 FACS Address : 00000000BEFC1E00
[08Ch 140  8]                 DSDT Address : 00000000BEFC2647
[094h 148 12]             PM1A Event Block : <Generic Address Structure>
[094h 148  1]                     Space ID : 01 (SystemIO)
[095h 149  1]                    Bit Width : 10
[096h 150  1]                   Bit Offset : 00
[097h 151  1]                 Access Width : 00
[098h 152  8]                      Address : 000000000000F800

[0A0h 160 12]             PM1B Event Block : <Generic Address Structure>
[0A0h 160  1]                     Space ID : 00 (SystemMemory)
[0A1h 161  1]                    Bit Width : 00
[0A2h 162  1]                   Bit Offset : 00
[0A3h 163  1]                 Access Width : 00
[0A4h 164  8]                      Address : 0000000000000000

[0ACh 172 12]           PM1A Control Block : <Generic Address Structure>
[0ACh 172  1]                     Space ID : 01 (SystemIO)
[0ADh 173  1]                    Bit Width : 10
[0AEh 174  1]                   Bit Offset : 00
[0AFh 175  1]                 Access Width : 00
[0B0h 176  8]                      Address : 000000000000F804

[0B8h 184 12]           PM1B Control Block : <Generic Address Structure>
[0B8h 184  1]                     Space ID : 01 (SystemIO)
[0B9h 185  1]                    Bit Width : 10
[0BAh 186  1]                   Bit Offset : 00
[0BBh 187  1]                 Access Width : 00
[0BCh 188  8]                      Address : 0000000000000460

[0C4h 196 12]            PM2 Control Block : <Generic Address Structure>
[0C4h 196  1]                     Space ID : 01 (SystemIO)
[0C5h 197  1]                    Bit Width : 08
[0C6h 198  1]                   Bit Offset : 00
[0C7h 199  1]                 Access Width : 00
[0C8h 200  8]                      Address : 0000000000000000

[0D0h 208 12]               PM Timer Block : <Generic Address Structure>
[0D0h 208  1]                     Space ID : 01 (SystemIO)
[0D1h 209  1]                    Bit Width : 20
[0D2h 210  1]                   Bit Offset : 00
[0D3h 211  1]                 Access Width : 00
[0D4h 212  8]                      Address : 000000000000F808

[0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
[0DCh 220  1]                     Space ID : 01 (SystemIO)
[0DDh 221  1]                    Bit Width : 20
[0DEh 222  1]                   Bit Offset : 00
[0DFh 223  1]                 Access Width : 00
[0E0h 224  8]                      Address : 000000000001F028

[0E8h 232 12]                   GPE1 Block : <Generic Address Structure>
[0E8h 232  1]                     Space ID : 00 (SystemMemory)
[0E9h 233  1]                    Bit Width : 00
[0EAh 234  1]                   Bit Offset : 00
[0EBh 235  1]                 Access Width : 00
[0ECh 236  8]                      Address : 0000000000000000

ACPI Warning (tbfadt-0626): 32/64X length mismatch in Pm1aEventBlock: 32/16 [20081204]
ACPI Warning (tbfadt-0626): 32/64X length mismatch in Gpe0Block: 128/32 [20081204]
ACPI Error (tbfadt-0663): 32/64X address mismatch in Gpe0Block: 0000F820/000000000001F028, using 64 [20081204]
ACPI Warning (tbfadt-0498): Invalid length for Pm1aEventBlock: 16, using default 32 [20081204]

Raw Table Data

  0000: 46 41 43 50 F4 00 00 00 03 98 43 4F 4D 50 41 51  FACP......COMPAQ
  0010: 20 20 20 20 4C 58 33 38 47 26 FC BE 20 20 20 20      LX38G&..    
  0020: 00 00 00 00 00 1E FC BE 47 26 FC BE 01 03 09 00  ........G&......
  0030: B2 00 00 00 02 03 00 00 00 F8 00 00 00 00 00 00  ................
  0040: 04 F8 00 00 60 04 00 00 00 00 00 00 08 F8 00 00  ....`...........
  0050: 20 F8 00 00 00 00 00 00 04 02 00 04 10 00 00 00   ...............
  0060: 32 00 E9 03 00 00 20 00 01 03 0D 00 32 13 00 00  2..... .....2...
  0070: A5 00 00 00 01 08 00 00 F9 0C 00 00 00 00 00 00  ................
  0080: 06 00 00 00 00 1E FC BE 00 00 00 00 47 26 FC BE  ............G&..
  0090: 00 00 00 00 01 10 00 00 00 F8 00 00 00 00 00 00  ................
  00A0: 00 00 00 00 00 00 00 00 00 00 00 00 01 10 00 00  ................
  00B0: 04 F8 00 00 00 00 00 00 01 10 00 00 60 04 00 00  ............`...
  00C0: 00 00 00 00 01 08 00 00 00 00 00 00 00 00 00 00  ................
  00D0: 01 20 00 00 08 F8 00 00 00 00 00 00 01 20 00 00  . ........... ..
  00E0: 28 F0 01 00 00 00 00 00 00 00 00 00 00 00 00 00  (...............
  00F0: 00 00 00 00                                      ....

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
>Sent: Wednesday, December 03, 2008 3:36 PM
>To: Moore, Robert
>Cc: Koornstra, Reinoud; linux-acpi@vger.kernel.org; Brown, Len; Lin, Ming M
>Subject: Re: 2.6.28-rc7 acpi error messages
>
>On Wed, Dec 03, 2008 at 03:12:55PM -0800, Moore, Robert wrote:
>> Not even the 32-bit values seem fully correct, however. For example:
>>
>> [05Ch 092  1]            GPE0 Block Length : 10
>>
>>
>> [0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
>> [0DCh 220  1]                     Space ID : 01 (SystemIO)
>> [0DDh 221  1]                    Bit Width : 20
>> [0DEh 222  1]                   Bit Offset : 00
>> [0DFh 223  1]                 Access Width : 00
>> [0E0h 224  8]                      Address : 000000000001F028
>>
>>
>> For the first block length, I seriously doubt that the machine has (0x10
>* 8) = 128 GPEs. The bit width of 0x20 (32 GPEs) sounds more reasonable.
>
>Hmm, indeed - Intel hardware only decodes 32-bits for the GPE block. Do
>we have the version 1 FADT from the machine as well? If that's correct
>it suggests that Windows gets all of this information from there rather
>than using the version 2 table at all, while if it isn't perhaps we need
>to take the width from the 64-bit values. Sigh. What a mess.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
