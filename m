From: Julian Andres Klode <jak@jak-linux.org>
Subject: Re: [PATCH v2] thinkad_acpi: Support the battery wear control
Date: Tue, 5 Dec 2017 23:23:43 +0100
Message-ID: <20171205222224.5dcc4u67jhixdyiz@jak-x230>
References: <20171203225640.GA11655@thinkpad>
 <20171205142228.lrfds2ih7tgf7ovy@christoph-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbdLEWXs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 17:23:48 -0500
Content-Disposition: inline
In-Reply-To: <20171205142228.lrfds2ih7tgf7ovy@christoph-lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Tue, Dec 05, 2017 at 03:22:28PM +0100, Christoph Böhmwalder wrote:
> On Sun, Dec 03, 2017 at 11:56:40PM +0100, Ognjen Galic wrote:
> > Add support for the ACPI batteries on newer thinkpad models
> > (>Sandy Bridge) that support the setting of start and stop
> > thresholds.
> > 
> > The actual interface to the driver is a extension for the
> > existing ACPI battery driver. This was done so that users
> > can write transparently to the interface of the ACPI battery
> > driver and dont have to use some private interface
> > (for ex. /sys/devices/platform/thinkpad_acpi/).
> > 
> > Two new interfaces are created:
> > 
> > /sys/class/power_supply/BAT{0,1}/charge_start_threshold
> > /sys/class/power_supply/BAT{0,1}/charge_stop_threshold
> 
> Just tried this on my X1 Carbon (i7-3667U Ivy Lake):
> 
> # cat /sys/class/power_supply/BAT0/charge_stop_threshold
> 100
> # cat /sys/class/power_supply/BAT0/charge_start_threshold
> 100
> 
> That doesn't seem to make any sense.  Is my battery somehow reporting
> false values here?  Any way to cross check these values?

It means that both values are 0 (default). The first one is wrongly
mapped to 100, but should probably be reported as 0.

Also, the values are not mangled correctly when writing: 100
as a stop threshold should be written as 0, and and 100 as a
start threshold should be illegal, giving you:

	start = [0, 99]
	stop = [1, 100]

Which is what my patch series a few years ago implemented. I
never got to integrate that with the acpi battery driver, though.
-- 
debian developer - deb.li/jak | jak-linux.org - free software dev
ubuntu core developer                              i speak de, en
