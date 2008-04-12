From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for the 2.6.26 merge window
Date: Sat, 12 Apr 2008 10:54:10 -0300
Message-ID: <20080412135410.GF3402@khazad-dum.debian.net>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br> <200804100237.16177.lenb@kernel.org> <20080410123459.GA18832@khazad-dum.debian.net> <200804101323.36432.lenb@kernel.org> <1207866898.4969.111.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54321 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752009AbYDLNyO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Apr 2008 09:54:14 -0400
Content-Disposition: inline
In-Reply-To: <1207866898.4969.111.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 10 Apr 2008, Richard Purdie wrote:
> On Thu, 2008-04-10 at 13:23 -0400, Len Brown wrote:
> > If the patches that Henrique depends on are unlikely to change,
> > then I'll be happy to put them on a branch in my tree and put
> > henrique's driver on top of them.  If they go upstream via your
> > tree and/or mine and are identical, then that works fine.
> > 
> > However, if i check them into my tree and then you push a
> > different version upstream, then we'd have a merge conflict.
> > 
> > Please let me know what you suggest.
> 
> Those patches are queued and I have no plans to change them before
> submitting to Linus. 
> 
> When you say identical, do you mean the patches themselves or also the
> commit and object IDs? 

The object IDs can't be the same, unless Len base his acpi-tree on
yours, or you base your tree on his, AFAIK.  Since both you AND Len
usually rebase to latest linus before sending a pull request (which is
nicer to people doing bissections and far less patch-mismerge-prone),
this will be unoptimal to both of you.

So, suppose then that the object IDs are different (i.e. Len merged your
tree into acpi-test, and Linus merged it in mainline), BUT that the
resulting blobs are the same for the files that are affected by BOTH
trees being merged at the same time:

Git simply does the right thing, notices the file are the same, doesn't
complain, and if you look at the history, your patches will be in the
history twice: once in Len's branch that was merged, and once in
mainline where Linus merged it.  Which is exactly what happened anyway,
and thus, correct.   It will also do the right thing on bissects, etc.

However, if at the point Len's tree is merged in mainline, anything else
already touched the files and changed them beyond what your tree (as
merged by Len) had... conflicts might arrise.

IMHO, the easiest solution here is for Len to hold my thinkpad-acpi
patches a small bit, and land them in acpi-test only after Richard's are
upstream.  This means the thinkpad-acpi patches get less testing in
acpi-test before they land in mainline either in late rc1 or before
rc2...  but these patches are already being tested outside of acpi-test
anyway, and they can't do more than break thinkpad-acpi, which I can
swiftly fix and won't cause trouble anywhere else in the kernel.

So Len, since I did meet the required lead time window for acpi-test
submission :-) and if you don't have anything against a somewhat later
merge of thinkpad-acpi for 2.6.26's merge window or for 2.6.26-rc1, we
could probably just take the easy way, and merge thinkpad-acpi in
acpi-test after Richard's LED tree is in mainline already.

Meanwhile, I will resend the patch series with the typos Randy pointed
out fixed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
