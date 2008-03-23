From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 2)
Date: Sat, 22 Mar 2008 22:07:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803222157550.13906-100000@netrider.rowland.org>
References: <200803230044.29132.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:4474 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750712AbYCWCHp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Mar 2008 22:07:45 -0400
In-Reply-To: <200803230044.29132.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sun, 23 Mar 2008, Rafael J. Wysocki wrote:

> On Sunday, 23 of March 2008, Alan Stern wrote:
> > On Sat, 22 Mar 2008, Rafael J. Wysocki wrote:
> > 
> [--snip--]
> > 
> > No, you have missed the entire point.  The problem doesn't exist in the
> > current code; it exists only if we switch over to using a single list.  
> > Routines like dpm_suspend() won't be able to use list_for_each_entry()
> > to traverse the list because entries may be removed by other threads
> > during the traversal.  Even list_for_each_entry_safe() won't work
> > correctly without careful attention to details.
> 
> Ah, ok.  Thanks for the clarification.
> 
> Doesn't it help that we traverse the list under dpm_list_mtx?  Anyone who
> removes an entry is required to take dpm_list_mtx that we're holding while
> the list is traversed except when the callbacks are invoked.

It doesn't help.  What _does_ help is the fact that these traversals 
are all serialized (since only one thread can carry out a system sleep 
at any time).

> The only problem I see is when the device currently being handled is removed
> from the list by a concurrent thread.  Is that you were referring to?

Yes, that is the problem.  If you try to work around it by using
list_for_each_entry_safe() then you run into a problem when a
concurrent thread removes the device _following_ the one being handled
(or when the device being handled is the last one on the list and a
concurrent thread registers a new device, which can only happen in
dpm_prepare()).

It's not hard to fix.  Just something to be aware of.

Alan Stern

P.S.: Oh yes, another related issue...  We should call get_device() and 
put_device() while holding dpm_list_mtx.  Otherwise the device 
structure might vanish when the callbacks are invoked.

