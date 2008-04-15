From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Wed, 16 Apr 2008 00:02:45 +0200
Message-ID: <48052605.9000700@dbservice.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com> <48051A27.6040004@suse.de> <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:34414 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1764819AbYDOVx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 17:53:27 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Moore, Robert wrote:
> Yes, ACPI_NATIVE_UINT has issues with printf because there is
> unfortunately no printf formatting operator other than %p that goes 32
> bits in 32-bit mode and 64 bits in 64-bit mode. I think there may be
> cases in ACPICA where we just cast an ACPI_NATIVE_UINT to a pointer to
> use it with printf.

What's wrong with '%l'? The kernel printf seems to support it, and the 
printf manpage says:

A following integer conversion corresponds to a long int or unsigned 
long int argument.

And since long is 32bit on 32bit platforms and 64bit on 64bit platforms, 
it should work out fine. Or did I miss something?

tom
