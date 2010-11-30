From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 3/3] ACPI, APEI, report GHES error information via
 printk
Date: Tue, 30 Nov 2010 11:35:07 +0800
Message-ID: <1291088107.12648.101.camel@yhuang-dev>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
	 <1291085501-31494-4-git-send-email-ying.huang@intel.com>
	 <20101129190700.92bae717.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21647 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab0K3DfJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 22:35:09 -0500
In-Reply-To: <20101129190700.92bae717.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 2010-11-30 at 11:07 +0800, Andrew Morton wrote:
> On Tue, 30 Nov 2010 10:51:41 +0800 Huang Ying <ying.huang@intel.com> wrote:
> 
> > printk is one of the methods to report hardware errors to user space.
> > This patch implements hardware error reporting for GHES via printk.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > ---
> >  drivers/acpi/apei/ghes.c |   21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -255,11 +255,23 @@ static void ghes_do_proc(struct ghes *gh
> >  		}
> >  #endif
> >  	}
> > +}
> >  
> > -	if (!processed && printk_ratelimit())
> > -		pr_warning(GHES_PFX
> > -		"Unknown error record from generic hardware error source: %d\n",
> > -			   ghes->generic->header.source_id);
> > +static void ghes_print_estatus(const char *pfx, struct ghes *ghes)
> > +{
> > +	if (pfx == NULL) {
> > +		if (ghes_severity(ghes->estatus->error_severity) <=
> > +		    GHES_SEV_CORRECTED)
> > +			pfx = KERN_WARNING HW_ERR;
> > +		else
> > +			pfx = KERN_ERR HW_ERR;
> > +	}
> > +	if (printk_ratelimit()) {
> > +		printk(
> > +	"%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
> > +	pfx, ghes->generic->header.source_id);
> > +		apei_estatus_print(pfx, ghes->estatus);
> 
> That code layout is just ghastly.  Please, if it can't be done nicely
> in 80-cols then simply exceed the 80 cols.

Just for printk, I think sometimes it may be helpful to put the "format"
string at a new line in source code. Because it may be helpful to check
whether the resulting string from printk fits 80 cols.

> And please don't use (or retain) printk_ratelimit().  It was a mistake.
> A printk_ratelimt() site shares state with all other
> printk_ratelimit() states, so if a random firewire driver is doing a lot of
> printk_ratelimit() calls, your messages get suppressed!  Use
> printk_ratelimited() or __ratelimit().

Yes. Will change this.

Best Regards,
Huang Ying


