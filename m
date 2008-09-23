From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 3/5] ACPI: EC: Don't degrade to poll mode at storm
	automatically
Date: Tue, 23 Sep 2008 09:03:38 +0800
Message-ID: <1222131818.3999.161.camel@yakui_zhao.sh.intel.com>
References: <200809222137.m8MLbXl5031009@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38097 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbYIWA6k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 20:58:40 -0400
In-Reply-To: <200809222137.m8MLbXl5031009@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, andi@firstfloor.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

On Mon, 2008-09-22 at 14:37 -0700, akpm@linux-foundation.org wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Not all users of semi-broken EC devices want to degrade to poll mode, so
> give them right to choose.
> 
> This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
> "Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
> <http://bugzilla.kernel.org/show_bug.cgi?id=11089>.
This patch is not very reasonable. 
    After the EC GPE storm is detected, which mode to use is decided by
the user.

    If the GPE interrupt mode is still used, maybe the keystrobe will be
lost. For example: bug 9998.

    If the Polling mode is used, sometimes the EC can't be accessed
correctly on some laptops, which brings that the _TMP ACPI object
returns the incorrect temperature. For example: bug 11309.

Thanks.

> 
> The regression was caused by a recently added check for interrupt storms. 
> The Eee PC triggers this check and switches to polling.  When multiple
> events arrive between polling intervals, only one is fetched from the EC. 
> This causes erroneous behaviour; ultimately events stop being delivered
> altogether when the EC buffer overflows.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
> Cc: Maximilian Engelhardt <maxi@daemonizer.de>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  Documentation/kernel-parameters.txt |    5 +++
>  drivers/acpi/ec.c                   |   36 ++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff -puN Documentation/kernel-parameters.txt~acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically Documentation/kernel-parameters.txt
> --- a/Documentation/kernel-parameters.txt~acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically
> +++ a/Documentation/kernel-parameters.txt
> @@ -736,6 +736,11 @@ and is between 256 and 4096 characters. 
>  
>  	eata=		[HW,SCSI]
>  
> +	ec_intr=	[HW,ACPI] ACPI Embedded Controller interrupt mode
> +			Format: <int>
> +			0: polling mode
> +			non-0: interrupt mode (default)
> +
>  	edd=		[EDD]
>  			Format: {"off" | "on" | "skip[mbr]"}
>  
> diff -puN drivers/acpi/ec.c~acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically drivers/acpi/ec.c
> --- a/drivers/acpi/ec.c~acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically
> +++ a/drivers/acpi/ec.c
> @@ -110,6 +110,8 @@ static struct acpi_ec {
>  	u8 handlers_installed;
>  } *boot_ec, *first_ec;
>  
> +int acpi_ec_intr = 1; /* Default is interrupt mode */
> +
>  /* 
>   * Some Asus system have exchanged ECDT data/command IO addresses.
>   */
> @@ -516,12 +518,14 @@ static u32 acpi_ec_gpe_handler(void *dat
>  	acpi_status status = AE_OK;
>  	struct acpi_ec *ec = data;
>  	u8 state = acpi_ec_read_status(ec);
> +	static bool warn_done = false;
>  
>  	pr_debug(PREFIX "~~~> interrupt\n");
>  	atomic_inc(&ec->irq_count);
> -	if (atomic_read(&ec->irq_count) > 5) {
> -		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
> -		ec_switch_to_poll_mode(ec);
> +	if (!warn_done && atomic_read(&ec->irq_count) > 5) {
> +		pr_warning(PREFIX "GPE storm detected, try to use ec_intr=0 "
> +			"kernel option, if you see problems with keyboard.\n");
> +		warn_done = 1;
>  		goto end;
>  	}
>  	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
> @@ -848,20 +852,21 @@ static int ec_install_handlers(struct ac
>  	acpi_status status;
>  	if (ec->handlers_installed)
>  		return 0;
> -	status = acpi_install_gpe_handler(NULL, ec->gpe,
> +	if (acpi_ec_intr) {
> +		status = acpi_install_gpe_handler(NULL, ec->gpe,
>  					  ACPI_GPE_EDGE_TRIGGERED,
>  					  &acpi_ec_gpe_handler, ec);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
> -	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
>  
> +		acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
> +		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> +	}
>  	status = acpi_install_address_space_handler(ec->handle,
>  						    ACPI_ADR_SPACE_EC,
>  						    &acpi_ec_space_handler,
>  						    NULL, ec);
> -	if (ACPI_FAILURE(status)) {
> +	if (ACPI_FAILURE(status) && acpi_ec_intr) {
>  		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
>  		return -ENODEV;
>  	}
> @@ -1047,3 +1052,14 @@ static void __exit acpi_ec_exit(void)
>  	return;
>  }
>  #endif	/* 0 */
> +
> +static int __init acpi_ec_set_intr_mode(char *str)
> +{
> +	if (!get_option(&str, &acpi_ec_intr)) {
> +		acpi_ec_intr = 0;
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +__setup("ec_intr=", acpi_ec_set_intr_mode);
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

