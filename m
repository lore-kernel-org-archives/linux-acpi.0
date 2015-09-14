From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 20/22] driver core: Allow deferring probes until late init
Date: Mon, 14 Sep 2015 11:04:53 +0200
Message-ID: <CAAObsKA24=JZH_ukwCcaQ+cCxL1BcVLZe=W54X-5V=3idogW5A@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com> <20150911121746.GR12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35538 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbbINJFO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2015 05:05:14 -0400
In-Reply-To: <20150911121746.GR12027@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 11 September 2015 at 14:17, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 07, 2015 at 02:23:45PM +0200, Tomeu Vizoso wrote:
>> Add a field to struct device that instructs the device-driver core to
>> defer the probe of this device until the late_initcall level.
>>
>> By letting all built-in drivers to register before starting to probe, we
>> can avoid any deferred probes by probing dependencies on demand.
>
> Is this not going to resut in massive churn as we go through and set
> this flag for a massive proportion of drivers?  Could we mitigate this
> by having a first pass at setting this per subsystem or something so
> that we get a good proportion of drivers with changes in core code?

I think this flag should be only set during the initial registration
of devices (eg. acpi_device_add, of_device_add, etc), as by delaying
the probe of those we are automatically delaying the probe of the
rest.

Regards,

Tomeu
