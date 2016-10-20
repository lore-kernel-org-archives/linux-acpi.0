From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Date: Thu, 20 Oct 2016 17:05:22 +0200
Message-ID: <CAJZ5v0ipdO2psmdesoQuw_5uuOSqDh22DK04bEJTi1pW0fL53g@mail.gmail.com>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34483 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbcJTPFY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 11:05:24 -0400
In-Reply-To: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Oct 20, 2016 at 5:03 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> It turns out we need to ping the watchdog hardware on resume when we
> re-program it. Otherwise this results inadvertent reset to trigger right
> after the resume is completed.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Is there a Fixes: tag missing here?

> ---
>  drivers/watchdog/wdat_wdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index e473e3b23720..6d1fbda0f461 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -499,6 +499,10 @@ static int wdat_wdt_resume_noirq(struct device *dev)
>                 ret = wdat_wdt_enable_reboot(wdat);
>                 if (ret)
>                         return ret;
> +
> +               ret = wdat_wdt_ping(&wdat->wdd);
> +               if (ret)
> +                       return ret;
>         }
>
>         return wdat_wdt_start(&wdat->wdd);
> --

Thanks,
Rafael
