From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Sun, 19 Mar 2017 17:25:16 +0200
Message-ID: <1489937116.19767.92.camel@linux.intel.com>
References: <20170318233524.5047-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:30309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbdCSPZb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Mar 2017 11:25:31 -0400
In-Reply-To: <20170318233524.5047-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org

On Sun, 2017-03-19 at 00:35 +0100, Hans de Goede wrote:
> On baytrail / cherrytrail systems with a LID switch the LID switch is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the
> lid,
> requiring the powerbutton to be pressed after opening the lid to
> wakeup.
> 
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.

I perhaps give up on my nits against Capital Letters :-), though for
consistency, please, use Baytrail, Cherry Trail.
 
> +		if (event->irq_wake_enabled)

You may use irqd_is_wakeup_set() instead. IRQ framework keeps this state
already.

> +			disable_irq_wake(event->irq);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
