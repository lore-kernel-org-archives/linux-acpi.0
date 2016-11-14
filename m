From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i2c: designware: Add clock frequency for future AMD I2C controller
Date: Mon, 14 Nov 2016 01:15:47 +0100
Message-ID: <11467849.gJYeJ2ZOlH@vostro.rjw.lan>
References: <0e262a14-4483-7983-7341-703c8b4d7fd6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42142 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751029AbcKNAIP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 13 Nov 2016 19:08:15 -0500
In-Reply-To: <0e262a14-4483-7983-7341-703c8b4d7fd6@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nehal Shah <Nehal-Bakulchandra.Shah@amd.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Shyam-sundar.S-k@amd.com

On Wednesday, October 19, 2016 02:30:32 PM Nehal Shah wrote:
> This patch supports 150 Mhz i2c clock frequency for Designware ip of future AMD I2C controller.
> 
> Reviewed-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> ---
>  drivers/acpi/acpi_apd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index d58fbf7..5ec7f3a 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -77,6 +77,11 @@ static const struct apd_device_desc cz_i2c_desc = {
>      .fixed_clk_rate = 133000000,
>  };
>  
> +static const struct apd_device_desc wt_i2c_desc = {
> +    .setup = acpi_apd_setup,
> +    .fixed_clk_rate = 150000000,
> +};
> +
>  static struct property_entry uart_properties[] = {
>      PROPERTY_ENTRY_U32("reg-io-width", 4),
>      PROPERTY_ENTRY_U32("reg-shift", 2),
> @@ -162,7 +167,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>      /* Generic apd devices */
>  #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
>      { "AMD0010", APD_ADDR(cz_i2c_desc) },
> -    { "AMDI0010", APD_ADDR(cz_i2c_desc) },
> +    { "AMDI0010", APD_ADDR(wt_i2c_desc) },
>      { "AMD0020", APD_ADDR(cz_uart_desc) },
>      { "AMDI0020", APD_ADDR(cz_uart_desc) },
>      { "AMD0030", },
> 

Applied.

Thanks,
Rafael

