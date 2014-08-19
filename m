From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 8/9] Input: gpio_keys_polled - Make use of device
 property API
Date: Tue, 19 Aug 2014 12:27:53 +0300
Message-ID: <20140819092753.GI1660@lahna.fi.intel.com>
References: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
 <1408172039-32513-9-git-send-email-mika.westerberg@linux.intel.com>
 <20140818105512.7889980b@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28959 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbaHSJ2E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Aug 2014 05:28:04 -0400
Content-Disposition: inline
In-Reply-To: <20140818105512.7889980b@ultegra>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <al.stone@linaro.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <matthew.garrett@nebula.com>, Matt Fleming <matt.fleming@intel.com>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Josh Triplett <josh@joshtriplett.org>, Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>Rob

On Mon, Aug 18, 2014 at 10:55:12AM -0700, Jacob Pan wrote:
> On Sat, 16 Aug 2014 09:53:58 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > From: Aaron Lu <aaron.lu@intel.com>
> > 
> > Make use of device property API in this driver so that both OF based
> > system and ACPI based system can use this driver.
> > 
> Do we always assume OF and ACPI _DSD will have the same property name
> strings? i.e. in this patch "gpios"
> > +	if (device_property_get(dev, "gpios", NULL)) {
> > -		if (!of_find_property(pp, "gpios", NULL)) {
> 
> Maybe i missed something, but I don't think we can make that assumption
> in BIOS. If not, what is the point of having unified interface?

We recommend that when it makes sense, the property names in _DSD follow
the corresponding DT names.
