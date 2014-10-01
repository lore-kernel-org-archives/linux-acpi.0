From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 12:01:34 +0200
Message-ID: <5364565.aEcZqpzdLW@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <2780318.hxubhI9Rvq@wuerfel> <20141001091309.GY1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50820 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaJAKBo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 06:01:44 -0400
In-Reply-To: <20141001091309.GY1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wednesday 01 October 2014 12:13:09 Mika Westerberg wrote:
> 
> > Regarding the MODULE_DEVICE_TABLE, I suspect the above won't work the
> > way you are hoping for, because once you get to dozens or hundreds of
> > drivers doing this, each device will show up with the same string,
> > so udev will try to load all the modules that list "PRP0001". That
> > doesn't look right. With the code from patch 3, you can probably drop
> > the acpi MODULE_DEVICE_TABLE() entirely and get the correct behavior.
> 
> It actually works like this now:
> 
>  # cd /sys/bus/platform/devices/PRP0001\:00/
>  DRIVER=leds-gpio
>  MODALIAS=of:Nprp0001TacpiCgpio-leds
> 
>  # cat modalias 
>  of:Nprp0001TacpiCgpio-leds
> 
> In other words the modalias changes to be of:Nprp0001Tacpi, e.g
> name=prp0001, type=acpi and then list of compatible values.
> 
> Udev then loads only module that matches the modalias so it should not
> load everything listing PRP0001 in their MODULE_DEVICE_TABLE().

I'm not completely following yet. I can see how this works now, but
how is this better than just using the existing modalias for OF?

	Arnd
