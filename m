From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 10:43:11 +0200
Message-ID: <CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34285 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbcDEInM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 04:43:12 -0400
Received: by mail-ob0-f175.google.com with SMTP id bg3so4854238obb.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2016 01:43:11 -0700 (PDT)
In-Reply-To: <20160404225200.GA1615@svinekod>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>

On Tue, Apr 5, 2016 at 12:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:

>> This proposal is based on using _DSD properties to specify device
>> states and configuration nodes and it follows closely the device
>> tree model. Device states are defined using the Device Properties
>> format and the configuration nodes are defined using the
>> Hierarchical Properties Extension format. The generic properties
>> for the configuration nodes are the same as the ones for device
>> tree, while pincontroller drivers can also define custom ones.
>
> From a look of the Documentation addition, and of the current uses of
> pinctrl-names in device tree bindings, one reason for requiring multiple
> pinctrl states is power management. Given that, I'm somewhat concerned by this,
> as it goes against the usual ACPI model of abstracting this sort of thing
> behind power control methods.

There are other use cases but in essence there are two common use
cases:

- Initial set-up of muxing and electrical properties

- Runtime reconfiguration for power saving (especially
  biasing and pull options)

I did see that the ACPI people's ambition has been for all things
power save to be embedded into AML and the like.

However AFAICT
the development model for deployment of ACPI seems to imply that
products are shipped with ACPI tables resident in ROM-like storage,
and at product release several devices are disabled from muxing
while others at the same time are totally lacking power save
enablement.

And these products are only update-able
with hairy BIOS patches that need to be applied
using $SPECIAL_TOOL  that "normal users" do not want to
concern themselves with, as this is not an "apt-get upgrade"
kind of thing.

And as this is server silicon the systems have a bunch of these
"normal users" that are not embedded development experts
and they are very hesitant about doing such things.

Under that scenario it is of course tempting to simply set up the
pins in a known good state and then remove
the responsibility of pin controlling from ACPI firmware altogether
and into the kernel, where "apt-get upgrade" will take care of
post-product launch upgrading of the functionality.

And I think that is what is happening, it's just that so much
prestige is involved that no-one wants to officially admit it.

I was once poking fun at this development model accusing
firmware engineers of having a God complex when they claim
to be able to engineer in these complex use cases during
product firmware development. Now I just feel sad about this
situation and want things to "just work" for them. I think these
patches are good.

Yours,
Linus Walleij
