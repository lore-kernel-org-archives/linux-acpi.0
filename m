From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a backlight issue
Date: Thu, 6 Aug 2009 16:50:32 -0300
Message-ID: <20090806195032.GF15867@khazad-dum.debian.net>
References: <1245895749.7266.70.camel@localhost.localdomain>
 <200908051450.27970.trenn@suse.de>
 <20090806125552.GB15867@khazad-dum.debian.net>
 <200908061538.39238.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60615 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756084AbZHFTug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 15:50:36 -0400
Content-Disposition: inline
In-Reply-To: <200908061538.39238.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: yakui_zhao <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thu, 06 Aug 2009, Thomas Renninger wrote:
> On Thursday 06 August 2009 14:55:52 Henrique de Moraes Holschuh wrote:
> > On Wed, 05 Aug 2009, Thomas Renninger wrote:
> > > If in KMS drivers backlight switching method is implemented
> > > and can register for the generic backlight driver, it should always
> > > be
> > > disabled by default. Instead, KMS drivers should export a simple
> > > "backlight_enable" file somewhere in sysfs. If userspace doesn't
> > > find a sysfs backlight interface, it can do:
> > > echo 1 >/sys/path_to_graphics_card/backlight_enable
> > > and a backlight sysfs interface should pop up on success.
> > 
> > IMO, we already have an in-kernel selector of the backlight control
> > method for mutually-exclusive backlight control strategies.
> You mean the ACPI vs native driver detection?

Yes. 

> > We should use that, and if it is complete/good enough to add the KMS
> > scenario, improve it.
> You mean if it is *not* complete/good enough?

Yes, sorry about that.

> KMS popping in as a third kernel backlight provider makes things really
> complicated for the kernel to choose the right thing.
> Getting this prio:
> 1. generic ---ACPI
> 2. platform---platform drivers
> 3. legacy-----i915
> solved in kernel automatically you need something like Rui/Yakui 
> suggested:
>   - Let KMS register first as I expect it will always initialize first
>   - Let ACPI or platform driver unregister KMS backlight interface
>     and take over
> You never know when userspace plans to load the native drivers.

Or unload them, which should be fully supported...

> This complexity for a normally not needed fallback (ACPI or native 
> drivers should be available) is complicated and error-prone.

More error-prone than OpRegion and the SMM mess from hell on most laptops?

> This complexity should really be put to userspace where it's easy 
> (three lines in bash) to solve, like I suggested above.
> 
> Maybe someone has another, easier idea to perfectly solve this 
> automatically in kernel, I do not see it.

I do, but I don't know if it is a better solution.  In its "purest" form it
would be:  Teach the backlight core to have backlight domains and add a
backlight domain controler there.

You get KMS, platform drivers taking care of the main LVDS screen, and ACPI
on a single domain, let the kernel select ACPI by default or a different one
by command line, and let userspace change it through sysfs.

Drivers need some change to actually just register their backlight hooks
(plus hooks for "activate driver" and "deactivate driver", which are new)
with the backlight domain controller instead of a full backlight
device/class.  Other backlight drivers just register their own device using
the existing API.

Now, is that a better solution? I don't know.  But it is more user-friendly
than what we have now, and more powerful.  It is also more complex.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
