From: Thomas Renninger <trenn@suse.de>
Subject: Re: a backlight issue
Date: Fri, 7 Aug 2009 10:25:30 +0200
Message-ID: <200908071025.31793.trenn@suse.de>
References: <1245895749.7266.70.camel@localhost.localdomain> <200908061538.39238.trenn@suse.de> <20090806195032.GF15867@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47880 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314AbZHGIZe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Aug 2009 04:25:34 -0400
In-Reply-To: <20090806195032.GF15867@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: yakui_zhao <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thursday 06 August 2009 21:50:32 Henrique de Moraes Holschuh wrote:
> On Thu, 06 Aug 2009, Thomas Renninger wrote:
> > On Thursday 06 August 2009 14:55:52 Henrique de Moraes Holschuh wrote:
> > > On Wed, 05 Aug 2009, Thomas Renninger wrote:
> > > > If in KMS drivers backlight switching method is implemented
> > > > and can register for the generic backlight driver, it should always
> > > > be
> > > > disabled by default. Instead, KMS drivers should export a simple
> > > > "backlight_enable" file somewhere in sysfs. If userspace doesn't
> > > > find a sysfs backlight interface, it can do:
> > > > echo 1 >/sys/path_to_graphics_card/backlight_enable
> > > > and a backlight sysfs interface should pop up on success.
> > > 
> > > IMO, we already have an in-kernel selector of the backlight control
> > > method for mutually-exclusive backlight control strategies.
> > You mean the ACPI vs native driver detection?
> 
> Yes. 
> 
> > > We should use that, and if it is complete/good enough to add the KMS
> > > scenario, improve it.
> > You mean if it is *not* complete/good enough?
> 
> Yes, sorry about that.
> 
> > KMS popping in as a third kernel backlight provider makes things really
> > complicated for the kernel to choose the right thing.
> > Getting this prio:
> > 1. generic ---ACPI
> > 2. platform---platform drivers
> > 3. legacy-----i915
> > solved in kernel automatically you need something like Rui/Yakui 
> > suggested:
> >   - Let KMS register first as I expect it will always initialize first
> >   - Let ACPI or platform driver unregister KMS backlight interface
> >     and take over
> > You never know when userspace plans to load the native drivers.
> 
> Or unload them, which should be fully supported...
> 
> > This complexity for a normally not needed fallback (ACPI or native 
> > drivers should be available) is complicated and error-prone.
> 
> More error-prone than OpRegion and the SMM mess from hell on most laptops?
> 
> > This complexity should really be put to userspace where it's easy 
> > (three lines in bash) to solve, like I suggested above.
> > 
> > Maybe someone has another, easier idea to perfectly solve this 
> > automatically in kernel, I do not see it.
> 
> I do, but I don't know if it is a better solution.  In its "purest" form it
> would be:  Teach the backlight core to have backlight domains and add a
> backlight domain controler there.
> 
> You get KMS, platform drivers taking care of the main LVDS screen, and ACPI
> on a single domain, let the kernel select ACPI by default or a different one
> by command line, and let userspace change it through sysfs.
> 
> Drivers need some change to actually just register their backlight hooks
> (plus hooks for "activate driver" and "deactivate driver", which are new)
> with the backlight domain controller instead of a full backlight
> device/class.  Other backlight drivers just register their own device using
> the existing API.
> 
> Now, is that a better solution? I don't know.
I don't think so. It sounds like quite some code/complexity that needs to be
added for no functional enhancement.
This is all about solving the complexity in kernel or in userspace.
As it is *much* easier in userspace, I'd go that way.

> But it is more user-friendly than what we have now, and more powerful.
Why is it more powerful?
It's about solving the problem in kernel or in userspace, while userspace
might have additional info for choosing the right thing.
> It is also more complex.
Which is a very strong argument.

   Thomas

BTW: How would several graphics cards/monitors and switching between them
be handled currently or in future?
I once had such a machine and IIRC you ended up in double steps using generic
ACPI backlight funcs on both graphics cards. When I saw the two active ACPI
graphics devices I was happy that this was the only related defect and
silently ignored it :)
