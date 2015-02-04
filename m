From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Wed, 4 Feb 2015 10:51:27 +0100
Message-ID: <CACRpkdbpJXHih0-Yhpi=AjvVjxZwEAhqe_iBWbd=5Cjz+sQZxQ@mail.gmail.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
	<4006695.qV8Mor20ru@vostro.rjw.lan>
	<CACRpkdZWEq_6eNf_rj2rje0KzAKQZ7DeB6L5PW-nacE6=rzmEQ@mail.gmail.com>
	<2116821.DVmvasqCz1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:54929 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933616AbbBDJv2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 04:51:28 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so450191oig.9
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2015 01:51:27 -0800 (PST)
In-Reply-To: <2116821.DVmvasqCz1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Jan 30, 2015 at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, January 30, 2015 03:48:30 PM Linus Walleij wrote:

>> So you could detect one by making a checksum of the binary or something.
>>
>> And then you'd know that the table with this checksum needs patching?
>
> At a single table level it is generally difficult to say whether or not
> things are going to work.
>
> What needs to work is the namespace which is built from all of the tables
> provided combined.  So the namespace needs to be populated first and then
> fixes applied on top of that (presumably by deleting, adding or replacing
> objects).
>
> Now, in theory, you *may* be able to figure out that combination of tables
> A produces namespace B which then will require fix X if the system is Y,
> but quite frankly I wouldn't count on that.
>
> Moreover, fixups (or "patches" as I called them, but that wasn't exactly
> correct) need to be provided in the form of AML definition blocks to apply on
> top of an already populated namespace and if you want to use a binary kernel image,
> you can't really afford putting all that stuff for all systems it can possibly
> run on into it.  This means that distros need to be able to combine a fixup for
> the ACPI tables with the binary kernel and install the result into the system's
> boot medium (whatever it is).  Also it should be possible to update the fixup
> and the kernel image separately if necessary.
>
> Now from the kernel's perspective that raises the question: "What if the
> ACPI tables fixup provided by the distro is not sufficient?"
>
> That needs to be addressed somehow in the code.

Yeah I guess I'm convinced that we need to handle this particular
weirdness in the gpio-acpi code... if it can be contained there as
expressed by Alexandre.

Yours,
Linus Walleij
