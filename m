From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.28-rc7 acpi error messages
Date: Wed, 3 Dec 2008 14:43:12 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41470 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYLCWnR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 17:43:17 -0500
In-Reply-To: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

Thanks for the acpidump.

>From the FADT, there are some serious issues with this machine. It appears to be a Compaq, maybe model number LX38.

We've recently improved the FADT error checking, here's what I get:


ACPI Warning (tbfadt-0626): 32/64X length mismatch in Pm1aEventBlock: 32/16 [20081204]
ACPI Warning (tbfadt-0626): 32/64X length mismatch in Gpe0Block: 128/32 [20081204]
ACPI Error (tbfadt-0663): 32/64X address mismatch in Gpe0Block: 0000F820/000000000001F028, using 64X [20081204]
ACPI Warning (tbfadt-0498): Invalid length for Pm1aEventBlock: 16, using default 32 [20081204]


Also, for \_SB_.PCI0._OSC:

>[    0.304598] ACPI Error (dsfield-0139): [CAPD] Namespace lookup failure,
>AE_ALREADY_EXISTS

        Method (_OSC, 5, NotSerialized)
        {
            Subtract (Arg2, 0x01, Local0)
            Name (CAPB, Buffer (Multiply (Arg2, 0x04)) {})
            Store (Arg3, CAPB)
            Store (One, Local1)
            CreateDWordField (CAPB, Zero, CAPF)
            While (Local0)
            {
                CreateDWordField (CAPB, Local1, CAPD)

CAPD is being created within a loop. On the second iteration it fails. 



Here's the FADT issues with the corresponding lines from the disassembled FADT:


ACPI Warning (tbfadt-0626): 32/64X length mismatch in Pm1aEventBlock: 32/16 [20081204]

32:
[058h 088  1]       PM1 Event Block Length : 04

64:
[094h 148 12]             PM1A Event Block : <Generic Address Structure>
[094h 148  1]                     Space ID : 01 (SystemIO)
[095h 149  1]                    Bit Width : 10
[096h 150  1]                   Bit Offset : 00
[097h 151  1]                 Access Width : 00

Bit Width above should be 0x20


ACPI Warning (tbfadt-0626): 32/64X length mismatch in Gpe0Block: 128/32 [20081204]

32:
[05Ch 092  1]            GPE0 Block Length : 10

64:
[0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
[0DCh 220  1]                     Space ID : 01 (SystemIO)
[0DDh 221  1]                    Bit Width : 20
[0DEh 222  1]                   Bit Offset : 00
[0DFh 223  1]                 Access Width : 00
[0E0h 224  8]                      Address : 000000000001F028

I can't tell which one is correct.


ACPI Error (tbfadt-0663): 32/64X address mismatch in Gpe0Block: 0000F820/000000000001F028, using 64X [20081204]

32:
[050h 080  4]           GPE0 Block Address : 0000F820

64:
[0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
[0DCh 220  1]                     Space ID : 01 (SystemIO)
[0DDh 221  1]                    Bit Width : 20
[0DEh 222  1]                   Bit Offset : 00
[0DFh 223  1]                 Access Width : 00
[0E0h 224  8]                      Address : 000000000001F028

Again, can't tell which one is correct.


ACPI Warning (tbfadt-0498): Invalid length for Pm1aEventBlock: 16, using default 32 [20081204]

This is actually repairing the problem found in the first warning above.



2 questions:
1) Do GPEs and events work on this machine?
2) Does Windows run properly on this machine?


Bob




>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Koornstra, Reinoud
>Sent: Wednesday, December 03, 2008 1:22 PM
>To: linux-acpi@vger.kernel.org
>Subject: 2.6.28-rc7 acpi error messages
>
>HI Everyone,
>
>2.6.28-rc7 works nicely here, I'm only seeing some non critical errors:
>
>[    0.000000] ACPI Error (tbfadt-0471): 32/64X address mismatch in
>"Gpe0Block": [0000F820] [000000000001F028], using 64X [20080926]
>[    0.000000] 2171MB HIGHMEM available.
>[    0.000000] 883MB LOWMEM available.
>[    0.000999] Memory: 3094036k/3129092k available (3049k kernel code,
>33768k reserved, 2026k data, 328k init, 2223884k highmem)
>
>[    0.304598] ACPI Error (dsfield-0139): [CAPD] Namespace lookup failure,
>AE_ALREADY_EXISTS
>[    0.304601] ACPI Error (psparse-0524): Method parse/execution failed
>[\_SB_.PCI0._OSC] (Node f6c16cf0), AE_ALREADY_EXISTS
>[    0.304605] ACPI: Marking method _OSC as Serialized because of
>AE_ALREADY_EXISTS error
>[    0.305297] ACPI Error (dsfield-0139): [CAPD] Namespace lookup failure,
>AE_ALREADY_EXISTS
>[    0.305300] ACPI Error (psparse-0524): Method parse/execution failed
>[\_SB_.PCI0._OSC] (Node f6c16cf0), AE_ALREADY_EXISTS
>
>Any suggestions?
>Kind Regards,
>
>Reinoud.
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
