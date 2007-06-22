From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
 resumes after STR
Date: Fri, 22 Jun 2007 10:07:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706220959530.3290-100000@iolanthe.rowland.org>
References: <200706220243.56056.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33906 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754203AbXFVOHR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jun 2007 10:07:17 -0400
In-Reply-To: <200706220243.56056.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mattia Dongili <malattia@linux.it>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org

On Fri, 22 Jun 2007, David Brownell wrote:

> > > Maybe we should change the kernel so that the default wakeup setting 
> > > for USB controllers is disabled. 
> 
> I'd rather not go that route.  It may well be that there's
> something odd in the current handling of wakeup events with
> EHCI.  I've not personally touched that particular code in
> several years now, and a lot of code round it has changed
> since then.

We have indeed seen some strange behavior recently.  It hasn't been 
clear whether it was caused by bad hardware, poor ACPI integration, 
EHCI driver bugs, or something else.  In fact, different bug reports 
probably had different causes.

>  Plus of course, problems that don't reproduce
> on my hardware can't get much attention from me ... there's
> something like a factor of ten or more in terms of effort
> to do that sort of remote debugging.

Absolutely.  But sometimes it's unavoidable.

> A userspace tool would certainly be doable.  That's part of why
> the sysfs wakeup attributes exist:  to cope with hardware oddities
> the kernel doesn't know about, or to cope with user preferences.

Agreed.  We should simply pick the "most useful" default setting, 
whatever that may be, and allow userspace to modify it at will.

A common case to consider is USB devices (such as keyboards or mice)
plugged into laptops.  The user puts the laptop to sleep, unplugs the 
USB devices, and packs everything up.  In that situation we don't want 
the unplug events to waken the laptop.

Adopting a user's point of view, I get the feeling that plug and unplug
aren't useful wakeup events.  But I may be wrong...  and desktop users 
are likely to have different requirements from laptop users.

Alan Stern

