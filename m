From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC] ACPI: Add GPIO-signaled event simulator.
Date: Mon, 18 Aug 2014 12:41:13 +0300
Message-ID: <20140818094113.GU2462@lahna.fi.intel.com>
References: <1406217076-17150-1-git-send-email-tomasz.nowicki@linaro.org>
 <CACRpkdZmKJmaTRBpDrzd7+EhPuFeScr6jEHC8+0z6-4knjFqkA@mail.gmail.com>
 <20140812100111.GV1657@lahna.fi.intel.com>
 <53F1C729.7090304@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F1C729.7090304@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 18, 2014 at 11:28:09AM +0200, Tomasz Nowicki wrote:
> On 12.08.2014 12:01, Mika Westerberg wrote:
> >On Fri, Aug 08, 2014 at 02:36:02PM +0200, Linus Walleij wrote:
> >>On Thu, Jul 24, 2014 at 5:51 PM, Tomasz Nowicki
> >><tomasz.nowicki@linaro.org> wrote:
> >>
> >>>GPIO signaled events is quite new thing in Linux kernel.
> >>>AFAIK, there are not many board which can take advantage of it.
> >>>However, GPIO events are very useful feature during work on ACPI
> >>>subsystems.
> >>
> >>Overall this seems like a pretty nice debug feature.
> >>
> >>>This commit emulates GPIO h/w behaviour and consists on read/write
> >>>operation to debugfs file. GPIO device instance is still required in DSDT
> >>>table along with _AEI resources and event methods.
> >>>
> >>>Reading from file provides pin to GPIO device map e.g. :
> >>>$ cat /sys/kernel/debug/acpi/gpio_event
> >>>GPIO device name: /__SB.GPI0
> >>>Available GPIO pin map:
> >>>/__SB.GPI0 <-> pin 0x100
> >>>
> >>>Based on that, user can trigger method corresponding to device pin number:
> >>>$ echo "/__SB.GPI0 0x100" > /sys/kernel/debug/acpi/gpio_event
> >>
> >>I need input from Rafael and Mika as to whether this is a
> >>good interface.
> >
> >Maybe it would make sense to move this into drivers/gpio/gpiolib-acpi.c
> >and hide it behind some Kconfig entry?
> >
> >Since you already need to have DSDT/SSDT table for this to provide the
> >GPIO device, _AEI and the event methods, I would rather make it so that
> >acpi_gpiochip_request_interrupt() will add debugfs entry for each GPIO
> >it finds in _AEI, like:
> >
> >/sys/kernel/debug/acpi/events/<GPIO DEVICE>/n
> >
> >And you could trigger it by writing '1' or something like that to that
> >file.
> >
> 
> Thanks for comments. The idea of available gpio events list under
> /sys/kernel/debug/acpi/events/<GPIO DEVICE>/n is worth adding.
> 
> However, acpi_gpiochip_request_interrupt() would be called if we would have
> real GPIO H/W and related driver. Initial idea of this patch was to avoid
> that restriction. So there are two cases:
> 1. If we have GPIO chip, it is already described in DSDT/SSDT and using this
> patch, user could trigger events by software too.

Yes, this is what I would be interested in.

> 2. None of GPIO chip, so we need to add GPIO/_AEI etc. descrition to
> DSDT/SSDT and pretend we have GPIO chip on board.

OK.
