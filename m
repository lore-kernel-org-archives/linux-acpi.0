From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 3/6] acpi : remove pointless cpuidle device state_count init
Date: Fri, 7 Sep 2012 16:31:21 +0530
Message-ID: <CAP245DXku_LVshNjRs9Ea4VxxZCaucPQ2aGDqpjTQObBixdL+Q@mail.gmail.com>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
	<1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43637 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760343Ab2IGLBW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 07:01:22 -0400
Received: by vbbff1 with SMTP id ff1so3034765vbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 04:01:22 -0700 (PDT)
In-Reply-To: <1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Patch 1 and 3 are independent cleanups. Perhaps you can separate them
out from the per-cpu latency series in case you have to repost.

On Fri, Sep 7, 2012 at 3:49 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The cpuidle core takes care of filling this field from drv->state_count.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/processor_idle.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 084b1d2..fc4757e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1035,8 +1035,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
>                         break;
>         }
>
> -       dev->state_count = count;
> -
>         if (!count)
>                 return -EINVAL;
>
> --
> 1.7.5.4
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
