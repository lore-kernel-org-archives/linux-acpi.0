From: Kamlakant Patel <kamlakant.patel@broadcom.com>
Subject: Re: [PATCH 1/2] ACPI / APD: Add device HID for Vulcan SPI controller
Date: Mon, 29 Aug 2016 18:05:16 +0530
Message-ID: <CAB=aS0OFv3fvrrmsKvUKuTyDXECVmC8xdtyfKNdoNMN7HcC7RA@mail.gmail.com>
References: <1470751522-11060-1-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34712 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932863AbcH2MfS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2016 08:35:18 -0400
Received: by mail-ua0-f181.google.com with SMTP id k90so242571243uak.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2016 05:35:18 -0700 (PDT)
In-Reply-To: <1470751522-11060-1-git-send-email-kamlakant.patel@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Kamlakant Patel <kamlakant.patel@broadcom.com>, linux-acpi@vger.kernel.org, Jayachandran C <jchandra@broadcom.com>, Mark Brown <broonie@kernel.org>

Hi,

On Tue, Aug 9, 2016 at 7:35 PM,  <kamlakant.patel@broadcom.com> wrote:
> From: Kamlakant Patel <kamlakant.patel@broadcom.com>
>
> Add device HID for SPI controller on Broadcom Vulcan ARM64.
> The default frequency for SPI on Vulcan is 133MHz.
>
> Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
> ---
>  drivers/acpi/acpi_apd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 1daf9c4..c80c8f8 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -87,6 +87,11 @@ static struct apd_device_desc xgene_i2c_desc = {
>         .setup = acpi_apd_setup,
>         .fixed_clk_rate = 100000000,
>  };
> +
> +static struct apd_device_desc vulcan_spi_desc = {
> +       .setup = acpi_apd_setup,
> +       .fixed_clk_rate = 133000000,
> +};
>  #endif
>
>  #else
> @@ -149,6 +154,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>  #endif
>  #ifdef CONFIG_ARM64
>         { "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
> +       { "BRCM900D", APD_ADDR(vulcan_spi_desc) },
>  #endif
>         { }
>  };

Could you please review and apply this patch.
This patch is provides default frequency to the SPI controller, if not
set by firmware.
(Patch "spi: xlp: Add ACPI support for Vulcan SPI controller" is
already applied).

Thanks,
Kamlakant Patel
