From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/8] ACPI, CPER: Update cper info
Date: Tue, 15 Oct 2013 20:10:06 -0700
Message-ID: <1381893006.22110.45.camel@joe-AO722>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
	 <1381473166-29303-3-git-send-email-gong.chen@linux.intel.com>
	 <20131011090630.GB5925@pd.tnic> <20131011154759.GJ5925@pd.tnic>
	 <1381888638.22110.43.camel@joe-AO722>
	 <20131016024633.GC6898@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:57645 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752336Ab3JPDKK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 23:10:10 -0400
In-Reply-To: <20131016024633.GC6898@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 2013-10-15 at 22:46 -0400, Chen Gong wrote:
> On Tue, Oct 15, 2013 at 06:57:18PM -0700, Joe Perches wrote:
> > Date: Tue, 15 Oct 2013 18:57:18 -0700
> > From: Joe Perches <joe@perches.com>
> > To: Borislav Petkov <bp@alien8.de>
> > Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com,
> >  linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH 2/8] ACPI, CPER: Update cper info
> > X-Mailer: Evolution 3.6.4-0ubuntu1 
> > 
> > On Fri, 2013-10-11 at 17:47 +0200, Borislav Petkov wrote:
> > > On Fri, Oct 11, 2013 at 11:06:30AM +0200, Borislav Petkov wrote:
> > > > > -	printk("%s""APEI generic hardware error status\n", pfx);
> > > > > +	printk("%s""Generic Hardware Error Status\n", pfx);
> > > > 
> > > > Btw, what's the story with printk not using KERN_x levels in this file?
> > > > Why are we falling back to default printk levels for all printks here
> > > > and shouldn't we rather prioritize them by urgency into, say, KERN_ERR,
> > > > KERN_INFO, etc?
> > > 
> > > Ignore that - checkpatch complained about it but I kinda missed that
> > > we're handing down the prefix.
> > 
> > I think it'd be better to rename pfx to level
> > as that's what printk.h calls them.
> > 
> No. pfx includes log level and prefix string both.

Perhaps it'd be better to separate them.

I haven't looked too hard, but is apei_status_print
the only place it's used with more than KERN_<LEVEL>?

