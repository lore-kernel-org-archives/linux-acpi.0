From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target
 sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 13:11:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706211303120.3547-100000@iolanthe.rowland.org>
References: <200706210935.16864.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44968 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754682AbXFURLp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 13:11:45 -0400
In-Reply-To: <200706210935.16864.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, 21 Jun 2007, David Brownell wrote:

> > If a driver wants to find out whether some resource will be available
> > in the target system state, the only way is to ask the resource's
> > provider.  Hence the driver needs to have some cookie (representing the
> > target state) that it can pass to the provider.
> 
> Not true.  The provider knows the target state.  Just ask it whether
> the resource will be available.  It doesn't need a cookie to distinguish
> between multiple target states, since there can be only one.

_How_ does the provider know what the next target state is?  Right now
there's no way for that information to get from the PM core to the
provider other than pm_message_t, and the pm_message_t will generally
be passed to the provider _after_ it is passed to the lower-level
drivers.

There could be a global next_pm_system_state() routine.  It would have
to return _something_ -- and I think a cookie would be better than a
struct.

There are other possible ways to disseminate the information.  The 
details don't matter much, and relatively few drivers would care.  
However the form of the information is a legitimate concern at this 
point.

Alan Stern

