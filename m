From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 05/13] ACPI: thinkpad-acpi: preserve radio state across
 shutdown
Date: Thu, 15 Jan 2009 13:34:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901151332010.4737@localhost.localdomain>
References: <1231650070-21722-6-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:57894 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZAOSo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2009 13:44:27 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDI0055EZMCPAT2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 15 Jan 2009 12:35:01 -0600 (CST)
In-reply-to: <1231650070-21722-6-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Ivo van Doorn <IvDoorn@gmail.com>


Interesting.  So an ACPI method is writing the radio state
to NVRAM and you pick it back up on boot (or resume).

Very nice -- to bad we don't have this method for all laptops.
Len Brown, Intel Open Source Technology Center

On Sun, 11 Jan 2009, Henrique de Moraes Holschuh wrote:

> Store in firmware NVRAM the radio state on machine shutdown for WWAN and
> bluetooth.  Also, try to set the initial boot state of these radios as the
> rfkill default state for their respective classes.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Ivo van Doorn <IvDoorn@gmail.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c |   59 +++++++++++++++++++++++++++++++--
>  1 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index b2c5913..27d709b 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -222,6 +222,7 @@ struct ibm_struct {
>  	void (*exit) (void);
>  	void (*resume) (void);
>  	void (*suspend) (pm_message_t state);
> +	void (*shutdown) (void);
>  
>  	struct list_head all_drivers;
>  
> @@ -759,6 +760,18 @@ static int tpacpi_resume_handler(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void tpacpi_shutdown_handler(struct platform_device *pdev)
> +{
> +	struct ibm_struct *ibm, *itmp;
> +
> +	list_for_each_entry_safe(ibm, itmp,
> +				 &tpacpi_all_drivers,
> +				 all_drivers) {
> +		if (ibm->shutdown)
> +			(ibm->shutdown)();
> +	}
> +}
> +
>  static struct platform_driver tpacpi_pdriver = {
>  	.driver = {
>  		.name = TPACPI_DRVR_NAME,
> @@ -766,6 +779,7 @@ static struct platform_driver tpacpi_pdriver = {
>  	},
>  	.suspend = tpacpi_suspend_handler,
>  	.resume = tpacpi_resume_handler,
> +	.shutdown = tpacpi_shutdown_handler,
>  };
>  
>  static struct platform_driver tpacpi_hwmon_pdriver = {
> @@ -957,7 +971,22 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
>  			int (*get_state)(void *, enum rfkill_state *))
>  {
>  	int res;
> -	enum rfkill_state initial_state;
> +	enum rfkill_state initial_state = RFKILL_STATE_SOFT_BLOCKED;
> +
> +	res = get_state(NULL, &initial_state);
> +	if (res < 0) {
> +		printk(TPACPI_ERR
> +			"failed to read initial state for %s, error %d; "
> +			"will turn radio off\n", name, res);
> +	} else {
> +		/* try to set the initial state as the default for the rfkill
> +		 * type, since we ask the firmware to preserve it across S5 in
> +		 * NVRAM */
> +		rfkill_set_default(rfktype,
> +				(initial_state == RFKILL_STATE_UNBLOCKED) ?
> +					RFKILL_STATE_UNBLOCKED :
> +					RFKILL_STATE_SOFT_BLOCKED);
> +	}
>  
>  	*rfk = rfkill_allocate(&tpacpi_pdev->dev, rfktype);
>  	if (!*rfk) {
> @@ -969,9 +998,7 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
>  	(*rfk)->name = name;
>  	(*rfk)->get_state = get_state;
>  	(*rfk)->toggle_radio = toggle_radio;
> -
> -	if (!get_state(NULL, &initial_state))
> -		(*rfk)->state = initial_state;
> +	(*rfk)->state = initial_state;
>  
>  	res = rfkill_register(*rfk);
>  	if (res < 0) {
> @@ -2943,8 +2970,19 @@ static int tpacpi_bluetooth_rfk_set(void *data, enum rfkill_state state)
>  	return bluetooth_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
>  }
>  
> +static void bluetooth_shutdown(void)
> +{
> +	/* Order firmware to save current state to NVRAM */
> +	if (!acpi_evalf(NULL, NULL, "\\BLTH", "vd",
> +			TP_ACPI_BLTH_SAVE_STATE))
> +		printk(TPACPI_NOTICE
> +			"failed to save bluetooth state to NVRAM\n");
> +}
> +
>  static void bluetooth_exit(void)
>  {
> +	bluetooth_shutdown();
> +
>  	if (tpacpi_bluetooth_rfkill)
>  		rfkill_unregister(tpacpi_bluetooth_rfkill);
>  
> @@ -3050,6 +3088,7 @@ static struct ibm_struct bluetooth_driver_data = {
>  	.write = bluetooth_write,
>  	.exit = bluetooth_exit,
>  	.suspend = bluetooth_suspend,
> +	.shutdown = bluetooth_shutdown,
>  };
>  
>  /*************************************************************************
> @@ -3207,8 +3246,19 @@ static int tpacpi_wan_rfk_set(void *data, enum rfkill_state state)
>  	return wan_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
>  }
>  
> +static void wan_shutdown(void)
> +{
> +	/* Order firmware to save current state to NVRAM */
> +	if (!acpi_evalf(NULL, NULL, "\\WGSV", "vd",
> +			TP_ACPI_WGSV_SAVE_STATE))
> +		printk(TPACPI_NOTICE
> +			"failed to save WWAN state to NVRAM\n");
> +}
> +
>  static void wan_exit(void)
>  {
> +	wan_shutdown();
> +
>  	if (tpacpi_wan_rfkill)
>  		rfkill_unregister(tpacpi_wan_rfkill);
>  
> @@ -3312,6 +3362,7 @@ static struct ibm_struct wan_driver_data = {
>  	.write = wan_write,
>  	.exit = wan_exit,
>  	.suspend = wan_suspend,
> +	.shutdown = wan_shutdown,
>  };
>  
>  /*************************************************************************
> -- 
> 1.5.6.5
> 
