From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface)
Date: Wed, 22 Oct 2014 11:28:40 +0200
Message-ID: <2466280.tMTA38OpXD@wuerfel>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com> <4711930.7fsc2oSxcp@wuerfel> <20141022085140.GF1484@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57335 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334AbaJVJ2q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2014 05:28:46 -0400
In-Reply-To: <20141022085140.GF1484@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Wednesday 22 October 2014 11:51:40 Mika Westerberg wrote:
> On Wed, Oct 22, 2014 at 10:33:32AM +0200, Arnd Bergmann wrote:
> > On Wednesday 22 October 2014 11:10:44 Mika Westerberg wrote:
> > > 
> > > It expects that GPIOs returned from _CRS are in specific order. Since we
> > > can't change these existing ACPI tables, we must support them somehow.
> > > 
> > > This patch series handles it so that:
> > > 
> > >   1) If we can't find given property (e.g "reset-gpios" or
> > >      "shutdown-gpios") the index above will refer directly to the GPIO
> > >      resource returned from _CRS.
> > > 
> > >   2) If the property is found we ignore index and take it from the
> > >      property instead.
> > > 
> > > This has the drawback that we cannot support this:
> > > 
> > >         Package () { "reset-gpios", Package () { ^GPIO, 0, 0, 0, ^GPIO, 1, 0, 0}}
> > >                                                                  ^^^^^^^^^^^^^^
> > > So the second entry in the above is not accessible using
> > > gpiod_get_index() and the reason is that we want to support the existing
> > > and new ACPI tables where _DSD is not being used.
> > 
> > So this is not using the DT binding but does thing slightly differently then.
> > In this case (supporting two incompatible bindings for DT and ACPI), I think
> > the only sensible driver implementation would be to know what we are asking
> > for and use different devm_gpiod_get_index statements based on the firmware
> > interface.
> 
> Yes something like that is probably needed.
> 
> Alternatively (I didn't try if this works) we could do it so that
> when we see:
> 
>         gpio = devm_gpiod_get_index(&pdev->dev, "shutdown", 1);
> 
> we check first for the property ("shutdown-gpios"), and check if it has
> more than one entry in the value, like:
> 
>         Package () { "reset-gpios", Package () { ^GPIO, 0, 0, 0, ^GPIO, 1, 0, 0}}
> 
> and in that case return the second entry. If we find this instead:
> 
>         Package () { "reset-gpios", Package () { ^GPIO, 0, 0, 0 }}
> 
> we just ignore the index.
> 
> Last if there is no _DSD the index refers directly to the GPIO resource
> in _CRS.
> 
> This would support both _DSD and non-_DSD at the same time but it makes
> the implementation more complex.

I think the main problem with that approach is that it makes the common
code more error-prone in case of unintentionally broken device descriptions,
because it less often returns an error.

	Arnd
