From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.28-rc7 acpi error messages
Date: Wed, 3 Dec 2008 15:12:55 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
 <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
 <20081203230332.GA26733@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18162 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196AbYLCXM7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 18:12:59 -0500
In-Reply-To: <20081203230332.GA26733@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

Not even the 32-bit values seem fully correct, however. For example:

[05Ch 092  1]            GPE0 Block Length : 10


[0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
[0DCh 220  1]                     Space ID : 01 (SystemIO)
[0DDh 221  1]                    Bit Width : 20
[0DEh 222  1]                   Bit Offset : 00
[0DFh 223  1]                 Access Width : 00
[0E0h 224  8]                      Address : 000000000001F028


For the first block length, I seriously doubt that the machine has (0x10 * 8) = 128 GPEs. The bit width of 0x20 (32 GPEs) sounds more reasonable.





>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
>Sent: Wednesday, December 03, 2008 3:04 PM
>To: Moore, Robert
>Cc: Koornstra, Reinoud; linux-acpi@vger.kernel.org; Brown, Len; Lin, Ming M
>Subject: Re: 2.6.28-rc7 acpi error messages
>
>On Wed, Dec 03, 2008 at 02:43:12PM -0800, Moore, Robert wrote:
>
>> Again, can't tell which one is correct.
>
>Windows uses the 32-bit values, so they'll be the correct ones. This is
>an incredibly prevalent problem and we need to just implement Windows
>compatibility here.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
