From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Fri, 30 Jan 2015 15:48:30 +0100
Message-ID: <CACRpkdZWEq_6eNf_rj2rje0KzAKQZ7DeB6L5PW-nacE6=rzmEQ@mail.gmail.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
	<4078818.ecVtLF3hjd@vostro.rjw.lan>
	<CACRpkdZpUU71suzt9JhiBZez2VuJ6-Zm3D1uvmn71bjdn=oU_A@mail.gmail.com>
	<4006695.qV8Mor20ru@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <4006695.qV8Mor20ru@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 22, 2015 at 5:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, January 22, 2015 09:17:38 AM Linus Walleij wrote:

>> If the kernel anyway has to supply some kind of workaround for
>> the issue, it is more a question of where to place it. Whether it does
>> so by patching the ACPI tables or by detecting a bad ACPI thing
>> and working around it at runtime in a certain driver doesn't really
>> matter, does it?
>
> It needs to know what to patch and how so the result is still consistent.
>
> How do you think the kernel is going to figure that out?

Isn't every DSDT (etc) unique? So you could detect one by making
a checksum of the binary or something.

And then you'd know that the table with this checksum needs
patching?

>> They are both in-kernel ACPI fixes, just that one
>> of the mechanisms is generic.
>
> I'm not following you here, sorry.

As per above? Fix the firmware table, not work around the
fact that it is buggy.

>> I don't understand why this obsession with userspace having
>> to do the ACPI table patching - if kernels should "just work" then
>> put this stuff behind Kconfig and have it in the kernel.
>
> This is not an obsession and your suggestion here leads to having custom
> per-board kernels which is not supportable in the long term.

Not at all. The other suggestion leads to having custom per-board
fixes in every driver for which broken ACPI descriptions exists,
which is just as bad, isn't it? Instead of collecting the problem
in one place (patch any broken ACPI table) it is distrubuted across
N drivers, where each and every one has to detect that it is
being malinformed by a broken ACPI table.

Yours,
Linus Walleij
