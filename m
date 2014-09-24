From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device properties interface
Date: Wed, 24 Sep 2014 16:11:33 +0200
Message-ID: <1965808.H15Dedhqve@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <6744174.JquHLt80n3@wuerfel> <20140924093823.GW1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140924093823.GW1786@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Darren Hart <dvhart@infradead.org>, David Woodhouse <david.woodhouse@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, September 24, 2014 12:38:23 PM Mika Westerberg wrote:
> On Wed, Sep 24, 2014 at 11:12:36AM +0200, Arnd Bergmann wrote:
> > As a start, we could probably take the proposed device_for_each_child_node
> > and move that into the leds-core, changing the fw_dev_node argument
> > for an led_classdev with the addition of the of_node and acpi_object
> > members. It would still leave it up to the gpio-leds driver to do
> > 
> > 	if (led_cdev->of_node)
> > 		gpiod = devm_of_get_gpiod(led_cdev->of_node, ...);
> > 	else
> > 		gpiod = devm_acpi_get_gpiod(led_cdev->acpi_object, ...);
> > 
> > but there seems little benefit in abstracting this because there is
> > only one driver that needs it.
> 
> The same interface is used also in gpio_keys_polled.c driver so if we
> want to avoid duplicating code this needs to be abstracted away from the
> drivers.

Well, precisely.

Moving it to the leds-core doesn't buy us anything.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
