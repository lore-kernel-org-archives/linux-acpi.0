From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device
 properties interface
Date: Tue, 7 Oct 2014 15:37:04 +0200
Message-ID: <CACRpkdbehhsDxikCV1bJjBm581MCcu2DRSmiQQXHG09EmjLNBQ@mail.gmail.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
	<2809308.3y5s7TV5Ip@wuerfel>
	<D04730D8.A9DB0%dvhart@linux.intel.com>
	<6744174.JquHLt80n3@wuerfel>
	<20140926032131.GC40523@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:44736 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaJGNhF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2014 09:37:05 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so4683351igb.13
        for <linux-acpi@vger.kernel.org>; Tue, 07 Oct 2014 06:37:05 -0700 (PDT)
In-Reply-To: <20140926032131.GC40523@vmdeb7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <Len.Brown@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <david.woodhouse@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Aaron Lu <aaron.lu@intel.com>

On Fri, Sep 26, 2014 at 5:21 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Wed, Sep 24, 2014 at 11:12:36AM +0200, Arnd Bergmann wrote:

> So as Mika has pointed out, LEDs aren't the only ones affected. Several drivers
> will need to walk through non-device child nodes, and it seems to me that having
> a firmware-independent mechanism to do so benefits the drivers by both making
> them smaller and by increasing the reusability of new drivers and drivers
> updated to use the new API across platforms.

In a recent round of reviews, for the OF case, that led to drivers
which used device_initcall() without being a module, getting a match
and handle to the parent device, and then walking over the nodes
and instantiating child objects (Linux devices usually) in the process.

It was done as a response to the remark from Rob Herring that
we were modeling things in the device tree as devices when they
really weren't, we were just doing it that way because it fits the
Linux device model and it's easier.

So we have that case too.

The question is if it's anything close to generalizable.

> Grant, Linus W? Thoughts?

I'm uncertain on the whole subject, I called on the others
because of that...

For a while I had Andy Schevenko patch the GPIO and
SFI core too, but it timed out due to no response from Len
Brown. (Maybe I should just merge that stuff!) Do you (Intel) also
want to unify the Medfield SFI thing into this or have you
given up on it?

Yours,
Linus Walleij
