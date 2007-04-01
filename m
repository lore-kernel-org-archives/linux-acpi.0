From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 1 Apr 2007 16:32:05 +0000
Message-ID: <20070401163204.GB5762@ucw.cz>
References: <460E0158.7090705@goop.org> <8f8ff01d0703310033y74421cfcl747ece1be003471@mail.gmail.com> <460F511E.2090102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1038 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933632AbXDAQcP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2007 12:32:15 -0400
Content-Disposition: inline
In-Reply-To: <460F511E.2090102@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi!

> > CONFIG_I2C=m
> > CONFIG_I2C_ALGOBIT=m
> > CONFIG_I2C_ALGOPCA=m
> > CONFIG_I2C_I810=m
> > CONFIG_I2C_PIIX4=m
> > CONFIG_SENSORS_DS1337=m
> > CONFIG_SENSORS_DS1374=m
> > CONFIG_SENSORS_EEPROM=m
> > CONFIG_SENSORS_PCF8574=m
> > CONFIG_SENSORS_PCA9539=m
> > CONFIG_SENSORS_PCF8591=m
> > CONFIG_SENSORS_MAX6875=m
> 
> That seems to have helped.  If I watch
> /proc/acpi/thermal_zone/THM?/temperature, it seems stable even under
> load.   I didn't try watching the thermal_zones when these options were
> enabled, but I presume the temperature was not controlled for it to hit
> 128 degC.
> 
> What's going on here?  Does reading an i2c sensor from the kernel
> prevent something else from doing it?

ACPI is misdesigned, and lm_sensors can't cope with that.

One idea was to add 'big acpi lock' and make lm_sensors take it, too.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
