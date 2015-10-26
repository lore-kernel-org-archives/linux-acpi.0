From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 UPDATE 3/3] ACPI/APEI/EINJ: Allow memory error
 injection to NVDIMM
Date: Mon, 26 Oct 2015 10:31:55 -0600
Message-ID: <1445877115.20657.88.camel@hpe.com>
References: <1445871783-18365-1-git-send-email-toshi.kani@hpe.com>
	 <3908561D78D1C84285E8C5FCA982C28F32B5F5AF@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4618.austin.hp.com ([15.73.212.83]:52923 "EHLO
	g2t4618.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbJZQfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2015 12:35:48 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32B5F5AF@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-10-26 at 16:26 +0000, Luck, Tony wrote:
> -	pfn = PFN_DOWN(param1 & param2);
> -	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
> +	base_addr = param1 & param2;
> +	size = (~param2) + 1;
> 
> We expect the user will supply us with param2 in the form 0xffffffff[fec8]00000
> with various numbers of leading 'f' and trailing '0' ... but I don't think we actually
> check that anywhere.  But we have a bunch of places that assume it is OK, including
> this new one.
> 
> It's time to fix that.  Maybe even provide a default 0xfffffffffffff000 so I can save 
> myself some typing?

+       if (((region_intersects_ram(base_addr, size) != REGION_INTERSECTS) &&
+            (region_intersects_pmem(base_addr, size) != REGION_INTERSECTS)) ||
+           ((param2 & PAGE_MASK) != PAGE_MASK))
                return -EINVAL;

The 3rd condition check makes sure that the param2 mask is the page size or less.  So, I
think we are OK on this.

Thanks,
-Toshi
