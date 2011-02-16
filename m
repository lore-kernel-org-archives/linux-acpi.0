From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: disable HW auto-demotion
Date: Wed, 16 Feb 2011 01:19:18 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102160115160.843@x980>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
 <20110119144152.GA23020@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:47522 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab1BPGTk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2011 01:19:40 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LGP00M3J5KAGNT3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Feb 2011 00:19:29 -0600 (CST)
In-reply-to: <20110119144152.GA23020@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org

On Wed, 19 Jan 2011, Matthew Garrett wrote:

> On Tue, Jan 18, 2011 at 09:52:26PM -0500, Len Brown wrote:
> > + * Disable HW auto demotion on tick-less idle kernels
> > + */
> > +static unsigned int has_nhm_snb_hw_auto_demotion;
> > +#ifdef CONFIG_NO_HZ
> > +static unsigned int auto_demotion;
> > +#else
> > +static unsigned int auto_demotion = 1;
> > +#endif
> 
> What if someone boots with nohz=off?

The next version of this patch will disable auto-demotion
independent of HZ, on the assumption that the governor
is smart enough today to get what it asks for, HZ or NO_HZ.

It is also now limits the change to NHM/WSM,
as SNB has auto-un-demotion to address this scenario.

> Just so I'm clear on this - this is unrelated to the auto-popup on DMA, 
> right?

Right, C2 popup is a different feature, and that is smart
enought to return to the power saving state after the
DMA is done.

cheers,
Len Brown, Intel Open Source Technology Center

