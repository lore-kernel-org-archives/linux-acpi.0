From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] mfd: intel_soc_pmic: Select designware i2c-bus driver
Date: Thu, 23 Mar 2017 16:46:47 +0000
Message-ID: <20170323164647.tyyqoziiy4jwg5vc@dell>
References: <20170322112923.20200-1-hdegoede@redhat.com>
 <20170322112923.20200-3-hdegoede@redhat.com>
 <1490187220.19767.159.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33971 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbdCWQqv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2017 12:46:51 -0400
Received: by mail-wr0-f173.google.com with SMTP id l37so151664322wrc.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2017 09:46:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490187220.19767.159.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 Mar 2017, Andy Shevchenko wrote:

> On Wed, 2017-03-22 at 12:29 +0100, Hans de Goede wrote:
> > The Crystal Cove PMIC provides an ACPI OPRegion handler, which must be
> > available before other drivers using it are loaded, which is why
> > INTEL_SOC_PMIC is a bool.
> > 
> > Just having the driver is not enough, the driver for the i2c-bus must
> > also be built in, to ensure this, this patch adds a select for it.
> > 
> 
> > While at it this patch also changes the human readable name of the
> > Kconfig
> > option to make clear the INTEL_SOC_PMIC option selects support for the
> > Intel Crystal Cove PMIC and documents why this is a bool.
> 
> The above is what my patch does, I'm okay if the change is going with
> this series as long as Lee is on the same side. Otherwise I would prefer
> to go my changes first.

I think this set is going to need to be rebase on top of MFD.

> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Note this patch will partially conflicts with (contains the same
> > changes as)
> > a patch in Andy Shevchenko's tree.
> > ---
> >  drivers/mfd/Kconfig | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index d427a10..0c6a967 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -425,14 +425,17 @@ config LPC_SCH
> >  	  System Management Bus and General Purpose I/O.
> >  
> >  config INTEL_SOC_PMIC
> > -	bool "Support for Intel Atom SoC PMIC"
> > +	# This is a bool as it provides an ACPI Opregion which must
> > be
> > +	# available as soon as possible
> > +	bool "Support for Intel Crystal Cove PMIC"
> >  	depends on GPIOLIB
> >  	depends on I2C=y
> >  	select MFD_CORE
> >  	select REGMAP_I2C
> >  	select REGMAP_IRQ
> > +	select I2C_DESIGNWARE_PLATFORM
> >  	help
> > -	  Select this option to enable support for the PMIC device
> > +	  Select this option to enable support for the Crystal Cove
> > PMIC
> >  	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
> >  	  thermal, charger and related power management functions
> >  	  on these systems.
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
