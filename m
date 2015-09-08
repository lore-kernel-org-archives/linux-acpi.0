From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/6] ACPI / property: Extend device_get_next_child_node()
 to data-only nodes
Date: Tue, 8 Sep 2015 11:21:53 +0200
Message-ID: <CACRpkdYMwQuxJqbUWfHygZjSb-4hWyOmx69+R9CFFEZH4Nd11w@mail.gmail.com>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
	<1476191.4Mv7radvfC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1476191.4Mv7radvfC@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 27, 2015 at 4:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make device_get_next_child_node() work with ACPI data-only subnodes
> introduced previously.
>
> Namely, replace acpi_get_next_child() with acpi_get_next_subnode()
> that can handle (and return) child device objects as well as child
> data-only subnodes of the given device and modify the ACPI part
> of the GPIO subsystem to handle data-only subnodes returned by it.
>
> To that end, introduce acpi_node_get_gpiod() taking a struct
> fwnode_handle pointer as the first argument.  That argument may
> point to an ACPI device object as well as to a data-only subnode
> and the function should do the right thing (ie. look for the matching
> GPIO descriptor correctly) in either case.
>
> Next, modify fwnode_get_named_gpiod() to use acpi_node_get_gpiod()
> instead of acpi_get_gpiod_by_index() which automatically causes
> devm_get_gpiod_from_child() to work with ACPI data-only subnodes
> that may be returned by device_get_next_child_node() which in turn
> is required by the users of that function (the gpio_keys_polled
> and gpio-leds drivers).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
