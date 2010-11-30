From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 3/3] ACPI, APEI, report GHES error information via
 printk
Date: Tue, 30 Nov 2010 14:20:25 +0800
Message-ID: <1291098025.12648.124.camel@yhuang-dev>
References: <20101129190700.92bae717.akpm@linux-foundation.org>
	 <1291088107.12648.101.camel@yhuang-dev>
	 <20101130144707.8304.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6529 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0K3GU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Nov 2010 01:20:29 -0500
In-Reply-To: <20101130144707.8304.A69D9226@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 2010-11-30 at 13:47 +0800, KOSAKI Motohiro wrote:
> > On Tue, 2010-11-30 at 11:07 +0800, Andrew Morton wrote:
> > > On Tue, 30 Nov 2010 10:51:41 +0800 Huang Ying <ying.huang@intel.com> wrote:
[...]
> > > > +static void ghes_print_estatus(const char *pfx, struct ghes *ghes)
> > > > +{
> > > > +	if (pfx == NULL) {
> > > > +		if (ghes_severity(ghes->estatus->error_severity) <=
> > > > +		    GHES_SEV_CORRECTED)
> > > > +			pfx = KERN_WARNING HW_ERR;
> > > > +		else
> > > > +			pfx = KERN_ERR HW_ERR;
> > > > +	}
> > > > +	if (printk_ratelimit()) {
> > > > +		printk(
> > > > +	"%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
> > > > +	pfx, ghes->generic->header.source_id);
> > > > +		apei_estatus_print(pfx, ghes->estatus);
> > > 
> > > That code layout is just ghastly.  Please, if it can't be done nicely
> > > in 80-cols then simply exceed the 80 cols.
> > 
> > Just for printk, I think sometimes it may be helpful to put the "format"
> > string at a new line in source code. Because it may be helpful to check
> > whether the resulting string from printk fits 80 cols.
> 
> No. please reconsider why all other persons don't do that.
> It's beyond ugly.

I think that "why other persons don't/do do that" is not good reasoning.

Best Regards,
Huang Ying


