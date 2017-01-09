From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / EC: Use busy polling mode when GPE is not enabled
Date: Mon, 9 Jan 2017 05:26:17 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE27CFF@SHSMSX101.ccr.corp.intel.com>
References: <1483693104-14003-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37341 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760061AbdAIF0V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 00:26:21 -0500
In-Reply-To: <1483693104-14003-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Yu

> From: Chen, Yu C
> Subject: [PATCH] ACPI / EC: Use busy polling mode when GPE is not enabled
> 
> From: Lv Zheng <lv.zheng@intel.com>
> 
> Previously we have report that during system bootup, the EC command
> was running too slow because the EC GPE has not been enabled yet
> (For example, _REG tries to access the EC operation region, while the
> EC GPE has not been enabled at that stage). Actually we can optimize this
> scenario by using busy polling mode if GPE is disabled, which is much
> faster than the default behavior.

I suddenly realized that why I didn't put this check during my previous EC work.
Though this patch can solve the issue in question, it doesn't handle runtime EC polling in a proper way.
Sorry for my damaged memory.

Let me provide a different fix.
So please drop it.

Thanks and best regards
Lv

> 
> Reported-and-tested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 48e19d0..457949d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -342,6 +342,14 @@ static const char *acpi_ec_cmd_string(u8 cmd)
>   *                           GPE Registers
>   * -------------------------------------------------------------------------- */
> 
> +static inline bool acpi_ec_is_gpe_enabled(struct acpi_ec *ec)
> +{
> +	acpi_event_status gpe_status = 0;
> +
> +	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
> +	return (gpe_status & ACPI_EVENT_FLAG_ENABLE_SET) ? true : false;
> +}
> +
>  static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
>  {
>  	acpi_event_status gpe_status = 0;
> @@ -734,7 +742,7 @@ static int ec_guard(struct acpi_ec *ec)
> 
>  	/* Ensure guarding period before polling EC status */
>  	do {
> -		if (ec_busy_polling) {
> +		if (!acpi_ec_is_gpe_enabled(ec) || ec_busy_polling) {
>  			/* Perform busy polling */
>  			if (ec_transaction_completed(ec))
>  				return 0;
> --
> 2.7.4

