From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Tue, 13 Feb 2018 10:55:12 +0100
Message-ID: <20180213095512.GB8239@wunner.de>
References: <20180205224531.GA46524@dtor-ws>
 <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com>
 <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de>
 <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com>
 <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0jCRXs9wCBb-kE-0HVJPCSMRZFgY8hF5Mn+kFLYhdp4=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:47547 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbeBMJzO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2018 04:55:14 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jCRXs9wCBb-kE-0HVJPCSMRZFgY8hF5Mn+kFLYhdp4=A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, sayli karnik <karniksayli1995@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>

On Tue, Feb 13, 2018 at 10:18:01AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 13, 2018 at 12:14 AM,  <Mario.Limonciello@dell.com> wrote:
> >> >> request before making any decisions here.
> >> >
> >> > It's a lack of proper D3hot support and GC6 support in Nouveau.
> >>
> >> Thanks, but that is still a bit enigmatic.
> >>
> >> What exactly do you mean by "proper D3hot support", in particular?
> >>
> >
> > I don't believe Nouveau or NVIDIA has support for D3hot at all from
> > what I've heard.  I've not dug further into this.
> 
> But Lukas is saying that Nouveau actually supports runtime PM, so I'm
> not sure what exactly the problem is with respect to this particular
> driver.

Just providing some background info in the hope that it might be useful:

nouveau runtime suspends to D3cold on Nvidia Optimus hybrid graphics
laptops, not on any other machines (e.g. desktop).  The code is in
drivers/gpu/drm/nouveau/nouveau_acpi.c.  It detects presence of Optimus
by looking for a specific _DSM.

On older machines, power was cut using that _DSM.  Newer machines instead
specify _PR3 resources for the root port above the GPU, so power is cut
once the GPU and the root port above it have runtime suspended.  nouveau
detects and supports both mechanisms, as well as the ancient "HybridPower"
machines that preceded Optimus.  Adding Peter Wu to cc, who is the most
knowledgable person I know for this.

Mario mentions GC6, doing a bit of googling reveals this has to do with
power sequencing:
https://www.manualslib.com/manual/1273261/Clevo-N850hk1.html?page=67#manual

It looks like a number of GPIO pins need to be toggled in just the right
order with just the right timing for the GPU to suspend and resume
properly.  Now, normally this should all be handled by the firmware,
but apparently there's some OS cooperation necessary but people may
not be at liberty to talk about it or haven't been told everything
by Nvidia.

AFAIK the proprietary Nvidia driver doesn't support Optimus at all.
That might be the real motivation for the patch.

Thanks,

Lukas
