From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 01/22] platform: delay device-driver matches until late_initcall
Date: Wed, 29 Jul 2015 22:20:05 -0500
Message-ID: <CAL_Jsq+SBGFNHR+T15FSMsqh-TWaNBMqesxZfXKiH8g9mqXYuQ@mail.gmail.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com> <1438089593-7696-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34122 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbbG3DUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2015 23:20:25 -0400
In-Reply-To: <1438089593-7696-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Delay matches of platform devices until late_initcall, when we are sure
> that all built-in drivers have been registered already.  This is needed
> to prevent deferred probes because of some drivers not having registered
> yet.
>
> The reason why only platform devices are delayed is that some other
> devices are expected to be probed earlier than late_initcall, for
> example, the system PNP driver needs to probe its devices in
> fs_initcall.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v2:
> - Move delay to platform.c
>
>  drivers/base/platform.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 063f0ab15259..fcf654678e27 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -33,6 +33,8 @@
>  /* For automatically allocated device IDs */
>  static DEFINE_IDA(platform_devid_ida);
>
> +static bool enable_matches;
> +
>  struct device platform_bus = {
>         .init_name      = "platform",
>  };
> @@ -839,6 +841,15 @@ static int platform_match(struct device *dev, struct device_driver *drv)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct platform_driver *pdrv = to_platform_driver(drv);
>
> +       /*
> +        * Delay matches of platform devices until late_initcall, when we are
> +        * sure that all built-in drivers have been registered already. This
> +        * is needed to prevent deferred probes because of some drivers
> +        * not having registered yet.
> +        */
> +       if (!enable_matches)
> +               return false;
> +

Having this as a global makes me nervous. I think it would be better
to be DT specific or per device some how. Perhaps use OF_POPULATED_BUS
flag as an additional test.

There could be non-DT platforms that rely on the initcall ordering and
moving all probes to late_initcall could change the ordering. I'm not
sure though.

Rob
