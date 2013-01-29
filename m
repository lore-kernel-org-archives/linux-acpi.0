From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2] gpiolib-acpi: Add ACPI5 event model support to gpio.
Date: Tue, 29 Jan 2013 11:47:36 +0100
Message-ID: <CACRpkdY75vHvsKLR3BHmxmgWj_6gQbA+phiJy+KEHcDsCg55Vw@mail.gmail.com>
References: <1359382990-19353-1-git-send-email-mathias.nyman@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359382990-19353-1-git-send-email-mathias.nyman@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, grant.likely@secretlab.ca, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, tianyu.lan@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 28, 2013 at 3:23 PM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:

> Add ability to handle ACPI events signalled by GPIO interrupts.
>
> ACPI5 platforms can use GPIO signaled ACPI events. These GPIO interrupts are
> handled by ACPI event methods which need to be called from the GPIO
> controller's interrupt handler. acpi_gpio_request_interrupt() finds out which
> gpio pins have acpi event methods and assigns interrupt handlers that calls
> the acpi event methods for those pins.
>
> Partially based on work by Rui Zhang <rui.zhang@intel.com>
>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

OK I am pleased with this, patch applied!

Yours,
Linus Walleij
