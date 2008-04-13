From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Sun, 13 Apr 2008 23:39:43 +0200
Message-ID: <200804132339.45280.rjw@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <200804131533.03150.rjw@sisk.pl> <1208120711.6958.52.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37562 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbYDMVjc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2008 17:39:32 -0400
In-Reply-To: <1208120711.6958.52.camel@pasglop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday, 13 of April 2008, Benjamin Herrenschmidt wrote:
> 
> On Sun, 2008-04-13 at 15:33 +0200, Rafael J. Wysocki wrote:
> > + *     The PM core executes @prepare() for all devices before starting to
> > + *     execute suspend callbacks for any of them, so drivers may assume all of
> > + *     the other devices to be present and functional while @prepare() is being
> > + *     executed.  In particular, it is safe to make GFP_KERNEL memory
> > + *     allocations from within @prepare().  However, drivers may NOT assume
> > + *     anything about the availability of the user space at that time and it
> > + *     is not correct to request firmware from within @prepare() (it's too
> > + *     late to do that).  [To work around this limitation, drivers may
> > + *     register suspend and hibernation notifiers that are executed before the
> > + *     freezing of tasks.]
> 
> Can you tell me why you kept that limitation with user space ?
> 
> I don't see the point... On the contrary, prepare() is the pefect place
> to implement handshaking with userspace for drivers that need to do so,
> such as the DRM.

This _comment_ reflects the current situation, which is that we freeze tasks
before a suspend.  When it's no longer necessary to do that, I'll be happy to
change this comment.  For now, however, that's not the case.

Thanks,
Rafael
