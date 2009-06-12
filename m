From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 21:56:14 +0200
Message-ID: <200906122156.14873.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906121547490.2862-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59537 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbZFLT4H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 15:56:07 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906121547490.2862-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Friday 12 June 2009, Alan Stern wrote:
> On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:
> 
> > So, are you suggesting that the core should only check the "all children
> > suspended" condition if special flag is set in dev_pm_info?
> 
> Or rather, check it only if the special flag _isn't_ set.

Where the default is unset, I guess?

But then, what about the resuming of the parents before the device is resumed?
Should the parents be resumed regardless of the flag state?  And if so, what's
the condition for breaking the recurrence?  Surely it's not sufficient to check
if the parent is active, because its parent need not be active if it has this
special flag set.

Best,
Rafael
