From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop vs sonypi (Re: [PATCH 1/2] Add new sony laptop drivers maintainer)
Date: Fri, 9 Feb 2007 20:25:13 +0100
Message-ID: <20070209192513.GA4612@inferi.kami.home>
References: <11709622011964-git-send-email-malattia@linux.it> <1171028098.6387.15.camel@localhost.localdomain> <56393.85.47.20.193.1171029689.squirrel@picard.linux.it> <200702091158.18909.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:43686 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992787AbXBITtj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 14:49:39 -0500
Content-Disposition: inline
In-Reply-To: <200702091158.18909.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stelian Pop <stelian@popies.net>, linux-acpi@vger.kernel.org

On Fri, Feb 09, 2007 at 11:58:18AM -0500, Len Brown wrote:
> On Friday 09 February 2007 09:01, Mattia Dongili wrote:
[...]
> 
> sonypi is an interesting beast, and I do mean beast.
> It pre-dates Linux ACPI support by several years
> and is chock-full of reverse engineered magic numbers.
> 
> It is much more complicated than sony-laptop.
> It has a device file, ioctls, it registers for and handles irqs,
> it tickles bluetooth, the camera, the hotkeys, jog dial --
> and it also registers with ACPI on SONY6001
> and talks to the ACPI EC -- with or without ACPI present.
> 
> Presumably there is some application that talks to those ioctls.

Yep, sonypid spicctrl sjog sonykeyd just to name a few.

> Happily it already registers all the input events with
> the input layer.
> 
> I think one of the major decisions you need to make going forward
> is if it makes sense to maintain the parts of sonypi
> that are reverse engineered AML -- rather than simply
> running in ACPI mode and invoking the AML in the BIOS.

My secret plan was to try to write an ACPI only version of the driver,
so I started seriously reading acpi spec, dissecting DSDT, etc. But I
need some time and possibly help and trial and error.
I'm lucky though, there's some code already in place that does that.

> To be effective at this, you need a machine on hand that
> actually runs the sonypi features.  Lacking that, you need
> active testers and a copy of their acpidump.

Fortunately I own a type2 and a couple of type3 laptops but none of
which has a motion eye camera.
And one of the type3 has problem with sonypi so this is a good starting
point :)

> Personally, I think that invoking machine specific AML
> has its risks, but invoking C-ized machine specific AML
> sucked into a platform specific driver borders on the insane.
> (but Linux didn't have ACPI in 2000, so maybe "determined"
> would be a more appropriate word:-)
> 
> Stelian,
> I think if you can list what you know actually works on what models,
> and what may not work, and what you think about the code needs to
> be changed, that would help Mattia enormously.
> 
> I suggest that the goal might be to have a single consolidated
> sony-laptop driver.  Ie. port the working features one by one
> from sonypi into sony-laptop, and when sony-laptop can do everything
> that sonypi can do (though maybe not with the same ioctl interface etc)
> the schedule sonypi for deletion.  But in the mean time, on the
> assumption the people actually use sonypi to make their vaio's
> dance in useful ways, I would leave it alone for their benefit.
> 
> Or, it may be possible to make a gradual transition --
> this would spread the migration pain over a longer period,
> but would also spread the testing over a longer period
> and probably end up with a better driver in the end.
> You'd have to convince both drivers to load at the same
> time and to not conflict.  Maybe some shared state could
> tell them which features are handled by which, so you could
> test if the new driver is working by flipping some load-time
> bits...  I don't know if this is possible or not -- depends on
> how the features and the models interact with each other.

Probably I could start moving functionalities to sony-laptop and expose
functions so that sonypi will use those instead of its own (kind of a
mix of your 2 suggestions). Modprobe will handle loading of both when
needed.
Backlight control is already one of the features that could be moved
away from sonypi.

At one point sonypi could just implement the ioctls and device file
needed for backward compatibility.
But I need to start playing seriously with sonypi's code before getting
a clear idea if this is really doable or not.

Stelian: thoughts?
I remember an (very?) old discussion where you've been asked to
implement sonypi using acpi functions and the answer was something like
"if acpi will allow that..."

> In any case, I think it would make sense to cook up a transition plan
> and to let the users know what you are thinking before you do it.
> If you don't have folks testing it on the models you don't have
> then you'll be unable to make progress.
> 
> > One question though: which subsystem should sonypi patches flow through?
> 
> In the interest of making ACPI use in the platform specific drivers
> sane and uniform, I'll be happy to be the conduit to upstream
> to clean this up.  In particular, I'd really like to see the
> reverse engineered AML implemented as C IO reads and writes go away.

Ok, thanks.
-- 
mattia
:wq!
