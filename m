From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 04/20] of: add function to allow probing a device from
 a OF node
Date: Fri, 16 Oct 2015 23:53:04 -0700
Message-ID: <20151017065304.GB18329@kroah.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443517859-30376-5-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32998 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbJQGxM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Oct 2015 02:53:12 -0400
Content-Disposition: inline
In-Reply-To: <1443517859-30376-5-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Sep 29, 2015 at 11:10:42AM +0200, Tomeu Vizoso wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.
> 
> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).
> 
> Subsystems can use this when looking up resources for drivers, to reduce
> the chances of deferred probes because of the probing order of devices.

How do subsystems know to do this?  Under what situation?  Why is this a
of-only type thing?  Why don't other busses need this?

I don't like to special-case a single bus like this at all if
possible...

thanks,

greg k-h
