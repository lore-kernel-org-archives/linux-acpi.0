From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 V2] ACPI/APEI: Add parameter check before error
 injection
Date: Wed, 22 May 2013 12:33:30 +0200
Message-ID: <20130522103330.GA15085@pd.tnic>
References: <1369034433-13666-1-git-send-email-gong.chen@linux.intel.com>
 <1369034433-13666-2-git-send-email-gong.chen@linux.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F2DA69843@ORSMSX106.amr.corp.intel.com>
 <20130522061029.GA25406@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33369 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab3EVKde (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 06:33:34 -0400
Content-Disposition: inline
In-Reply-To: <20130522061029.GA25406@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 22, 2013 at 02:10:29AM -0400, Chen Gong wrote:
> > +	 * When error injection type is memory related, param2 is the address
> > +	 * mask of param1. This mask is used to ensure that the final address
> > +	 * (param1 & param2) is meaningful. If param2 has a *weird* style
> > +	 * like 0xf0f0f0f0f0f0f0f0, it means the injection address can be
> > +	 * anywhere around param1, and that must be forbidden. In that reason,
> > +	 * PAGE_MASK is employed to avoid injection address discontinuous.
> > +	 * If one finds a special case not to satisfy this requirement, please
> > +	 * fix it.
> > +	 */
> > +	pfn = PFN_DOWN(param1 & param2);
> > +	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
> > +		return -EINVAL;
> > 
> > This has too much comment (rare!) and is still too complicated. Split the tests apart?
> 
> Your comment is great to me. Boris ever mentioned that
> "(param2 & PAGE_MASK) != PAGE_MASK)" is not usual, most of situations are
> like "(param2 & PAGE_MASK) != param2). So he wants here I can give a clear
> explanation for it. Maybe I can move my explanation into patch description.

No, please not in the patch description as no one would read it there.
You could move it above the function definition. Also, you could
simplify it a bit.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
