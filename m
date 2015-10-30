From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 UPDATE-2 3/3] ACPI/APEI/EINJ: Allow memory error
 injection to NVDIMM
Date: Fri, 30 Oct 2015 07:48:51 -0600
Message-ID: <1446212931.20657.161.camel@hpe.com>
References: <1445894544-21382-1-git-send-email-toshi.kani@hpe.com>
	 <20151030094029.GC20952@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6216.austin.hp.com ([15.73.96.123]:58631 "EHLO
	g1t6216.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233AbbJ3Nws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2015 09:52:48 -0400
In-Reply-To: <20151030094029.GC20952@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, akpm@linux-foundation.org, dan.j.williams@intel.com, rjw@rjwysocki.net, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-10-30 at 10:40 +0100, Borislav Petkov wrote:
> On Mon, Oct 26, 2015 at 03:22:24PM -0600, Toshi Kani wrote:
> > @@ -545,10 +545,15 @@ static int einj_error_inject(u32 type, u32 flags, u64
> > param1, u64 param2,
> >  	/*
> >  	 * Disallow crazy address masks that give BIOS leeway to pick
> >  	 * injection address almost anywhere. Insist on page or
> > -	 * better granularity and that target address is normal RAM.
> > +	 * better granularity and that target address is normal RAM or
> > +	 * NVDIMM.
> >  	 */
> > -	pfn = PFN_DOWN(param1 & param2);
> > -	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
> > +	base_addr = param1 & param2;
> > +	size = (~param2) + 1;
> 
> Hmm, I missed this last time: why are the brackets there?
> 
> AFAIK, bitwise NOT has a higher precedence than addition.

Yes, the brackets are not necessary.  I put them as self-explanatory of the
precedence.  Shall I remove them, and send you an updated patch?

Thanks,
-Toshi
