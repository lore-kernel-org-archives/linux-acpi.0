From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI: sbshc: remove raw pointer from printk message
Date: Sat, 20 Jan 2018 00:53:39 +0100
Message-ID: <CAJZ5v0jh7sUje5RcEJVT_bLM9u=9z0pbPBEWy=4k-tfKfKO-SQ@mail.gmail.com>
References: <20180119090603.GA7775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46121 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeASXxk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2018 18:53:40 -0500
In-Reply-To: <20180119090603.GA7775@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Qize <wang_qize@venustech.com.cn>

On Fri, Jan 19, 2018 at 10:06 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There's no need to be printing a raw kernel pointer to the kernel log at
> every boot.  So just remove it, and change the whole message to use the
> correct dev_info() call at the same time.
>
> Reported-by: Wang Qize <wang_qize@venustech.com.cn>
> Cc: stable <stable@vger.kernel.org>

I will remember this one. ;-)

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 2fa8304171e0..217e1caf58d6 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -275,8 +275,8 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
>         device->driver_data = hc;
>
>         acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
> -       printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
> -               hc->ec, hc->offset, hc->query_bit);
> +       dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
> +                hc->offset, hc->query_bit);
>
>         return 0;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
