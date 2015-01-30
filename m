From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Fri, 30 Jan 2015 17:17:05 +0100
Message-ID: <2116821.DVmvasqCz1@vostro.rjw.lan>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com> <4006695.qV8Mor20ru@vostro.rjw.lan> <CACRpkdZWEq_6eNf_rj2rje0KzAKQZ7DeB6L5PW-nacE6=rzmEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56587 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751213AbbA3PyT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jan 2015 10:54:19 -0500
In-Reply-To: <CACRpkdZWEq_6eNf_rj2rje0KzAKQZ7DeB6L5PW-nacE6=rzmEQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, January 30, 2015 03:48:30 PM Linus Walleij wrote:
> On Thu, Jan 22, 2015 at 5:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, January 22, 2015 09:17:38 AM Linus Walleij wrote:
> 
> >> If the kernel anyway has to supply some kind of workaround for
> >> the issue, it is more a question of where to place it. Whether it does
> >> so by patching the ACPI tables or by detecting a bad ACPI thing
> >> and working around it at runtime in a certain driver doesn't really
> >> matter, does it?
> >
> > It needs to know what to patch and how so the result is still consistent.
> >
> > How do you think the kernel is going to figure that out?
> 
> Isn't every DSDT (etc) unique?

Formally, it doesn't have to be.

And it doesn't have to be a DSDT, it may be an SSDT too or even a plain
table that's buggy.

> So you could detect one by making a checksum of the binary or something.
> 
> And then you'd know that the table with this checksum needs patching?

At a single table level it is generally difficult to say whether or not
things are going to work.

What needs to work is the namespace which is built from all of the tables
provided combined.  So the namespace needs to be populated first and then
fixes applied on top of that (presumably by deleting, adding or replacing
objects).

Now, in theory, you *may* be able to figure out that combination of tables
A produces namespace B which then will require fix X if the system is Y,
but quite frankly I wouldn't count on that.

Moreover, fixups (or "patches" as I called them, but that wasn't exactly
correct) need to be provided in the form of AML definition blocks to apply on
top of an already populated namespace and if you want to use a binary kernel image,
you can't really afford putting all that stuff for all systems it can possibly
run on into it.  This means that distros need to be able to combine a fixup for
the ACPI tables with the binary kernel and install the result into the system's
boot medium (whatever it is).  Also it should be possible to update the fixup
and the kernel image separately if necessary.

Now from the kernel's perspective that raises the question: "What if the
ACPI tables fixup provided by the distro is not sufficient?"

That needs to be addressed somehow in the code.

> >> They are both in-kernel ACPI fixes, just that one
> >> of the mechanisms is generic.
> >
> > I'm not following you here, sorry.
> 
> As per above? Fix the firmware table, not work around the
> fact that it is buggy.
> 
> >> I don't understand why this obsession with userspace having
> >> to do the ACPI table patching - if kernels should "just work" then
> >> put this stuff behind Kconfig and have it in the kernel.
> >
> > This is not an obsession and your suggestion here leads to having custom
> > per-board kernels which is not supportable in the long term.
> 
> Not at all. The other suggestion leads to having custom per-board
> fixes in every driver for which broken ACPI descriptions exists,

So I'm not arguing for that.

> which is just as bad, isn't it? Instead of collecting the problem
> in one place (patch any broken ACPI table) it is distrubuted across
> N drivers, where each and every one has to detect that it is
> being malinformed by a broken ACPI table.

In the general-purpose binary kernel image distribution model drivers generally
need to treat information provided by the platform firmware, be it ACPI or a DT
or what-not, as untrusted input that needs to be validated if possible.  That
is not always possible and in those cases we have no choice but to try to use
that information, fingers crossed.  Sometimes we can validate it, though, and
then we should and do something if it turns out to be invalid.

Overall, my view on that is that (1) there needs to be a way for a distro to
provide an ACPI tables fixup for the kernel to apply on top of the already
populated ACPI namespace on a given system and (2) drivers need to be careful
about using firmware data and possibly be able to recover from errors in there.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
