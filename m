From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Thu, 04 Dec 2008 10:08:47 +0800
Message-ID: <1228356527.4035.224.camel@yakui_zhao.sh.intel.com>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
	 <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
	 <20081203230332.GA26733@srcf.ucam.org>
	 <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
	 <20081203233557.GA27180@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15160 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbYLDCBD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Dec 2008 21:01:03 -0500
In-Reply-To: <20081203233557.GA27180@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

On Thu, 2008-12-04 at 07:35 +0800, Matthew Garrett wrote:
> On Wed, Dec 03, 2008 at 03:12:55PM -0800, Moore, Robert wrote:
> > Not even the 32-bit values seem fully correct, however. For example:
> > 
> > [05Ch 092  1]            GPE0 Block Length : 10
> > 
> > 
> > [0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
> > [0DCh 220  1]                     Space ID : 01 (SystemIO)
> > [0DDh 221  1]                    Bit Width : 20
> > [0DEh 222  1]                   Bit Offset : 00
> > [0DFh 223  1]                 Access Width : 00
> > [0E0h 224  8]                      Address : 000000000001F028
> > 
> > 
> > For the first block length, I seriously doubt that the machine has (0x10 * 8) = 128 GPEs. The bit width of 0x20 (32 GPEs) sounds more reasonable.
> Hmm, indeed - Intel hardware only decodes 32-bits for the GPE block. Do 
> we have the version 1 FADT from the machine as well? If that's correct 
> it suggests that Windows gets all of this information from there rather 
> than using the version 2 table at all, while if it isn't perhaps we need 
> to take the width from the 64-bit values. Sigh. What a mess.
Agree with what you said. 
   On this broken box the 32X/64X GPE0 block address mismatches.
   >ACPI Error (tbfadt-0663): 32/64X address mismatch in Gpe0Block:
0000F820/000000000001F028, using 64X
   But from the dmesg it seems that ACPI_PM_Base address is 0xF800 and
GPE0 block address should be 0xF820.

   On this box there should exist two FADT tables. One is obtained from
RSDT table(Maybe the correct address is defined in this FADT table) and
another is obtained from XSDT table. 
   On Linux the XSDT table is the default when both tables exist.
   Maybe on windows XP the RSDT table is the default. 
thanks.
> 

