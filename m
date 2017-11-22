From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [RFC PATCH v6 1/3] ACPI / EC: Fix possible driver order issue
 by moving EC event handling earlier
Date: Wed, 22 Nov 2017 12:52:21 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092636BE5557C@SHSMSX101.ccr.corp.intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
 <cover.1506653046.git.lv.zheng@intel.com>
 <88fd3a8dd4a99d25525b55b8ac5274067ddc4195.1506653046.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdKVMw0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Nov 2017 07:52:26 -0500
In-Reply-To: <88fd3a8dd4a99d25525b55b8ac5274067ddc4195.1506653046.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Lv Zheng
> Sent: Friday, September 29, 2017 10:50 AM
> To: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Rafael J . Wysocki
> <rjw@rjwysocki.net>; Brown, Len <len.brown@intel.com>
> Cc: Zheng, Lv <lv.zheng@intel.com>; Lv Zheng <zetalog@gmail.com>; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: [RFC PATCH v6 1/3] ACPI / EC: Fix possible driver order issue by
> moving EC event handling earlier
> 
> This patch tries to detect EC events earlier after resume, so that if an event
> occurred before invoking acpi_ec_unblock_transactions(), it could be
> detected by acpi_ec_unblock_transactions() which is the earliest EC driver
> call after resume.
> 
> However after the noirq stage, if an event ocurred after
> acpi_ec_unblock_transactions() and before acpi_ec_resume(), there was no
> mean to detect and trigger it right then, but can only detect it and handle it
> after acpi_ec_resume().
> 
> Now the final logic is:
> 1. If ec_freeze_events=Y, event handling is stopped in acpi_ec_suspend(),
>    restarted in acpi_ec_resume();
> 2. If ec_freeze_events=N, event handling is stopped in
>    acpi_ec_block_transactions(), restarted in
>    acpi_ec_unblock_transactions();
> 3. In order to handling the conflict of the edge-trigger nature of EC IRQ
>    and the Linux noirq stage, advance_transaction() is invoked where the
>    event handling is enabled and the noirq stage is ended.
> 
> Known issue:
> 1. Event ocurred between acpi_ec_unblock_transactions() and
>    acpi_ec_resume() may still lead to the order issue. This can only be
>    fixed by adding a periodic detection mechanism during the noirq stage.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
> Tested-by: Luya Tshimbalanga <luya@fedoraproject.org>

I don't know what issue this patch has been tested for. Lv, can you please clarify?

I agree with lv that it can probably fix some issues brought by the device order issue.
And I'll be glad to push this after we have verified it is really helpful.
Lv,
Do you still remember the bug report for the lid issue?

Thanks,
rui
> ---
>  drivers/acpi/ec.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c index df84246..f1f320b
> 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -249,6 +249,11 @@ static bool acpi_ec_started(struct acpi_ec *ec)
>  	       !test_bit(EC_FLAGS_STOPPED, &ec->flags);  }
> 
> +static bool acpi_ec_no_sleep_events(void) {
> +	return acpi_sleep_no_ec_events() && ec_freeze_events; }
> +
>  static bool acpi_ec_event_enabled(struct acpi_ec *ec)  {
>  	/*
> @@ -260,14 +265,14 @@ static bool acpi_ec_event_enabled(struct acpi_ec
> *ec)
>  		return false;
>  	/*
>  	 * However, disabling the event handling is experimental for late
> -	 * stage (suspend), and is controlled by the boot parameter of
> -	 * "ec_freeze_events":
> +	 * stage (suspend), and is controlled by
> +	 * "acpi_ec_no_sleep_events()":
>  	 * 1. true:  The EC event handling is disabled before entering
>  	 *           the noirq stage.
>  	 * 2. false: The EC event handling is automatically disabled as
>  	 *           soon as the EC driver is stopped.
>  	 */
> -	if (ec_freeze_events)
> +	if (acpi_ec_no_sleep_events())
>  		return acpi_ec_started(ec);
>  	else
>  		return test_bit(EC_FLAGS_STARTED, &ec->flags); @@ -524,8
> +529,8 @@ static bool acpi_ec_query_flushed(struct acpi_ec *ec)  static void
> __acpi_ec_flush_event(struct acpi_ec *ec)  {
>  	/*
> -	 * When ec_freeze_events is true, we need to flush events in
> -	 * the proper position before entering the noirq stage.
> +	 * When acpi_ec_no_sleep_events() is true, we need to flush events
> +	 * in the proper position before entering the noirq stage.
>  	 */
>  	wait_event(ec->wait, acpi_ec_query_flushed(ec));
>  	if (ec_query_wq)
> @@ -948,7 +953,8 @@ static void acpi_ec_start(struct acpi_ec *ec, bool
> resuming)
>  		if (!resuming) {
>  			acpi_ec_submit_request(ec);
>  			ec_dbg_ref(ec, "Increase driver");
> -		}
> +		} else if (!acpi_ec_no_sleep_events())
> +			__acpi_ec_enable_event(ec);
>  		ec_log_drv("EC started");
>  	}
>  	spin_unlock_irqrestore(&ec->lock, flags); @@ -980,7 +986,7 @@
> static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
>  		if (!suspending) {
>  			acpi_ec_complete_request(ec);
>  			ec_dbg_ref(ec, "Decrease driver");
> -		} else if (!ec_freeze_events)
> +		} else if (!acpi_ec_no_sleep_events())
>  			__acpi_ec_disable_event(ec);
>  		clear_bit(EC_FLAGS_STARTED, &ec->flags);
>  		clear_bit(EC_FLAGS_STOPPED, &ec->flags); @@ -1910,7
> +1916,7 @@ static int acpi_ec_suspend(struct device *dev)
>  	struct acpi_ec *ec =
>  		acpi_driver_data(to_acpi_device(dev));
> 
> -	if (acpi_sleep_no_ec_events() && ec_freeze_events)
> +	if (acpi_ec_no_sleep_events())
>  		acpi_ec_disable_event(ec);
>  	return 0;
>  }
> @@ -1946,7 +1952,18 @@ static int acpi_ec_resume(struct device *dev)
>  	struct acpi_ec *ec =
>  		acpi_driver_data(to_acpi_device(dev));
> 
> -	acpi_ec_enable_event(ec);
> +	if (acpi_ec_no_sleep_events())
> +		acpi_ec_enable_event(ec);
> +	else {
> +		/*
> +		 * Though whether there is an event pending has been
> +		 * checked in acpi_ec_unblock_transactions() when
> +		 * acpi_ec_no_sleep_events() is false, check it one more
> +		 * time after noirq stage to detect events occurred after
> +		 * acpi_ec_unblock_transactions().
> +		 */
> +		advance_transaction(ec);
> +	}
>  	return 0;
>  }
>  #endif
> --
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
