From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 22:16:07 +0200
Message-ID: <200804012216.08318.rjw@sisk.pl>
References: <200803292317.50218.rjw@sisk.pl> <1207037741.23143.81.camel@nigel-laptop> <1207038460.10388.214.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48181 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756948AbYDAUQX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Apr 2008 16:16:23 -0400
In-Reply-To: <1207038460.10388.214.camel@pasglop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>

On Tuesday, 1 of April 2008, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2008-04-01 at 19:15 +1100, Nigel Cunningham wrote:
> > > + *   However, drivers may NOT assume anything about the availability of the
> > > + *   user space at that time and it is not correct to request firmware from
> > > + *   within @prepare() (it's too late to do that).
> > 
> > That doesn't sound good. It would be good to be able to get drivers to
> > request firmware early in the process.
> 
> Agreed. Prepare() should still allow request_firmware and full userspace
> communication / helper usage.

This documents the current state which is that we have the freezer and we have
drivers that rely on it.

I can remove the comment, but then someone will invent ->prepare() relying
on the availability of the user space at this point and that won't work.

Thanks,
Rafael
