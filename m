From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Wed, 3 Dec 2008 23:35:57 +0000
Message-ID: <20081203233557.GA27180@srcf.ucam.org>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com> <20081203230332.GA26733@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49811 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbYLCXgF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 18:36:05 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

On Wed, Dec 03, 2008 at 03:12:55PM -0800, Moore, Robert wrote:
> Not even the 32-bit values seem fully correct, however. For example:
> 
> [05Ch 092  1]            GPE0 Block Length : 10
> 
> 
> [0DCh 220 12]                   GPE0 Block : <Generic Address Structure>
> [0DCh 220  1]                     Space ID : 01 (SystemIO)
> [0DDh 221  1]                    Bit Width : 20
> [0DEh 222  1]                   Bit Offset : 00
> [0DFh 223  1]                 Access Width : 00
> [0E0h 224  8]                      Address : 000000000001F028
> 
> 
> For the first block length, I seriously doubt that the machine has (0x10 * 8) = 128 GPEs. The bit width of 0x20 (32 GPEs) sounds more reasonable.

Hmm, indeed - Intel hardware only decodes 32-bits for the GPE block. Do 
we have the version 1 FADT from the machine as well? If that's correct 
it suggests that Windows gets all of this information from there rather 
than using the version 2 table at all, while if it isn't perhaps we need 
to take the width from the 64-bit values. Sigh. What a mess.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
