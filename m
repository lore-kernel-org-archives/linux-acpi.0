From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two patches
 in bug 10724 & 11428]
Date: Mon, 08 Sep 2008 12:19:32 +0400
Message-ID: <48C4E014.1030002@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	<20080901122158.GB21970@khazad-dum.debian.net>	<48BC522D.60905@suse.de>	<48BC57C9.2040409@suse.de>	<1220421722.4007.4.camel@yakui_zhao.sh.intel.com>	<48BE32AF.0@suse.de>	<1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	<48BE427C.3070204@suse.de>	<1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	<48BF07E1.8080304@suse.de>	<1220497095.4007.76.camel@yakui_zhao.sh.intel.com>	<48BF6969.2040602@suse.de> <20080905130741.5a67bfdf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55751 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751493AbYIHITg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 04:19:36 -0400
In-Reply-To: <20080905130741.5a67bfdf.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yakui.zhao@intel.com, hmh@hmh.eng.br, linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Andrew,

yes to both questions. This patch hopefully solves the problem better.

Thanks,
Alex.

Andrew Morton wrote:
> On Thu, 04 Sep 2008 08:51:53 +0400
> Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> 
>> [fast_transaction.patch  text/x-diff (9.9KB)]
>> ACPI: EC: do transaction from interrupt context
>>
>> From:  <>
>>
>> It is easier and faster to do transaction directly from interrupt context
>> rather than waking control thread.
> 
> This change broke
> acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch, below.
> 
> Is acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch now
> obsolete?  Is the regression which
> acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch fixed
> now fixed?
> 
> Thanks.
> 
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Not all users of semi-broken EC devices want to degrade to poll mode, so
> give them right to choose.
> 
> This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
> "Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
> <http://bugzilla.kernel.org/show_bug.cgi?id=11089>.
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
> @@ -741,6 +741,11 @@ and is between 256 and 4096 characters. 
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
> +	static bool warn_done = 0;
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
> 

