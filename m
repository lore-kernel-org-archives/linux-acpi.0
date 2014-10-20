From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface
Date: Mon, 20 Oct 2014 16:22:15 +0200
Message-ID: <15256871.WGP3V2Kd9r@wuerfel>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <2997291.LjjH2RgEUW@wuerfel> <25715349.xM7UOyLcLb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25715349.xM7UOyLcLb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Monday 20 October 2014 01:58:57 Rafael J. Wysocki wrote:
> 
> Actually, since the two last patches in the series, which currently are
> the only users of these new functions, both pass "gpios" as the property
> name and 0 as the index, I can simplify the functions so that (a)
> fwnode_get_gpiod() takes fwnode and name and then simply passes 0 as the
> index to either of_get_named_gpiod_flags() or acpi_get_gpiod_by_index()
> and (b) devm_get_named_gpiod_from_child() takes only dev and fwnode (child)
> and passes "gpios" as the property name to fwnode_get_gpiod().  The name
> of devm_get_named_gpiod_from_child() could then be changed to something
> like devm_get_gpiod_from_child() even.
> 
> If anyone in the future needs anything more general, they can simply
> add more complexity to that code, but for now we can go for a simplified
> interface just fine.
> 

That sounds good, yes.

	Arnd
