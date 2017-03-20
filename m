From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Mon, 20 Mar 2017 12:17:59 +0200
Message-ID: <20170320101759.GI2957@lahna.fi.intel.com>
References: <20170318233524.5047-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16555 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbdCTKSE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 06:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20170318233524.5047-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org

On Sun, Mar 19, 2017 at 12:35:24AM +0100, Hans de Goede wrote:
> On baytrail / cherrytrail systems with a LID switch the LID switch is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the lid,
> requiring the powerbutton to be pressed after opening the lid to wakeup.
> 
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

After you have addressed comments from Andy you can add my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
