From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Tue, 12 Dec 2006 15:00:33 -0800
Message-ID: <20061212150033.e3c7612f.kristen.c.accardi@intel.com>
References: <20061204224037.713257809@localhost.localdomain>
	<20061211120508.2f2704ac.kristen.c.accardi@intel.com>
	<20061212221504.GA4104@datenfreihafen.org>
	<200612121431.11919.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26414 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964787AbWLLXFw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Dec 2006 18:05:52 -0500
In-Reply-To: <200612121431.11919.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Holger Macht <hmacht@suse.de>, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>, Kay Sievers <kay.sievers@vrfy.org>

On Tue, 12 Dec 2006 14:31:10 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Tuesday, December 12, 2006 2:15 pm, Stefan Schmidt wrote:
> > Hello.
> >
> > On Mon, 2006-12-11 at 12:05, Kristen Carlson Accardi wrote:
> > > On Sat, 9 Dec 2006 12:59:58 +0100
> > >
> > > Holger Macht <hmacht@suse.de> wrote:
> > > > Well, I like to have them ;-)
> > >
> > > Ok - how is this?
> > >
> > > Send a uevent to indicate a device change whenever we dock or
> > > undock, so that userspace may now check the dock status via
> > > sysfs.
> >
> > I would like to have two different events for dock and undock.
> >
> > This way the userspace listener don't need to check the status file
> > in sysfs to know if there was a dock or undock after getting the
> > event.
> >
> > Anyway the status file is still usefull for programs don't react on
> > the events, but like to know if the laptop is docked before starting
> > for example.
> 
> FWIW, Kay and Neil recently went back and forth regarding what sorts of 
> events to generate for MD online/offline events.  In concept md 
> online/offline and dock/undock seem similar enough that the 'change' 
> events Kay requested for md probably make sense in the dock/undock 
> context as well, but I've Cc'd him just in case.
> 
> Jesse
> 

I did have different dock/undock events a few months ago - but
after some discussion we scrapped them because Kay wants to avoid driver
specific events.  The "change" event is the only thing that makes sense,
given the set of uevents available right now, and userspace should be 
able to handle checking a file to get driver specific details (i.e. dock 
and undock status).  If you have a specific reason why this won't work,
let me know.
