From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Mon, 7 Jan 2008 12:23:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801071207090.2748-100000@iolanthe.rowland.org>
References: <200801071752.00138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56114 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753959AbYAGRXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 12:23:18 -0500
In-Reply-To: <200801071752.00138.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Mon, 7 Jan 2008, Rafael J. Wysocki wrote:

> Please see the patch at: http://lkml.org/lkml/2008/1/6/298 .  It represents my
> current idea about how to do that.

It has some problems.

First, note that the list manipulations in dpm_suspend(), 
device_power_down(), and so on aren't protected by dpm_list_mtx.  So 
your patch could corrupt the list pointers.  Are you assuming that no 
other threads can be running at this time?

Note also that device_pm_destroy_suspended() does up(&dev->sem), but it 
doesn't know whether or not dev->sem was locked to begin with.

Do you want to rule out the possibility of a driver's suspend or remove 
methods calling destroy_suspended_device() on its own device?  With 
your synchronous approach, this would mean that the suspend/resume 
method would indirectly end up calling the remove method.  This is 
dangerous at best; with USB it would be a lockdep violation.  With an 
asynchronous approach, on the other hand, this wouldn't be a problem.

Alan Stern

