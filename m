From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Wed, 16 Apr 2008 01:51:26 +0400
Message-ID: <4805235E.6090708@suse.de>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com> <48051A27.6040004@suse.de> <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:34904 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756490AbYDOVvi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 17:51:38 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Moore, Robert wrote:
> Well, yes native word size being the pointer size, now that the 16-bit
> model is out of the picture.
> 
> We defined ACPI_NATIVE_UINT in order to have an integer data type that
> is 32 bits in 32-bit mode, and 64 bits in 64-bit mode (and originally,
> 16 bits in 16-bit mode). There is no corresponding C type that can
> accomplish this across all compilation models.
> 
> Yes, ACPI_NATIVE_UINT has issues with printf because there is
> unfortunately no printf formatting operator other than %p that goes 32
> bits in 32-bit mode and 64 bits in 64-bit mode. I think there may be
> cases in ACPICA where we just cast an ACPI_NATIVE_UINT to a pointer to
> use it with printf.
Ok, let it be obscure type with such properties.
Now back to original patch, where we change from "acpi_native_uint i;" to
"uint32 i;" Both types are not supported by printf(), while the reason of 
the patch to gain such support. There is no expectation that i will need to
be 32 bits long to not roll over, let along 64 bit.
So, once again, why we used acpi_native_uint there and why we changed that 
to uint32 and not unsigned?

Regards,
Alex.

