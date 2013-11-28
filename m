From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH v3 1/6] ARM: tegra: add gpiod_lookup table for paz00
Date: Thu, 28 Nov 2013 11:20:19 +0100
Message-ID: <1752117.77jQLaML2y@fb07-iapwap2>
References: <1385460350-17543-1-git-send-email-mika.westerberg@linux.intel.com> <4501377.Eymj5teNBr@fb07-iapwap2> <20131128093224.GA26634@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20131128093224.GA26634@ulmo.nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rhyland Klein <rklein@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Adrian Hunter <adrian.hunter@intel.com>, Alex Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 28. November 2013, 10:32:41 schrieb Thierry Reding:
> On Thu, Nov 28, 2013 at 10:09:14AM +0100, Marc Dietrich wrote:
> > The real problem with the rfkill driver is that it does not support DT. A
> > naive attempt to convert it was made some year ago, but got rejected
> > because rfkill wasn't seen as isolated device which can be represented in
> > the device- tree. Also it can not be added under some existing device
> > node (e.g. the wifi driver) because those devices sit normally on an
> > "enumeratable" bus (e.g. usb, pci), which is not listed in the device
> > tree at all. This is why it still requires a board file and
> > platform_data. I wish we could find a solution for this.
> 
> There is a solution at least for PCI. You can list PCI devices within
> the device tree, which is really handy (required even) if for instance
> one of the PCI devices is an SPI or I2C controller, each providing a bus
> that cannot be probed. What you usually do is describe the PCI hierarchy
> at least up to the controller and then list slaves as child nodes.
> 
> I'm not aware of anything similar for USB, but it should certainly be
> possible to come up with a standard binding for the USB bus. It has a
> topology that's similar enough to that of PCI so that the same general
> rules could be applied.
> 
> If that's really the only thing that keeps rfkill from gaining DT
> support then it's something worth tackling in my opinion.

it's not so simple I fear. The wifi driver needs to learn about the rfkill 
"device". As mentioned above, it's not really a device so the question is what 
needs to be added and where? The wifi driver just polls his own gpio lines to 
check the status of rfkill. Be we want to modify the "other side", so maybe 
this isn't related to the wifi driver at all. It's more a "virtual rfkill 
device". No idea if something like this exists already in device tree.

Marc

