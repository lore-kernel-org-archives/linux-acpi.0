From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Mon, 4 Apr 2016 23:52:01 +0100
Message-ID: <20160404225200.GA1615@svinekod>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, charles.garcia-tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:
> This is a proposal for adding ACPI support for pin controller
> configuration.
> 
> It has been developed to enable the MinnowBoard and IoT community
> by providing an easy way to specify pin multiplexing and
> pin configuration.
> 
> This proposal is based on using _DSD properties to specify device
> states and configuration nodes and it follows closely the device
> tree model. Device states are defined using the Device Properties
> format and the configuration nodes are defined using the
> Hierarchical Properties Extension format. The generic properties
> for the configuration nodes are the same as the ones for device
> tree, while pincontroller drivers can also define custom ones.

>From a look of the Documentation addition, and of the current uses of
pinctrl-names in device tree bindings, one reason for requiring multiple
pinctrl states is power management. Given that, I'm somewhat concerned by this,
as it goes against the usual ACPI model of abstracting this sort of thing
behind power control methods.

To the best of my knowledge, that goes against the ASWG's expectations on how
_DSD will be used (per [1]). Charles, please correct me if that document is no
longer representative.

Additionally, pinctrl has some cross-cutting concerns (e.g. mutually exclusive
device usage due to a shared pin), and I can imagine that may interact poorly
with any AML or firmware assumptions about the state of the world, as there's
no mechanism present to notify those of changes to pins.

I think that this is a class of problem which needs to be raised with the ASWG,
and solved in an ACPI-native fashion, rather than simply copying properties
from DT using _DSD. If nothing else, the restrictions on FW and AML would need
to be specified.

Thanks,
Mark.

[1] https://lists.acpica.org/pipermail/dsd/2015-September/000019.html
