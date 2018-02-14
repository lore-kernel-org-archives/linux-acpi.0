From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Wed, 14 Feb 2018 11:50:26 +0200
Message-ID: <20180214095026.GK27191@lahna.fi.intel.com>
References: <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com>
 <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de>
 <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com>
 <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
 <20180213073258.GX27191@lahna.fi.intel.com>
 <CAJZ5v0h7YniZ_Xj8PHQ6GazccYPMNgi9r9Nn3Y3U5kKQsimJ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24550 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966503AbeBNJuc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Feb 2018 04:50:32 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h7YniZ_Xj8PHQ6GazccYPMNgi9r9Nn3Y3U5kKQsimJ7A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Lukas Wunner <lukas@wunner.de>, Alex Hung <alex.hung@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, sayli karnik <karniksayli1995@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Feb 14, 2018 at 10:06:22AM +0100, Rafael J. Wysocki wrote:
> > Does this work in Windows and if yes, why we can't do the the same in Linux
> > without any sort of hacks and/or quirks?
> 
> Of course it works on Windows.
>
> The underlying issue is that the platform firmware expects Linux to
> behave like Windows, presumably because Linux says "yes" to
> _OSI("Windows <something>"), and it fails to work, because Linux
> doesn't behave as expected by it.
> 
> Theoretically, it should be possible to make Linux behave like Windows
> in that particular respect, but (a) there may be missing pieces that
> we have no access to (like some secret documentation or similar) and
> (b) it is unclear how much time that would take even if everything was
> known.
> 
> However, the platforms in question are (or shortly will be) shipping
> and Linux quite promptly doesn't work with them.
> 
> So the idea is to make a the firmware ask the kernel for a hint on
> whether or not it should adjust its behavior for a particular
> difference in behavior between Linux and Windows.

Makes sense. Thanks for the explanation!
