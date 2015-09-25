From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 05/22] gpio: Probe GPIO drivers on demand
Date: Fri, 25 Sep 2015 10:01:24 -0700
Message-ID: <CACRpkdZssaXik5XWZLoFXZWKWMsVWppOO85Q9QaXyHiaLUMWAA@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
	<1441628627-5143-6-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33701 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528AbbIYRBZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2015 13:01:25 -0400
Received: by obbbh8 with SMTP id bh8so86606217obb.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2015 10:01:24 -0700 (PDT)
In-Reply-To: <1441628627-5143-6-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On Mon, Sep 7, 2015 at 5:23 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:

> When looking up a gpiochip through its firmware node, probe it if it
> hasn't already.
>
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None

Acked-by: Linus Walleij <linus.walleij@linaro.org>

That is if the whole thing goes in as-is for the GPIO parts.

Yours,
Linus Walleij
