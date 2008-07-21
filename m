From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [ibm-acpi-devel] [GIT PATCH] thinkpad-acpi changes for 2.6.27 merge window
Date: Tue, 22 Jul 2008 00:17:28 +0200
Message-ID: <20080721221728.GF29543@basil.nowhere.org>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br> <20080721113217.GA28188@basil.nowhere.org> <20080721122935.GA12972@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:50476 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYGUWRb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 18:17:31 -0400
Content-Disposition: inline
In-Reply-To: <20080721122935.GA12972@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, Jul 21, 2008 at 09:29:35AM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 21 Jul 2008, Andi Kleen wrote:
> > On Tue, Jul 01, 2008 at 03:27:48PM -0300, Henrique de Moraes Holschuh wrote:
> > > Here a patchset with the thinkpad-acpi changes scheduled for 2.6.27.
> > 
> > I tried to apply them to current Linus head (last change
> > to thinkpad-acpi 24e45bbe695719dca8c20e03d386eb6ea86526b5), but there were 
> > tons of conflicts. Some patches still missing? 
> > 
> > I tried to merge the manually, but gave up when there were some
> > non trivial changes.
> > 
> > Please send a tree that actually applies.
> 
> Weird.  The stgit patch stack I used to send those certianly applies here
> on top of mainline (using git/stgit).

Hmm, weird. Maybe I got an old version for some reason.

> 
> I have the tree rebased (and had zero conflicts) on top of latest mainline
> (14b395e35d1afdd8019d11b92e28041fad591b71).  If you want, you can pull it to
> a topic branch from:
> 
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test
> 
> I will also re-send the stack as a reply to this email, just in case.

Pulled thanks.

-Andi
