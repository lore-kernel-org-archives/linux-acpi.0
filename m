From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Thu, 02 Oct 2014 13:51:24 +0200
Message-ID: <2466832.0XJezjdvYs@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1979325.jM0BQzDCTX@wuerfel> <20141002104123.GJ1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54381 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaJBLvl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 07:51:41 -0400
In-Reply-To: <20141002104123.GJ1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thursday 02 October 2014 13:41:23 Mika Westerberg wrote:
> On Wed, Oct 01, 2014 at 09:59:14AM +0200, Arnd Bergmann wrote:
> > On Wednesday 01 October 2014 04:11:20 Rafael J. Wysocki wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> > > +The referenced ACPI device is returned in args->adev if found.
> > > +
> > > +In addition to simple object references it is also possible to have object
> > > +references with arguments. These are represented in ASL as follows:
> > > +
> > > +	Device (\_SB.PCI0.PWM)
> > > +	{
> > > +		Name (_DSD, Package () {
> > > +			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > +			Package () {
> > > +				Package () {"#pwm-cells", 2}
> > > +			}
> > > +		})
> > > +	}
> > > +
> > 
> > Similarly, the "#foo-cells" syntax is an artifact of the limitations of the
> > DT syntax, and I'd assume there would be a better way to encode this
> > in ACPI. Also, a "cell" in Open Firmware is defined as a big-endian
> > 32-bit value, which doesn't directly correspond to something in ACPI,
> > and the '#' character is an artifact of the use of the Forth language
> > in Open Firmware, which you also don't have here.
> 
> Same here, we tried to make it follow closely the DT description. It is
> probably not the best/optimal encoding for ACPI but it is documented
> well in Documentation/devicetree/bindings so why not use it.
> 
> The summary email from Darren at KS also mentions that for the existing
> drivers, the existing schemas should be common for both implementations [1].
> 
> For new bindings we probably should look out if they can be better
> represented using ACPI types.
> 
> [1] http://lwn.net/Articles/609373/

I thought when we had discussed the subsystem specific bindings, the
consensus there was to have subsystem specific accessors and
properties/tables.

I would argue that for everything that ACPI already has (interrupts,
registers, gpio, dmaengine, ...) the native method should be used,
possibly using _DSD to provide naming for otherwise anonymous references.

	Arnd
