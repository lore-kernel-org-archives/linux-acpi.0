From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic suspend functionality
Date: Wed, 2 Jun 2010 01:34:46 +0200
Message-ID: <201006020134.46962.rjw@sisk.pl>
References: <1275416390.3778.7.camel@maxim-laptop> <201006020040.22429.rjw@sisk.pl> <1275432410.6733.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39993 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756094Ab0FAXdf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jun 2010 19:33:35 -0400
In-Reply-To: <1275432410.6733.4.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Alan Stern <stern@rowland.harvard.edu>

On Wednesday 02 June 2010, Maxim Levitsky wrote:
> On Wed, 2010-06-02 at 00:40 +0200, Rafael J. Wysocki wrote: 
> > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > On Tue, 2010-06-01 at 23:31 +0200, Rafael J. Wysocki wrote: 
> > > > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > > > Saving platform non-volatile state may be required for suspend to RAM as
> > > > > well as hibernation. Move it to more generic code.
> > > > > 
> > > > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > > > Signed-off-by: Matthew Garrett <maximlevitsky@gmail.com>
> > > > 
> > > > You made a mistake here.
> > > > 
> > > > Also, why are you resending the Matthews patches?  I think Len has seen them
> > > > already.
> > > Yea, a copypaste.
> > > 
> > > (I was told that if one submits modified patch, it adds his
> > > Signed-off-by.)
> > > 
> > > I rebased these on top of 
> > > ACPI / EC / PM: Fix race between EC transactions and system suspend'
> > > 
> > > To be honest, I just want to get some feedback on this.
> > > This was major issue that kept me from using otherwise prefect suspend
> > > to ram.
> > 
> > I think this is a change we should try, but there is a chance it will break
> > some systems.
> I doubt that. BIOSes are tested against windows, and since it has this
> behavior, all systems this patch could break wouldn't work in windows
> ether.

Still, some systems were broken by the saving-restoring NVS over hibernation.

> I was doing all kinds of attempts to fix this bug, and finally I found
> the cause for it.

I know and I'm not objecting to the patches.  I'm only saying we should be
careful with them.

Rafael
