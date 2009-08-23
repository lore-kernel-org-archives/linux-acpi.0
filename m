From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a backlight issue
Date: Sun, 23 Aug 2009 09:41:19 -0300
Message-ID: <20090823124119.GA28731@khazad-dum.debian.net>
References: <1245895749.7266.70.camel@localhost.localdomain>
 <200908061538.39238.trenn@suse.de>
 <20090806195032.GF15867@khazad-dum.debian.net>
 <200908071025.31793.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43227 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756002AbZHWMlX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Aug 2009 08:41:23 -0400
Content-Disposition: inline
In-Reply-To: <200908071025.31793.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: yakui_zhao <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Fri, 07 Aug 2009, Thomas Renninger wrote:
> > I do, but I don't know if it is a better solution.  In its "purest" form it
> > would be:  Teach the backlight core to have backlight domains and add a
> > backlight domain controler there.
> > 
> > You get KMS, platform drivers taking care of the main LVDS screen, and ACPI
> > on a single domain, let the kernel select ACPI by default or a different one
> > by command line, and let userspace change it through sysfs.
> > 
> > Drivers need some change to actually just register their backlight hooks
> > (plus hooks for "activate driver" and "deactivate driver", which are new)
> > with the backlight domain controller instead of a full backlight
> > device/class.  Other backlight drivers just register their own device using
> > the existing API.
> > 
> > Now, is that a better solution? I don't know.
> I don't think so. It sounds like quite some code/complexity that needs to be
> added for no functional enhancement.
> This is all about solving the complexity in kernel or in userspace.
> As it is *much* easier in userspace, I'd go that way.

I might even agree with you, but I object that any interface that publishes
broken controls to userspace is good.  We should only expose stuff that
works, if KMS is busted in a given platform, no KMS controls should be
exposed, etc.  Publishing two controls that "work" but fight each other is
worse.

Besides, we *have* the notion of a main screen on almost every platform, and
exposing the main screen backlight control in a single way (and allowing the
user to select the backlight control strategy at runtime, after we did our
best to select the proper one by default) is much more user-fiendly and
neat.

What we have currently just barely cuts it, and wouldn't handle secondary
displays of any sort.

> > But it is more user-friendly than what we have now, and more powerful.
> Why is it more powerful?

See above.  One can override the control strategy at runtime to select any
backlight driver that could work (this assumes backlight drivers refuse to
install when the support they need isn't there, which is a safe assumption
as that's exactly what we try to do already).

> It's about solving the problem in kernel or in userspace, while userspace
> might have additional info for choosing the right thing.

It can still choose.  But now almost every userspace app has a single
control point.  Just like we do in the API used for kernel drivers, we
should aim for userspace ABIs that are easy to use right.

> > It is also more complex.
> Which is a very strong argument.

Not that strong, the added complexity is NOT too high, as backlight
_already_ operates based on context that is passed around as a pointer, and
on hooks that are inside this context structure.  Also, the propler layering
already exists.

I'd say it is a matter of a few hundred lines of code in the backlight
class, and the change of one function call on the backend drivers, to
register the backlight class on the proper domain.

> BTW: How would several graphics cards/monitors and switching between them
> be handled currently or in future?

The above "backlight domain controller" could take care of it with very
small changes to the design.

> I once had such a machine and IIRC you ended up in double steps using generic
> ACPI backlight funcs on both graphics cards. When I saw the two active ACPI
> graphics devices I was happy that this was the only related defect and
> silently ignored it :)

I do expect we will have some headaches on the firmware side of things, yes
:-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
