From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: introduce a function to find the first
 physical device
Date: Mon, 11 Jan 2016 16:45:20 +0200
Message-ID: <CAHp75Vc9U9Zw30i5gf-LPH+ms7zO9p=kSTVKjNe8MqTHf4TiCg@mail.gmail.com>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
	<1452518790-27053-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35154 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760522AbcAKOpV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2016 09:45:21 -0500
In-Reply-To: <1452518790-27053-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

+ One more thing

On Mon, Jan 11, 2016 at 3:26 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:

> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -478,24 +478,36 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
>                               Device Matching
>     -------------------------------------------------------------------------- */
>
> -static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
> -                                                     const struct device *dev)
> +/**
> + * acpi_device_fix_parent - Get first physical node of an ACPI device
> + * @adev: ACPI device in question
> + */

> +struct device *acpi_get_first_physical_node(
> +       struct acpi_device *adev)

One line (even if it goes a bit over 80)

-- 
With Best Regards,
Andy Shevchenko
