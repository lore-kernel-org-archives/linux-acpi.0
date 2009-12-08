From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 22:27:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912072225390.4179-100000@netrider.rowland.org>
References: <200912080051.13061.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:59509 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935760AbZLHD1x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 22:27:53 -0500
In-Reply-To: <200912080051.13061.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> However, the parent can be on a different bus type than the children, so it
> looks like we can only start the asynchronous path at the core level.

Agreed.

> > Unless you want to do _all_ of the async logic in generic code and 
> > re-introduce the "dev->async_suspend" flag.
> 
> Quite frankly, I would like to.
> 
> > I would be ok with that now that the infrastructure seems so simple.
> 
> Well, perhaps I should dig out my original async suspend/resume patches
> that didn't contain all of the non-essential stuff and post them here for
> discussion, after all ...

That seems like a very good idea.  IIRC they were quite similar to what 
we have been discussing.

Alan Stern

