From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v5 01/23] driver core: Add pre_probe callback to bus_type
Date: Fri, 18 Sep 2015 16:56:32 +0200
Message-ID: <CAAObsKADuTjSUZbVJj5g3Ead-Zb87JEqRzvgh9DW1my4Bdh33Q@mail.gmail.com>
References: <1442494637-3674-2-git-send-email-tomeu.vizoso@collabora.com> <Pine.LNX.4.44L0.1509171150410.1270-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509171150410.1270-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org

On 17 September 2015 at 17:52, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 17 Sep 2015, Tomeu Vizoso wrote:
>
>> Some buses (eg. AMBA) need access to some HW resources (it may need a
>> clock to be enabled so a device ID can be read) before a device can be
>> matched to a driver.
>>
>> The pre_probe callback allows the device-driver core to request the bus
>> to perform this initialization and can defer the probe if any of the
>> resources needed are missing.
>>
>> This gives us more flexibility when setting the order in which devices
>> are probed because the resources needed to get the matching information
>> don't need to be available by the time that the bus devices are
>> registered.
>
> Can't the subsystem do this itself in its matching routine?

That seems to work, thanks for the idea!

Regards,

Tomeu

> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
