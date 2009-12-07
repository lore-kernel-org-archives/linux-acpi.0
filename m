From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 17:21:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071716080.15701-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912071403520.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41486 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933112AbZLGWVb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 17:21:31 -0500
In-Reply-To: <alpine.LFD.2.00.0912071403520.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Mon, 7 Dec 2009, Linus Torvalds wrote:

> I also suspect that even if you do the USB host controller suspend 
> synchronously, doing the actual USB devices asynchronously would still 
> help - even if it's only "asynchronously per bus" thing. 
> 
> So in fact, it's probably a good first step to start off doing only the 
> USB devices, not the controller.

Interesting you should say that.  The patch I asked Arjan to test 
involved not suspending USB devices at all (root hubs being the 
exception).  That is in fact just what we do when CONFIG_USB_SUSPEND 
isn't set.

There's no need to suspend the individual devices when the whole system 
is going down.  They will automatically suspend when the controller 
stops sending out SOF packets, which occurs when the root hub is 
suspended.  The USB spec describes this, grandiosely, as a "global 
suspend".

But yes, I agree.  Doing just the USB devices is a good first step.

Alan Stern

