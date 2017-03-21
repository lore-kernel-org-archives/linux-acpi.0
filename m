From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Tue, 21 Mar 2017 14:30:23 +0200
Message-ID: <1490099423.19767.124.camel@linux.intel.com>
References: <20170320173221.3397-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756855AbdCUMbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Mar 2017 08:31:05 -0400
In-Reply-To: <20170320173221.3397-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org

On Mon, 2017-03-20 at 18:32 +0100, Hans de Goede wrote:
> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch
> is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the
> lid,
> requiring the powerbutton to be pressed after opening the lid to
> wakeup.
> 
> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
> the interrupts are generated anyway on those lines on lid switch
> changes,
> but they are treated by the IRQ subsystem as spurious while suspended
> if
> not marked as wakeup IRQs.
> 
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

> +	bool irq_wake_enabled;
> 

> +		if (event->irq_wake_enabled)
> 

Same (new) comment as in v1.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
