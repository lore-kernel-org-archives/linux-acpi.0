From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 12:14:10 +0100
Message-ID: <200912151214.10980.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <alpine.LFD.2.00.0912141609020.14385@localhost.localdomain> <alpine.LFD.2.00.0912141610460.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51689 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759837AbZLOLNc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 06:13:32 -0500
In-Reply-To: <alpine.LFD.2.00.0912141610460.14385@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tuesday 15 December 2009, Linus Torvalds wrote:
> 
> On Mon, 14 Dec 2009, Linus Torvalds wrote:
> > 
> > I get really tired of this whole stupid async discussion, because you're 
> > overdesigning it.
> 
> Btw, this is important. I'm not going to pull even your _current_ async 
> stuff if you can't show that you fundamentally UNDERSTAND this fact.

What fact?  The only thing that matters is USB?  For resume, it is.  For
suspend, it clearly isn't.

> Stop making up idiotic complex interfaces. Look at my one-liner patch, and 
> realize that it gets you 99% there - the 99% that matters.

I said I was going to use it, but I don't think that's going to be sufficient.

[BTW, I'm not sure what you want to achieve by insulting me.  Either you may
want to scare me, but I'm not scared, or you may want to try to make me so
disgusted that I'll just give up and back off, but this is not going to happen
either.]

Insults aside, I'm going to make some measurements to see how much time we can
save.

Rafael
