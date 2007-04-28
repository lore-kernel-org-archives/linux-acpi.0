From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI interpreter errors (aer_init)
Date: Sat, 28 Apr 2007 02:31:52 -0400
Message-ID: <200704280231.52809.lenb@kernel.org>
References: <B28E9812BAF6E2498B7EC5C427F293A4025DC20B@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56245 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161216AbXD1GdO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 02:33:14 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4025DC20B@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Zhang@d975xbx2, Yanmin <yanmin.zhang@intel.com>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Friday 27 April 2007 14:05, Moore, Robert wrote:
> Status 5 from ACPICA is AE_NOT_FOUND.
> 
> _OSC is an optional control method, so whatever code is squawking about it probably handle it and shut up.
> 
> 
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Udo A. Steinberg
> Sent: Friday, April 27, 2007 5:08 AM
> To: Linux Kernel Mailing List
> Cc: Linux ACPI Mailing List
> Subject: ACPI interpreter errors
> 
> Hello,
> 
> With 2.6.21 I am getting the following errors from the ACPI interpreter on an
> Intel S5000PSL board:
> 
> Allocate Port Service[0000:02:02.0:pcie20]
> Allocate Port Service[0000:02:02.0:pcie21]
> Evaluate _OSC Set fails. Status = 0x0005
> Evaluate _OSC Set fails. Status = 0x0005
> aer_init: AER service init fails - Run ACPI _OSC fails
> aer: probe of 0000:00:02.0:pcie01 failed with error 2
> aer_init: AER service init fails - No ACPI _OSC support
> aer: probe of 0000:00:03.0:pcie01 failed with error 1
> Evaluate _OSC Set fails. Status = 0x0005
> Evaluate _OSC Set fails. Status = 0x0005
> aer_init: AER service init fails - Run ACPI _OSC fails
> aer: probe of 0000:00:04.0:pcie01 failed with error 2
> Evaluate _OSC Set fails. Status = 0x0005
> Evaluate _OSC Set fails. Status = 0x0005
> aer_init: AER service init fails - Run ACPI _OSC fails
> aer: probe of 0000:00:05.0:pcie01 failed with error 2
> Evaluate _OSC Set fails. Status = 0x0005
> Evaluate _OSC Set fails. Status = 0x0005
> aer_init: AER service init fails - Run ACPI _OSC fails
> aer: probe of 0000:00:06.0:pcie01 failed with error 2
> aer_init: AER service init fails - No ACPI _OSC support
> aer: probe of 0000:00:07.0:pcie01 failed with error 1
> 
> The complete dmesg output is attached. If you need more information, please let
> me know.

On a quick glance, it appears that these messages have been in the aer driver
since it was born.
Did you run with CONFIG_PCIEAER in 2.6.19 or 2.6.20 and not have them there?

I agree with Bob, as status 5 is AE_NOT_FOUND,
it appears that the driver is being overly verbose,
even though these appear to all be KERN_DEBUG messages.

-Len
