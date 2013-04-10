From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] gpio / ACPI: Handle ACPI events in accordance with the spec
Date: Wed, 10 Apr 2013 12:39:21 +0200
Message-ID: <7616728.CEZnGS3Ki9@vostro.rjw.lan>
References: <3043137.BtEKcMiXSu@vostro.rjw.lan> <51652035.5000802@linux.intel.com> <20130410091747.GO21818@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130410091747.GO21818@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, grant.likely@secretlab.ca, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 10, 2013 12:17:47 PM Mika Westerberg wrote:
> On Wed, Apr 10, 2013 at 11:17:57AM +0300, Mathias Nyman wrote:
> > On 04/10/2013 10:53 AM, Mika Westerberg wrote:
> > >On Tue, Apr 09, 2013 at 03:57:25PM +0200, Rafael J. Wysocki wrote:
> > >>+void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
> > >>+{
> > >>+	acpi_handle handle;
> > >>+	acpi_status status;
> > >>+	struct list_head *evt_pins;
> > >>+	struct acpi_gpio_evt_pin *evt_pin, *ep;
> > >>+
> > >>+	if (!chip->dev || !chip->to_irq)
> > >>+		return;
> > >>+
> > >>+	handle = ACPI_HANDLE(chip->dev);
> > >>+	if (!handle)
> > >>+		return;
> > >>+
> > >>+	status = acpi_get_data(handle, acpi_gpio_evt_dh, (void **)&evt_pins);
> > >>+	if (ACPI_FAILURE(status))
> > >>+		return;
> > >>+
> > >>+	list_for_each_entry_safe_reverse(evt_pin, ep, evt_pins, node) {
> > >>+		devm_free_irq(chip->dev, evt_pin->irq, evt_pin);
> > >
> > >How about using normal request/free_irq() functions for both _EVT and
> > >non-_EVT events? Since we now need to call acpi_gpiochip_free_interrupts()
> > >anyway, I don't see the point using devm_* functions here.
> > >
> > 
> > Then we need to create a list of non-_EVT events, or add them to the
> > evt_pins list.
> 
> Good point. Maybe we can add them to the evt_pins list and handle the same
> way as _EVT (except that we need to call _Exx and _Lxx methods instead of
> _EVT)?

The difference is that the evt_pins data is only needed for _EVT execution,
because _EVT takes the pin argument.  _Lxx/_Exx don't take arguments and
there's no need to add extra data structures for them, as devm_ does what's
needed.

Of course, plain request/free_irq may be used for the _EVT events only
at the expense of a little more complexity in acpi_gpiochip_request_interrupts().

Thanks,
Rafael
