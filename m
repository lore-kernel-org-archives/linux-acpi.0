From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PULL] rename ibm-acpi driver to thinkpad-acpi
Date: Fri, 30 Mar 2007 21:56:43 -0300
Message-ID: <20070331005643.GA2555@khazad-dum.debian.net>
References: <11751443243976-git-send-email-hmh@hmh.eng.br> <200703301603.55424.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53775 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933168AbXCaA4t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2007 20:56:49 -0400
Content-Disposition: inline
In-Reply-To: <200703301603.55424.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Fri, 30 Mar 2007, Len Brown wrote:
> I'm glad you're using git, it formats the patches perfectly.
> But, I'll probably always apply the plain patches instead of pulling 
> from your tree.  This is because i reserve the right to re-write history
> of my test branch to suite my own needs, and I don't want to pull
> back duplicate history from somebody that pulled acpi-test.

THAT is why I never base any of the "for-upstream" patches on acpi-test or
acpi-release.  I have screwed that up just once: the very first time I sent
you a "please pull" request, and you explained to me why it caused you
problems to have it based on acpi-test or acpi-release.

Since then, I have been basing everything on linus' tree, tipically on the
latest -rc.  And I always warn in the "please pull" email if I have to base
it on something from linus that is newer than your "linus" checkpoint (this
happened only once, so far).

I also keep the "for-upstream" branches around until the stuff in them gets
merged by Linus, and I keep them incremental-git-pull-friendly, unless I
have to change one of the patches (e.g. to make sure the tree they produce
is byte-to-byte identical to what you have commited to acpi-test).

You will get from me only clean history (unless I screw up, of course).  My
workflow is clean-history-aware, and relies extensively on stgit.  I never
have dirty history anywhere but in my "compile and run" kernel test tree (I
keep it on a separate git repository to avoid any possible mistakes).

But if you prefer to apply the email patches, well, the trees for "upstream
pull" will still be needed since I use them to triple-check everything is
clean before a git send-email run... so it basically ammounts to the same
effort to me to just send patches, just send a pull request, or to send
both.  Therefore, I will keep sending both for now, just in case it ends up
being useful.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
