From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 01/23] driver core: Add pre_probe callback to bus_type
Date: Thu, 17 Sep 2015 11:52:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509171150410.1270-100000@iolanthe.rowland.org>
References: <1442494637-3674-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51094 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751477AbbIQPwD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2015 11:52:03 -0400
In-Reply-To: <1442494637-3674-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, 17 Sep 2015, Tomeu Vizoso wrote:

> Some buses (eg. AMBA) need access to some HW resources (it may need a
> clock to be enabled so a device ID can be read) before a device can be
> matched to a driver.
> 
> The pre_probe callback allows the device-driver core to request the bus
> to perform this initialization and can defer the probe if any of the
> resources needed are missing.
> 
> This gives us more flexibility when setting the order in which devices
> are probed because the resources needed to get the matching information
> don't need to be available by the time that the bus devices are
> registered.

Can't the subsystem do this itself in its matching routine?

Alan Stern

