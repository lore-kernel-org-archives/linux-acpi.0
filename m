From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Wed, 19 Sep 2007 16:47:24 +0200
Message-ID: <1190213244.2999.2.camel@chaos>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org>
	 <200709181359.04826.rjw@sisk.pl>
	 <20070919002717.a3a0ebfd.akpm@linux-foundation.org>
	 <200709191353.26484.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:48672 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752872AbXISOr1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2007 10:47:27 -0400
In-Reply-To: <200709191353.26484.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>

On Wed, 2007-09-19 at 13:53 +0200, Rafael J. Wysocki wrote: 
> > > > > And git-acpi breaks suspend-to-disk as well.  It gets up to "Suspending console(s)"
> > > > > and then the cursor stops blinking at it wedges up.
> > 
> > Bisection shows that the resume-from-ram failure is caused by 
> > 
> > commit 987196fa82d4db52c407e8c9d5dec884ba602183
> > Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Date:   Thu Feb 22 13:52:57 2007 -0800
> > 
> >     cpuidle take2: Core cpuidle infrastructure
> >     
> > 
> > Note that this is the patch which *fixed* resume-from-RAM prior to Thomas's
> > git-hrt merge.  Now it breaks it!?!?!
> 
> Beats me hands down. :-(
> 
> I guess Thomas and Venki should look into it.

Yeah, I twisted my brain already. I checked the difference of the
cpuidle stuff, which I have in my 2.6.23-rc6-hrt2 queue (including the
mainline clockevent fixes). It's basically zero.

My own incarnation of a jinxed VAIO is showing the same problem with
-hrt2. rc6-mm1 is not booting at all on that box. 

I'm going back into the dark fishing grounds of suspend resume
debugging.

	tglx


