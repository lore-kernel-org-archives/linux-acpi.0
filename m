From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Tue, 28 Mar 2017 15:23:42 +0200
Message-ID: <CACRpkdb22Bofjk1dXCwyi_cWjmw6C1DgQ-NwEPcuR8cti63OPw@mail.gmail.com>
References: <20170324100847.25434-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36911 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbdC1NXw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 09:23:52 -0400
Received: by mail-it0-f47.google.com with SMTP id 190so18146670itm.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Mar 2017 06:23:44 -0700 (PDT)
In-Reply-To: <20170324100847.25434-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Mar 24, 2017 at 11:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:

> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the lid,
> requiring the powerbutton to be pressed after opening the lid to wakeup.
>
> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
> the interrupts are generated anyway on those lines on lid switch changes,
> but they are treated by the IRQ subsystem as spurious while suspended if
> not marked as wakeup IRQs.
>
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Changes in v2:
> -Improve commit msg
> -Add Mika's Acked-by
> Changes in v3:
> -Use irqd_is_wakeup_set rather then tracking this ourselves

This looks like it should be applied for fixes and tagged for stable.

Patch applied.

Yours,
Linus Walleij
