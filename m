From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: fix UART Auto Flow Control
Date: Wed, 09 Oct 2013 15:51:44 +0200
Message-ID: <1942289.aOn1qVrO7l@vostro.rjw.lan>
References: <1381301360-5156-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57803 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751339Ab3JINkD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Oct 2013 09:40:03 -0400
In-Reply-To: <1381301360-5156-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: chiau.ee.chew@intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, October 09, 2013 09:49:20 AM Heikki Krogerus wrote:
> There is an additional bit in the GENERAL register on newer
> silicon that needs to be set or UART's RTS pin fails to
> reflect the flow control settings in the Modem Control
> Register.
> 
> This will fix an issue where the RTS pin of the UART stays
> always at 1.8V, regardless of the register settings.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

OK, is this urgent?

Rafael


> ---
>  drivers/acpi/acpi_lpss.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index fb78bb9..d396101 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -30,6 +30,7 @@ ACPI_MODULE_NAME("acpi_lpss");
>  /* Offsets relative to LPSS_PRIVATE_OFFSET */
>  #define LPSS_GENERAL			0x08
>  #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
> +#define LPSS_GENERAL_UART_RTS_OVRD	BIT(3)
>  #define LPSS_SW_LTR			0x10
>  #define LPSS_AUTO_LTR			0x14
>  #define LPSS_TX_INT			0x20
> @@ -68,11 +69,16 @@ struct lpss_private_data {
>  
>  static void lpss_uart_setup(struct lpss_private_data *pdata)
>  {
> -	unsigned int tx_int_offset = pdata->dev_desc->prv_offset + LPSS_TX_INT;
> +	unsigned int offset;
>  	u32 reg;
>  
> -	reg = readl(pdata->mmio_base + tx_int_offset);
> -	writel(reg | LPSS_TX_INT_MASK, pdata->mmio_base + tx_int_offset);
> +	offset = pdata->dev_desc->prv_offset + LPSS_TX_INT;
> +	reg = readl(pdata->mmio_base + offset);
> +	writel(reg | LPSS_TX_INT_MASK, pdata->mmio_base + offset);
> +
> +	offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
> +	reg = readl(pdata->mmio_base + offset);
> +	writel(reg | LPSS_GENERAL_UART_RTS_OVRD, pdata->mmio_base + offset);
>  }
>  
>  static struct lpss_device_desc lpt_dev_desc = {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
