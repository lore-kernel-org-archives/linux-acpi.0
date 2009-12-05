From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 13:58:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051349000.3649@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl> <alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58849 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756899AbZLEV6W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2009 16:58:22 -0500
In-Reply-To: <alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Sat, 5 Dec 2009, Linus Torvalds wrote:
> 
> In other words - I'm not pulling this crazy thing. You'd better explain 
> why it was done that way, when we already have done the same things better 
> before in different ways.

I get the feeling that all the crazy infrastructure was due to worrying 
about the suspend/resume topology.

But the reason we don't worry about that during init is that it doesn't 
really tend to matter. Most slow operations are the things that aren't 
topology-aware, ie things like spinning up/down disks etc, that really 
could be done as a separate phase instead.

For example, is there really any reason why resume doesn't look exactly 
like the init sequence? Drivers that do slow things can start async work 
to do them, and then at the end of the resume sequence we just do a "wait 
for all the async work", exactly like we do for the current init 
sequences.

And yes, for the suspend sequence we obviously need to do any async work 
(and wait for it) before we actually shut down the controllers, but that 
would be _way_ more natural to do by just introducing a "pre-suspend" hook 
that walks the device tree and does any async stuff. And then just wait 
for the async stuff to finish before doing the suspend, and perhaps again 
before doing late_suspend (maybe somebody wants to do async stuff at the 
second stage too).

Then, because we need a way to undo things if things go wrong in the 
middle (and because it's also nice to be symmetric), we'd probably want to 
introduce that kind of "post_resume()" callback that allows you have a 
separate async wakeup thing for resume time too.

What are actually the expensive/slow things during suspend/resume? Am I 
wrong when I say it's things like disk spinup/spindown (and USB discovery, 
which needs USB-level support anyway, since it can involve devices that we 
didn't even know about before discovery started).

		Linus
