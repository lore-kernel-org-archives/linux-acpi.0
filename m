From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 13:33:06 +0300
Message-ID: <20190424103306.GC2654@lahna.fi.intel.com>
References: <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
> > I think what you want is "GPIO signaled ACPI event". It works so that
> > you declare _AEI method below the GPIO controller listing the GPIOs you
> > want to trigger events for and then either _Lxx, _Exx or _EVT method for
> > each of them under the same controller. GPIO core then handles it
> > automatically when you register the GPIO chip. See also
> > acpi_gpiochip_request_interrupts().
> 
> Right, that is was I read as well. Let's assume I would be able to patch the
> tables: Would I describe all the logic of this patch in ACPI terms? Where to
> enable interrupts, how to dispatch the SCI event, how to acknowledge it
> etc.? Will it also take care of locking? (BTW, my locking seems to have some
> remaining inconsistency, on second look.)

The GPIO core would then take care of it by requesting the GPIO in
question and dispatching to the correct event handler. In this patch you
just leave out the SCI part and only implement the irqchip like you did
already.

> And even if that were possible, we would be back to the square of existing
> devices without those definitions. If this were a recent chipset, I would
> say, "go, fix future firmware versions". But this one is legacy.

Is it fixing some real issue with these legacy platforms? I mean without
the patch some GPE event is not handled properly? It was not clear to me
from the commit message.
