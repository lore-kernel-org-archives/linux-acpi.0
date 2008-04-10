From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for the 2.6.26 merge window
Date: Thu, 10 Apr 2008 23:34:58 +0100
Message-ID: <1207866898.4969.111.camel@dax.rpnet.com>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
	 <200804100237.16177.lenb@kernel.org>
	 <20080410123459.GA18832@khazad-dum.debian.net>
	 <200804101323.36432.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:55238 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbYDJXAo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 19:00:44 -0400
In-Reply-To: <200804101323.36432.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 2008-04-10 at 13:23 -0400, Len Brown wrote:
> On Thursday 10 April 2008, Henrique de Moraes Holschuh wrote:
> > On Thu, 10 Apr 2008, Len Brown wrote:
> > > hmmm, if we drop this series as-is into acpi-test then it will fail due to no "brightness_get"...
> > 
> > Yeah.  How do you want to handle this?  Defer the drop into acpi-test
> > until Richard's tree gets merged, or maybe *temporarily* merge his tree
> > in acpi-test along with thinkpad-acpi stuff?
> > 
> > I can prepare a changeset with the patches needed from Richard's tree,
> > if you prefer that to a git pull and would prefer to have those patches
> > around acpi-test so that thinkpad-acpi can be merged sooner.
> > 
> > I wanted to send you my queue before the merge window opens, so that
> > people could look at the patches, etc.  That's why I sent them in before
> > Richard's tree got merged.  The thinkpad-acpi patches did get some
> > testing already, in the thinkpad-acpi sourceforge releases.
> 
> Richard,
> 
> If the patches that Henrique depends on are unlikely to change,
> then I'll be happy to put them on a branch in my tree and put
> henrique's driver on top of them.  If they go upstream via your
> tree and/or mine and are identical, then that works fine.
> 
> However, if i check them into my tree and then you push a
> different version upstream, then we'd have a merge conflict.
> 
> Please let me know what you suggest.

Those patches are queued and I have no plans to change them before
submitting to Linus. 

When you say identical, do you mean the patches themselves or also the
commit and object IDs? 

Traditionally I have rebased the tree before sending the pull request to
minimise the changes of any merge issues and the published tree is
marked for -mm only for that reason. If thats going to cause a problem
I'll just check any merge works before sending the pull request and
leave the tree alone from now...

Cheers,

Richard

