From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Mon, 24 Aug 2009 20:49:08 +0200
Message-ID: <200908242049.08189.rjw@sisk.pl>
References: <20090819115210.GC12216@srcf.ucam.org> <20090824082722.GA32264@srcf.ucam.org> <1251103572.24336.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52342 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbZHXSsT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2009 14:48:19 -0400
In-Reply-To: <1251103572.24336.8.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>

On Monday 24 August 2009, Shaohua Li wrote:
> On Mon, 2009-08-24 at 16:27 +0800, Matthew Garrett wrote:
> > On Mon, Aug 24, 2009 at 04:21:50PM +0800, Shaohua Li wrote:
> > > On Mon, 2009-08-24 at 16:09 +0800, Matthew Garrett wrote:
> > > > I don't agree - the wakeup GPE will generate a standard notify, and the 
> > > > notification handler has to be at the device or bus layer to handle 
> > > > device-specific requests.
> > > Then we will have duplicate code at each device or bus.
> > 
> > I think that's inevitable, unless the notification infrastructure is 
> > made more fine grained.
> At least we need some check and maybe gpe handling and we need some
> "ifdef ACPI" staff at each device or bus.

Why would we need that?

> There isn't big difference device/bus register a notification handler or
> register a .wakeup_event. And .wakeup_event is more simple in device/bus
> level.

As Matthew said, there is.

To make things clear, we're not going to add .wakeup_event().

Thanks,
Rafael
