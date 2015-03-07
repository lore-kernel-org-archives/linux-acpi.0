From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Sat, 7 Mar 2015 23:13:05 +0100
Message-ID: <CACRpkdbG7Zc=gUG=L6RtJ543bwxL-hO-0e=CRYtsBkxzPUU3MQ@mail.gmail.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
	<CAAVeFuJUxad0dJ9vK1DaDJPDLM+rc5b77=PgcJT5+Bv1=iWGxg@mail.gmail.com>
	<CACRpkdZzCX0O1wX=W5RbjLcqOF_R3HMTT1w59oFu=JfPauLNuw@mail.gmail.com>
	<4078818.ecVtLF3hjd@vostro.rjw.lan>
	<CAAVeFuJjMDfz7TZexkYnYrCGkAmRwubs32UhSPO-4qZWbMJjuQ@mail.gmail.com>
	<20150224203459.GC13094@psi-dev26.jf.intel.com>
	<CAAVeFuKhD2VBf3EOCjHqJK5CLx4qC8Quire2My9nMqboZzSNZQ@mail.gmail.com>
	<20150225182502.GA7586@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37284 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbCGWNG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Mar 2015 17:13:06 -0500
Received: by obcwp4 with SMTP id wp4so20203443obc.4
        for <linux-acpi@vger.kernel.org>; Sat, 07 Mar 2015 14:13:05 -0800 (PST)
In-Reply-To: <20150225182502.GA7586@psi-dev26.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Feb 25, 2015 at 7:25 PM, David Cohen
<david.a.cohen@linux.intel.com> wrote:

> In my case [1] I need 2 "virtual devices" (and more in future) to be
> part of an USB OTG port control. I call it virtual because they are too
> simple components connected to no bus and controlled by GPIOs:
> - a fixed regulator controlled by GPIO
> - a generic mux controlled by GPIO
>
> I'd need to request official ACPI HID for them in order to make them
> self-sufficient.
>
> I can go ahead with this approach, but we have many examples of drivers
> on upstream that are platform driver expecting to receive gpio via
> platform data (e.g. extcon-gpio). The ACPI table of some products on
> market were defined following this concept and won't change anymore.

So it's not just going to be GPIOs I take it?

There is going to be regulator forwarding, clock forwarding, pin control
forwarding, IRQ forwarding and DMA channel forwarding etc at the end
of the day?

I think it's strange that we see this so much, is the real problem that
ACPI and the kernel have different ideas of what constitutes a device?
And how come the DT seems to be a much better fit and not experience
this? Because we haven't had to deal with deployed device trees with
resources (GPIOs, regulators, etc) bound to some complex MFD device?

Yours,
Linus Walleij
