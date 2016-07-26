From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] ACPI / EC: Add PM operations to block event handling
Date: Tue, 26 Jul 2016 00:11:10 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC07126@SHSMSX101.ccr.corp.intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
 <65a10515fb62e94e6fb91252a3fb49a10a0c860d.1469093001.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15726 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbcGZALU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jul 2016 20:11:20 -0400
In-Reply-To: <65a10515fb62e94e6fb91252a3fb49a10a0c860d.1469093001.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

We have regression report here related to EC.
https://bugzilla.kernel.org/show_bug.cgi?id=135691

After fixing that bug, I found that this patch could be improved on top of the fix.
Making suspend/resume faster.
So please drop [PATCH 2] as I will improve it.

While [PATCH 1] is still valid.
However if you want me to send [PATCH 1] again with the refreshed [PATCH 2], you can drop both.

Sorry for the noise.

Thanks and best regards
-Lv

> From: Zheng, Lv
> Subject: [PATCH 2/2] ACPI / EC: Add PM operations to block event
> handling
> 
> During the early stage for boot/resume, EC shouldn't handle _Qxx as EC
> shouldn't expect the AML interpreter to be fully running and other drivers
> are ready to handle the notifications issued from _Qxx.
> 
> Originally, EC driver stops handling both events and transactions in
> acpi_ec_block_transactions(), and restarts to handle transactions in
> acpi_ec_unblock_transactions_early(), restarts to handle both events and
> transactions in acpi_ec_unblock_transactions().
> 
> However "stop handling events" mean the EC driver notices that the
> system
> is about to suspend, "start handling events" means the EC driver notices
> that the system is about to resume. This can be implemented via PM ops.
> With "event handling switch" implemented via suspend/resume ops, the
> following 2 APIs serve for the same purpose and can be combined:
> acpi_ec_unblock_transactions_early()/acpi_ec_unblock_transactions().
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c       |   63 ++++++++++++++++++++++++++++++++++-----
> --------
>  drivers/acpi/internal.h |    1 -
>  drivers/acpi/sleep.c    |    4 +--
>  3 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c2d135d..6493df8 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -103,6 +103,7 @@ enum ec_command {
>  					 * when trying to clear the EC */
> 
>  enum {
> +	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
>  	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
>  	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check
> */
>  	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
> @@ -423,7 +424,8 @@ static bool
> acpi_ec_submit_flushable_request(struct acpi_ec *ec)
> 
>  static void acpi_ec_submit_query(struct acpi_ec *ec)
>  {
> -	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
> +	if (test_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags) &&
> +	    !test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
>  		ec_dbg_evt("Command(%s) submitted/blocked",
> 
> acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
>  		ec->nr_pending_queries++;
> @@ -440,6 +442,26 @@ static void acpi_ec_complete_query(struct
> acpi_ec *ec)
>  	}
>  }
> 
> +static void acpi_ec_disable_event(struct acpi_ec *ec)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ec->lock, flags);
> +	clear_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags);
> +	ec_log_drv("event blocked");
> +	spin_unlock_irqrestore(&ec->lock, flags);
> +}
> +
> +static void acpi_ec_enable_event(struct acpi_ec *ec)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ec->lock, flags);
> +	set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags);
> +	ec_log_drv("event unblocked");
> +	spin_unlock_irqrestore(&ec->lock, flags);
> +}
> +
>  static bool acpi_ec_guard_event(struct acpi_ec *ec)
>  {
>  	bool guarded = true;
> @@ -913,20 +935,6 @@ void acpi_ec_block_transactions(void)
> 
>  void acpi_ec_unblock_transactions(void)
>  {
> -	struct acpi_ec *ec = first_ec;
> -
> -	if (!ec)
> -		return;
> -
> -	/* Allow transactions to be carried out again */
> -	acpi_ec_start(ec, true);
> -
> -	if (EC_FLAGS_CLEAR_ON_RESUME)
> -		acpi_ec_clear(ec);
> -}
> -
> -void acpi_ec_unblock_transactions_early(void)
> -{
>  	/*
>  	 * Allow transactions to happen again (this function is called from
>  	 * atomic context during wakeup, so we don't need to acquire the
> mutex).
> @@ -1228,13 +1236,13 @@ static struct acpi_ec *make_acpi_ec(void)
> 
>  	if (!ec)
>  		return NULL;
> -	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
>  	mutex_init(&ec->mutex);
>  	init_waitqueue_head(&ec->wait);
>  	INIT_LIST_HEAD(&ec->list);
>  	spin_lock_init(&ec->lock);
>  	INIT_WORK(&ec->work, acpi_ec_event_handler);
>  	ec->timestamp = jiffies;
> +	acpi_ec_disable_event(ec);
>  	return ec;
>  }
> 
> @@ -1415,7 +1423,7 @@ static int acpi_ec_add(struct acpi_device
> *device)
>  	acpi_walk_dep_device_list(ec->handle);
> 
>  	/* EC is fully operational, allow queries */
> -	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
> +	acpi_ec_enable_event(ec);
> 
>  	/* Clear stale _Q events if hardware might require that */
>  	if (EC_FLAGS_CLEAR_ON_RESUME)
> @@ -1659,10 +1667,31 @@ static int acpi_ec_resume_noirq(struct
> device *dev)
>  	acpi_ec_leave_noirq(ec);
>  	return 0;
>  }
> +
> +static int acpi_ec_suspend(struct device *dev)
> +{
> +	struct acpi_ec *ec =
> +		acpi_driver_data(to_acpi_device(dev));
> +
> +	acpi_ec_disable_event(ec);
> +	return 0;
> +}
> +
> +static int acpi_ec_resume(struct device *dev)
> +{
> +	struct acpi_ec *ec =
> +		acpi_driver_data(to_acpi_device(dev));
> +
> +	acpi_ec_enable_event(ec);
> +	if (EC_FLAGS_CLEAR_ON_RESUME)
> +		acpi_ec_clear(ec);
> +	return 0;
> +}
>  #endif
> 
>  static const struct dev_pm_ops acpi_ec_pm = {
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq,
> acpi_ec_resume_noirq)
> +	SET_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend, acpi_ec_resume)
>  };
> 
>  static int param_set_event_clearing(const char *val, struct kernel_param
> *kp)
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 6996121..29f2063 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -189,7 +189,6 @@ int acpi_ec_ecdt_probe(void);
>  int acpi_ec_dsdt_probe(void);
>  void acpi_ec_block_transactions(void);
>  void acpi_ec_unblock_transactions(void);
> -void acpi_ec_unblock_transactions_early(void);
>  int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
>  			      acpi_handle handle, acpi_ec_query_func func,
>  			      void *data);
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2b38c1b..bb1e0d2 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -586,7 +586,7 @@ static int acpi_suspend_enter(suspend_state_t
> pm_state)
>  	 */
>  	acpi_disable_all_gpes();
>  	/* Allow EC transactions to happen. */
> -	acpi_ec_unblock_transactions_early();
> +	acpi_ec_unblock_transactions();
> 
>  	suspend_nvs_restore();
> 
> @@ -784,7 +784,7 @@ static void acpi_hibernation_leave(void)
>  	/* Restore the NVS memory area */
>  	suspend_nvs_restore();
>  	/* Allow EC transactions to happen. */
> -	acpi_ec_unblock_transactions_early();
> +	acpi_ec_unblock_transactions();
>  }
> 
>  static void acpi_pm_thaw(void)
> --
> 1.7.10

