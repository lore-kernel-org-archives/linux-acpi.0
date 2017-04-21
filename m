From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Sat, 22 Apr 2017 00:43:00 +0200
Message-ID: <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35765 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426412AbdDUWnC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 18:43:02 -0400
In-Reply-To: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Apr 22, 2017 at 12:28 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> GED driver is currently set up as a platform driver. On modern operating
> systems, most of the drivers are compiled as kernel modules. It is possible
> that a GED interrupt event is received and the driver such as GHES/GPIO/I2C
> to service it is not available yet. To accommodate this use case, delay
> GED driver load to the late init phase.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/evged.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index 46f0603..30e638b 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -151,4 +151,10 @@ static int ged_probe(struct platform_device *pdev)
>                 .acpi_match_table = ACPI_PTR(ged_acpi_ids),
>         },
>  };
> -builtin_platform_driver(ged_driver);
> +
> +static __init int ged_init(void)
> +{
> +       return platform_driver_register(&ged_driver);
> +}
> +
> +late_initcall(ged_init);

Does this fix the problem?

What about if the module in question is loaded after running late_initcalls?

Thanks,
Rafael
