From: Andi Kleen <ak@suse.de>
Subject: Re: Freeing ACPI tables after parsing
Date: Tue, 22 Aug 2006 00:26:36 +0200
Message-ID: <20060822002636.ec4b4298.ak@suse.de>
References: <200608211146.53379.ak@suse.de>
	<200608211752.16616.len.brown@intel.com>
	<20060822000647.2b117f6c.ak@suse.de>
	<200608211822.14928.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:25262 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751249AbWHUW0l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 18:26:41 -0400
In-Reply-To: <200608211822.14928.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Natalie.Protasevich@unisys.com


> I expect that if Windows tests that the BIOS marks the region properly
> and frees it, then Linux will be able to also. 

Yes agreed. Before changing it it would be good to find out if Windows
frees it or not. If not there might be BIOS assumptions that they're still 
there.

-Andi
