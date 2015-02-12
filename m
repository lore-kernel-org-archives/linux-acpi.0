From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Thu, 12 Feb 2015 14:38:19 +0200
Message-ID: <20150212123819.GB18860@kuha.fi.intel.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
 <4006695.qV8Mor20ru@vostro.rjw.lan>
 <CACRpkdZWEq_6eNf_rj2rje0KzAKQZ7DeB6L5PW-nacE6=rzmEQ@mail.gmail.com>
 <2116821.DVmvasqCz1@vostro.rjw.lan>
 <CACRpkdbpJXHih0-Yhpi=AjvVjxZwEAhqe_iBWbd=5Cjz+sQZxQ@mail.gmail.com>
 <20150204141151.GB18189@kuha.fi.intel.com>
 <CAAVeFu+JHMf__s0hfCJq31kZP-mp02bbzVywq+eZ9JVyP9boSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10729 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbbBLMiZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Feb 2015 07:38:25 -0500
Content-Disposition: inline
In-Reply-To: <CAAVeFu+JHMf__s0hfCJq31kZP-mp02bbzVywq+eZ9JVyP9boSw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Feb 10, 2015 at 06:44:34PM +0900, Alexandre Courbot wrote:
> On Wed, Feb 4, 2015 at 11:11 PM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Wed, Feb 04, 2015 at 10:51:27AM +0100, Linus Walleij wrote:
> >> On Fri, Jan 30, 2015 at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, January 30, 2015 03:48:30 PM Linus Walleij wrote:
> >>
> >> >> So you could detect one by making a checksum of the binary or something.
> >> >>
> >> >> And then you'd know that the table with this checksum needs patching?
> >> >
> >> > At a single table level it is generally difficult to say whether or not
> >> > things are going to work.
> >> >
> >> > What needs to work is the namespace which is built from all of the tables
> >> > provided combined.  So the namespace needs to be populated first and then
> >> > fixes applied on top of that (presumably by deleting, adding or replacing
> >> > objects).
> >> >
> >> > Now, in theory, you *may* be able to figure out that combination of tables
> >> > A produces namespace B which then will require fix X if the system is Y,
> >> > but quite frankly I wouldn't count on that.
> >> >
> >> > Moreover, fixups (or "patches" as I called them, but that wasn't exactly
> >> > correct) need to be provided in the form of AML definition blocks to apply on
> >> > top of an already populated namespace and if you want to use a binary kernel image,
> >> > you can't really afford putting all that stuff for all systems it can possibly
> >> > run on into it.  This means that distros need to be able to combine a fixup for
> >> > the ACPI tables with the binary kernel and install the result into the system's
> >> > boot medium (whatever it is).  Also it should be possible to update the fixup
> >> > and the kernel image separately if necessary.
> >> >
> >> > Now from the kernel's perspective that raises the question: "What if the
> >> > ACPI tables fixup provided by the distro is not sufficient?"
> >> >
> >> > That needs to be addressed somehow in the code.
> >>
> >> Yeah I guess I'm convinced that we need to handle this particular
> >> weirdness in the gpio-acpi code... if it can be contained there as
> >> expressed by Alexandre.
> >
> > I'm still fine if we want to confine this "gpio forwarding" to acpi
> > if you guys want it, but I was looking at the Sound SoC drivers and I
> > realised that we do have places which pass gpio descriptors to other
> > devices in platform data. And these of course aren't always used on
> > acpi platforms. By greping gpio_desc I saw at least these files are
> > passing it in platform data structures:
> >
> > include/sound/soc.h
> > include/linux/leds.h
> > include/linux/usb/usb_phy_generic.h
> >
> > There are probable others but I checked those. And of course now there
> > is nothing preventing people from adding more of them.
> 
> For sound/soc.h, the member is indeed public but I don't see it being
> used to pass descriptors around between drivers.
> 
> For linux/leds.h, I think this is the reason why we introduced
> devm_get_gpiod_from_child()
> 
> These looks more like a bad usage of GPIO descriptors, but AFAICT they
> can be fixed by fixing the drivers and, by all means, this is where we
> should do it.
> 
> This is a different situation from yours where we are trying to deal
> with broken firmware and need to resort to tricks at one point or the
> other.
> 
> Or am I missing your point?

Well, in this case the motivation would be to make it possible to live
without platform data with these drivers, but in the end the situation
would be exactly the same. We need to give a gpio descriptor to
some other device in a driver. So the goal would be that in the actual
consumer driver of the gpio we could request it always in one way,
ideally always with gpiod_get() call.

But if there is no real need in other places for this thing, then
let's forget about it.


Thanks,

-- 
heikki
