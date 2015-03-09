From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: provide con_id for the clkdev
Date: Mon, 09 Mar 2015 16:22:30 +0100
Message-ID: <3532353.A5zUUUFAVv@vostro.rjw.lan>
References: <1425649718-138462-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57839 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752901AbbCIO6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2015 10:58:48 -0400
In-Reply-To: <1425649718-138462-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Friday, March 06, 2015 03:48:38 PM Heikki Krogerus wrote:
> Commit 7d78cbefaa (serial: 8250_dw: add ability to handle
> the peripheral clock) introduces handling for a second clk
> to 8250_dw.c which is the driver also for LPSS UART. The
> second clk forces us to provide identifier (con_id) for the
> clkdev we create.
> 
> This fixes an issue where 8250_dw.c is getting the same
> handler for both clocks.
> 
> Fixes: 7d78cbefaa (serial: 8250_dw: add ability to handle the peripheral clock)
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

"Stable" material I suppose?  3.17 and later or some other set?

> ---
>  drivers/acpi/acpi_lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 657964e..37fb190 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -65,6 +65,7 @@ struct lpss_private_data;
>  
>  struct lpss_device_desc {
>  	unsigned int flags;
> +	const char *clk_con_id;
>  	unsigned int prv_offset;
>  	size_t prv_size_override;
>  	void (*setup)(struct lpss_private_data *pdata);
> @@ -140,6 +141,7 @@ static struct lpss_device_desc lpt_i2c_dev_desc = {
>  
>  static struct lpss_device_desc lpt_uart_dev_desc = {
>  	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
> +	.clk_con_id = "baudclk",
>  	.prv_offset = 0x800,
>  	.setup = lpss_uart_setup,
>  };
> @@ -156,6 +158,7 @@ static struct lpss_device_desc byt_pwm_dev_desc = {
>  
>  static struct lpss_device_desc byt_uart_dev_desc = {
>  	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
> +	.clk_con_id = "baudclk",
>  	.prv_offset = 0x800,
>  	.setup = lpss_uart_setup,
>  };
> @@ -313,7 +316,7 @@ out:
>  		return PTR_ERR(clk);
>  
>  	pdata->clk = clk;
> -	clk_register_clkdev(clk, NULL, devname);
> +	clk_register_clkdev(clk, dev_desc->clk_con_id, devname);
>  	return 0;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
