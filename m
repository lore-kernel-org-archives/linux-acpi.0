From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH -v2 3/3] ACPI, APEI, report GHES error information via printk
Date: Tue, 30 Nov 2010 14:47:27 +0900 (JST)
Message-ID: <20101130144707.8304.A69D9226@jp.fujitsu.com>
References: <20101129190700.92bae717.akpm@linux-foundation.org> <1291088107.12648.101.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37576 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0K3Fra (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Nov 2010 00:47:30 -0500
In-Reply-To: <1291088107.12648.101.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

> On Tue, 2010-11-30 at 11:07 +0800, Andrew Morton wrote:
> > On Tue, 30 Nov 2010 10:51:41 +0800 Huang Ying <ying.huang@intel.com> wrote:
> > 
> > > printk is one of the methods to report hardware errors to user space.
> > > This patch implements hardware error reporting for GHES via printk.
> > > 
> > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > > ---
> > >  drivers/acpi/apei/ghes.c |   21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -255,11 +255,23 @@ static void ghes_do_proc(struct ghes *gh
> > >  		}
> > >  #endif
> > >  	}
> > > +}
> > >  
> > > -	if (!processed && printk_ratelimit())
> > > -		pr_warning(GHES_PFX
> > > -		"Unknown error record from generic hardware error source: %d\n",
> > > -			   ghes->generic->header.source_id);
> > > +static void ghes_print_estatus(const char *pfx, struct ghes *ghes)
> > > +{
> > > +	if (pfx == NULL) {
> > > +		if (ghes_severity(ghes->estatus->error_severity) <=
> > > +		    GHES_SEV_CORRECTED)
> > > +			pfx = KERN_WARNING HW_ERR;
> > > +		else
> > > +			pfx = KERN_ERR HW_ERR;
> > > +	}
> > > +	if (printk_ratelimit()) {
> > > +		printk(
> > > +	"%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
> > > +	pfx, ghes->generic->header.source_id);
> > > +		apei_estatus_print(pfx, ghes->estatus);
> > 
> > That code layout is just ghastly.  Please, if it can't be done nicely
> > in 80-cols then simply exceed the 80 cols.
> 
> Just for printk, I think sometimes it may be helpful to put the "format"
> string at a new line in source code. Because it may be helpful to check
> whether the resulting string from printk fits 80 cols.

No. please reconsider why all other persons don't do that.
It's beyond ugly.


