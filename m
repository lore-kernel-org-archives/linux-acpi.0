From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 6)
Date: Tue, 1 Apr 2008 16:56:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
References: <200804012212.48609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:3853 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752288AbYDAU44 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 16:56:56 -0400
In-Reply-To: <200804012212.48609.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

On Tue, 1 Apr 2008, Rafael J. Wysocki wrote:

> > Does ..._ext_... mean extended? (external?) If 'extended' (or if not),
> > does that imply that they're mutually exclusive alternatives for drivers
> > to use?
> 
> 'ext' means 'extended'.  The idea is that the 'extended' version will be used
> by bus types / driver types that don't need to implement the _noirq callbacks.

Something's wrong here.  This seems to say that the "extended" version
has _fewer_ method pointers -- in which case it should be called 
"restricted" instead.

> > So drivers can never validly fail to resume. That sounds fair enough. If
> > the hardware has gone away while in lower power mode (USB, say), should
> > the driver then just printk an error and return success?
> 
> I think so.
> 
> IMO, an error code returned by a driver's ->resume() should mean "the device
> hasn't resumed and is presumably dead".  Otherwise, ->resume() should return
> success.

If the device is gone, it doesn't much matter what resume() returns.

Alan Stern

