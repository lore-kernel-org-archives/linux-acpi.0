From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 6)
Date: Wed, 2 Apr 2008 10:11:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021007060.14858-100000@iolanthe.rowland.org>
References: <200804012350.01407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53149 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754531AbYDBOLP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2008 10:11:15 -0400
In-Reply-To: <200804012350.01407.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

On Tue, 1 Apr 2008, Rafael J. Wysocki wrote:

> > If the device is gone, it doesn't much matter what resume() returns.
> 
> Yes, it does.  In that cases, the error code would tell the PM core not to attempt
> to resume the device's children etc.

If the device is gone then so are its descendants, right?  So it 
doesn't matter whether the PM core tries to resume them.

>  Otherwise, it's quite meaningless to the
> PM core, because it really can mean anything and how's the PM core supposed
> to handle _that_?

Exactly.  This is the point I was trying to make a week or so ago.

> Either we decide that the error codes returned by ->resume() mean critical
> errors or there's no point in returning error codes from ->resume() at all
> (other than logging the errors by the core).
> 
> Well, that's getting confused.  I think I'll have to rework the patch not to
> really handle the errors returned by ->resume() and friends, after all, but
> I'll keep the reporting of them.
> 
> However, I'd like to add a recommendation that the _new_ "resume" callbacks
> should only return errors in critical situations as the indication to the PM
> core that something went _really_ wrong and the device in question is quite
> surely unusable.

Agreed.  The most important aspect is that drivers should _not_ return
an error if the device is working correctly.  We should fix the drivers 
which make this mistake.

Alan Stern

