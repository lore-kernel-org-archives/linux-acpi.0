From: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3] intel_idle: fix API misuse
Date: Tue, 17 Jan 2012 16:55:06 -0800
Message-ID: <20120118005506.GB27737@kroah.com>
References: <20120110234819.7F484100270@wpzn3.hot.corp.google.com>
 <201201171137.58857.trenn@suse.de>
 <20120117162143.28192549.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44164 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026Ab2ARAzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 19:55:21 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8A29620B38
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 19:55:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120117162143.28192549.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, shaohua.li@intel.com, stable@vger.kernel.org

On Tue, Jan 17, 2012 at 04:21:43PM -0800, Andrew Morton wrote:
> (let's cc stable on this thread then!)
> 
> On Tue, 17 Jan 2012 11:37:58 +0100
> Thomas Renninger <trenn@suse.de> wrote:
> 
> > On Wednesday, January 11, 2012 12:48:19 AM akpm@linux-foundation.org wrote:
> > > From: Shaohua Li <shaohua.li@intel.com>
> > > Subject: intel_idle: fix API misuse
> > 
> > This one looks worth adding:
> > CC: stable@vger.kernel.org
> > 
> >  
> > > smp_call_function() only lets all other CPUs execute a specific function,
> > > while we expect all CPUs do in intel_idle.  Without the fix, we could have
> > > one cpu which has auto_demotion enabled or has no boradcast timer setup. 
> > > Usually we don't see impact because auto demotion just harms power and the
> > > intel_idle init is called in CPU 0, where boradcast timer delivers
> > > interrupt, but this still could be a problem.
> > > 
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > CC: stable@vger.kernel.org
> > 
> 
> OK.  I think Len is processing these patches at present.  So
> stable@vger.kernel.org will see when I've dropped my copy of the patch,
> but the version which goes into mainline might be missing the stable
> tag.  Hopefully Greg is awake enough to sort out that cryptic messaging!

In case I'm not, can someone send me the git commit ids that you want
added to the stable trees to stable@vger.kernel.org when they hit
Linus's tree?

thanks,

greg k-h
