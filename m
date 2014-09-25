From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: not using UART RTS override with Auto Flow Control
Date: Fri, 26 Sep 2014 01:48:37 +0200
Message-ID: <2707641.kPQ3p3SNoy@vostro.rjw.lan>
References: <1410437973-16873-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54552 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752603AbaIYX2r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2014 19:28:47 -0400
In-Reply-To: <1410437973-16873-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Thursday, September 11, 2014 03:19:33 PM Heikki Krogerus wrote:
> Adding a check for UART Auto Flow Control feature and only
> enabling the RTS override when it's not supported. RTS
> override is not needed when Auto Flow Control is used and
> they shouldn't be used together.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Queued up for 3.18, thanks!

> ---
>  drivers/acpi/acpi_lpss.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 1951b59..76cc698 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -83,18 +83,26 @@ struct lpss_private_data {
>  	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
>  };
>  
> +/* UART Component Parameter Register */
> +#define LPSS_UART_CPR			0xF4
> +#define LPSS_UART_CPR_AFCE		BIT(4)
> +
>  static void lpss_uart_setup(struct lpss_private_data *pdata)
>  {
>  	unsigned int offset;
> -	u32 reg;
> +	u32 val;
>  
>  	offset = pdata->dev_desc->prv_offset + LPSS_TX_INT;
> -	reg = readl(pdata->mmio_base + offset);
> -	writel(reg | LPSS_TX_INT_MASK, pdata->mmio_base + offset);
> -
> -	offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
> -	reg = readl(pdata->mmio_base + offset);
> -	writel(reg | LPSS_GENERAL_UART_RTS_OVRD, pdata->mmio_base + offset);
> +	val = readl(pdata->mmio_base + offset);
> +	writel(val | LPSS_TX_INT_MASK, pdata->mmio_base + offset);
> +
> +	val = readl(pdata->mmio_base + LPSS_UART_CPR);
> +	if (!(val & LPSS_UART_CPR_AFCE)) {
> +		offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
> +		val = readl(pdata->mmio_base + offset);
> +		val |= LPSS_GENERAL_UART_RTS_OVRD;
> +		writel(val, pdata->mmio_base + offset);
> +	}
>  }
>  
>  static void byt_i2c_setup(struct lpss_private_data *pdata)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
