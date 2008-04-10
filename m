From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for the 2.6.26 merge window
Date: Thu, 10 Apr 2008 13:23:35 -0400
Message-ID: <200804101323.36432.lenb@kernel.org>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br> <200804100237.16177.lenb@kernel.org> <20080410123459.GA18832@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35610 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbYDJRYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 13:24:17 -0400
In-Reply-To: <20080410123459.GA18832@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, rpurdie@rpsys.net
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thursday 10 April 2008, Henrique de Moraes Holschuh wrote:
> On Thu, 10 Apr 2008, Len Brown wrote:
> > hmmm, if we drop this series as-is into acpi-test then it will fail due to no "brightness_get"...
> 
> Yeah.  How do you want to handle this?  Defer the drop into acpi-test
> until Richard's tree gets merged, or maybe *temporarily* merge his tree
> in acpi-test along with thinkpad-acpi stuff?
> 
> I can prepare a changeset with the patches needed from Richard's tree,
> if you prefer that to a git pull and would prefer to have those patches
> around acpi-test so that thinkpad-acpi can be merged sooner.
> 
> I wanted to send you my queue before the merge window opens, so that
> people could look at the patches, etc.  That's why I sent them in before
> Richard's tree got merged.  The thinkpad-acpi patches did get some
> testing already, in the thinkpad-acpi sourceforge releases.

Richard,

If the patches that Henrique depends on are unlikely to change,
then I'll be happy to put them on a branch in my tree and put
henrique's driver on top of them.  If they go upstream via your
tree and/or mine and are identical, then that works fine.

However, if i check them into my tree and then you push a
different version upstream, then we'd have a merge conflict.

Please let me know what you suggest.

thanks,
-Len
