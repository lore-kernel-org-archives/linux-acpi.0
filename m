From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [Update 4][PATCH 2/7] ACPI / scan: Introduce common code for
 ACPI-based device hotplug
Date: Mon, 4 Mar 2013 14:10:23 +0100
Message-ID: <20130304131023.GA4561@dhcp-192-168-178-175.profitbricks.localdomain>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan>
 <1478394.ryVNRuTre2@vostro.rjw.lan>
 <1361815672.12845.71.camel@misato.fc.hp.com>
 <18666371.hyHAvqrdQ6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:58295 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab3CDNK2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Mar 2013 08:10:28 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so2327373bkc.6
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2013 05:10:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <18666371.hyHAvqrdQ6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>

Hi,

On Tue, Feb 26, 2013 at 12:39:50AM +0100, Rafael J. Wysocki wrote:
> On Monday, February 25, 2013 11:07:52 AM Toshi Kani wrote:
> > On Sat, 2013-02-23 at 22:38 +0000, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Multiple drivers handling hotplug-capable ACPI device nodes install
> > > notify handlers covering the same types of events in a very similar
> > > way.  Moreover, those handlers are installed in separate namespace
> > > walks, although that really should be done during namespace scans
> > > carried out by acpi_bus_scan().  This leads to substantial code
> > > duplication, unnecessary overhead and behavior that is hard to
> > > follow.
> > > 
> > > For this reason, introduce common code in drivers/acpi/scan.c for
> > > handling hotplug-related notification and carrying out device
> > > insertion and eject operations in a generic fashion, such that it
> > > may be used by all of the relevant drivers in the future.  To cover
> > > the existing differences between those drivers introduce struct
> > > acpi_hotplug_profile for representing collections of hotplug
> > > settings associated with different ACPI scan handlers that can be
> > > used by the drivers to make the common code reflect their current
> > > behavior.
[...]
> That's correct, but I don't know what the user space expectations are
> currently.
> 
> > So, I'd suggest the following changes.
> >  - Remove the "uevents" attribute.  KOBJ_ONLINE/OFFLINE are not used for
> > ACPI device objects.
> >  - Make the !autoeject case as an exception for now, and emit
> > KOBJ_OFFLINE as a way to request off-lining to user.  This uevent is
> > tied with the !autoeject case.  We can then revisit if this use-case
> > needs to be supported going forward.  If so, we may want to consider a
> > different event type.
> 
> Well, what about avoiding to expose uevents and autoeject for now and
> exposing enabled only?  Drivers would still be able to set the other flags on
> init on init to enforce the backwards-compatible behavior.

Now that we don't define uevents and autoeject in v2 of this series, could you
explain how we get safe ejection from userspace e.g. for memory hot-remove? What
are the other flags drivers can use (on init?) to avoid autoeject and only issue
KOBJ_OFFLINE?

> 
> I agree that it would be sufficient to use one additional flag then, to start
> with, but its meaning would be something like "keep backwards compatibility
> with the old container driver", so perhaps "autoeject" is not a good name.
> 
> What about "user_eject" (that won't be exposed to user space) instead?  Where,
> if set, it would meand "do not autoeject and emit KOBJ_OFFLINE/ONLINE uevents
> like the old container driver did"?

I don't see user_eject in v2. Is it unnecessary for userspace ejection control
or planned for later? Also why shouldn't it be exposed to userpace?

thanks,

- Vasilis
