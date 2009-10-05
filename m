From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for
 2.6.32-rc1
Date: Mon, 5 Oct 2009 14:04:15 -0700
Message-ID: <20091005140415.57f1db5e.akpm@linux-foundation.org>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain>
	<20091005033256.GA26592@balbir.in.ibm.com>
	<200910052159.24920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34341 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557AbZJEVGC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 17:06:02 -0400
In-Reply-To: <200910052159.24920.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: balbir@linux.vnet.ibm.com, lenb@kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, a.p.zijlstra@chello.nl, shaohua.li@intel.com, svaidy@linux.vnet.ibm.com

On Mon, 5 Oct 2009 21:59:24 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > >     Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > >     NACKed-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > >     Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> > >     Signed-off-by: Len Brown <len.brown@intel.com>
> > 
> > This is a first a patch with a NACKed-by, could we please have more
> > discussion on the proposed design.
> 
> This thing has already been merged, it appears:
> 
> commit 8e0af5141ab950b78b3ebbfaded5439dcf8b3a8d
> Author: Shaohua Li <shaohua.li@intel.com>
> Date:   Mon Jul 27 18:11:02 2009 -0400
> 
>     ACPI: create Processor Aggregator Device driver
> 
> and it looks like a total breakage of rules to me.

To me also.

I'm not a great believer in "rules".  They're only guidelines based on
past experience and an expectation that prior experience is a predictor
of future outcomes.  Sometimes, in some cases that prediction breaks down,
so we should ignore the "rules".  But this does not appear to be such a
case.

The driver was merged over Peter's strenuous and reasonable-sounding
objections.  Partly because of:

On Fri, 26 Jun 2009 12:46:53 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> ...
> We'd like to ship the forced-idle thread as a self-contained driver,
> if possilbe.  Because that would enable us to easily back-port it
> to some enterprise releases that want the feature.  So if we can
> implement this such that it is functional with existing scheduler
> facilities, that would be get us by.  If the scheduler evolves
> and provides a more optimal mechanism in the future, then that is
> great, as long as we don't have to wait for that to provide
> the basic version of the feature.

Problem is, that plan doesn't work.  If in 2.6.33 we add the new
scheduler capabilities and then convert this driver to utilise them
then the enterprise releases don't really have a backported driver any
more.  They own some special thing which was cherrypicked in a
mid-development stage from 2.6.32.  And future enhancement or fixing of
that driver is not applicable to the enterprise kernel's version.  So a
large part of the reason for preferring to use backported mainline
features will be invalidated.


All that being said, I don't see a lot of gain in reverting the driver
now.  From the mainline kernel's POV we make the scheduler changes,
alter the driver and then proceed happily.  The thus-stranded
enterprise kernel people are then somewhat screwed, but what can we do?
Apart from asking "please don't do this again".



Technical question: the overall feature, which I'd describe as
"shutting down CPUs when an external agent tells us the
thermal/electrical/other load is too high" is not at all specific to
the x86 CPU.  Should the code have been designed in such a way as to
permit other architectures to play?  

