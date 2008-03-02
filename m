From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation callbacks (highest level)
Date: Sun, 2 Mar 2008 19:13:08 +0100
Message-ID: <200803021913.09104.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803021123100.9430-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39932 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbYCBSOd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Mar 2008 13:14:33 -0500
In-Reply-To: <Pine.LNX.4.44L0.0803021123100.9430-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>

On Sunday, 2 of March 2008, Alan Stern wrote:
> On Sun, 2 Mar 2008, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > Below is a patch that introduces the separation of suspend and hibernation
> > callbacks on the highest level, which is the PM core.  This patch is a result
> > of a very recent work by Alex and me.
> > 
> > For now, we only take into account the callbacks necessary to replace the
> > existing code, so we haven't introduced any substantially new callbacks.  The
> > question is whether or not we'll need such callbacks and what purpose they
> > may serve.
> > 
> > Moreover, we assume that the existing (legacy) ->suspend() and ->resume()
> > callbacks will be used for bus types, device classes and device types that
> > don't implement the new callbacks.  As a result, the patch doesn't introduce
> > any visible functional changes.
> > 
> > It has been compilation tested on x86-64.
> > 
> > Comments welcome.
> 
> Where's the kerneldoc explaining the meaning of the new event codes and 
> new methods?

Not ready yet.

I wanted to let people know what we're working on to avoid duplication of
efforts etc.  Still, if you have comments at this stage, please post them. :-)

Thanks,
Rafael
