From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sat, 31 Mar 2007 23:28:46 -0700
Message-ID: <460F511E.2090102@goop.org>
References: <460E0158.7090705@goop.org> <8f8ff01d0703310033y74421cfcl747ece1be003471@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:49617 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932716AbXDAG2r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2007 02:28:47 -0400
In-Reply-To: <8f8ff01d0703310033y74421cfcl747ece1be003471@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Could you try to unload or disable hardware sensors and check if it
> helps?
> CONFIG_I2C=m
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCA=m
> CONFIG_I2C_I810=m
> CONFIG_I2C_PIIX4=m
> CONFIG_SENSORS_DS1337=m
> CONFIG_SENSORS_DS1374=m
> CONFIG_SENSORS_EEPROM=m
> CONFIG_SENSORS_PCF8574=m
> CONFIG_SENSORS_PCA9539=m
> CONFIG_SENSORS_PCF8591=m
> CONFIG_SENSORS_MAX6875=m

That seems to have helped.  If I watch
/proc/acpi/thermal_zone/THM?/temperature, it seems stable even under
load.   I didn't try watching the thermal_zones when these options were
enabled, but I presume the temperature was not controlled for it to hit
128 degC.

What's going on here?  Does reading an i2c sensor from the kernel
prevent something else from doing it?

    J
