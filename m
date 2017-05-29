From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RFC PATCH v3 5/5] ACPI: button: Always notify kernel space
 using _LID returning value
Date: Mon, 29 May 2017 18:08:09 +0200
Message-ID: <20170529160809.GB28287@mail.corp.redhat.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <6a7418a5300e407ba3227d1c53e173ca5c981ddc.1495804411.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdE2QIP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 May 2017 12:08:15 -0400
Content-Disposition: inline
In-Reply-To: <6a7418a5300e407ba3227d1c53e173ca5c981ddc.1495804411.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>

Hi Lv,

On May 27 2017 or thereabouts, Lv Zheng wrote:
> Both nouveau and i915, the only 2 kernel space lid notification listeners,
> invoke acpi_lid_open() API to obtain _LID returning value instead of using
> the notified value.
> 
> So this patch moves this logic from listeners to lid driver, always notify
> kernel space listeners using _LID returning value.
> 
> This is a no-op cleanup, but facilitates administrators to configure to
> notify kernel drivers with faked lid init states via command line
> "button.lid_notify_init_state=Y".
> 
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <nouveau@lists.freedesktop.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/button.c             | 16 ++++++++++++++--
>  drivers/gpu/drm/i915/intel_lvds.c |  2 +-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 4abf8ae..e047d34 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -119,6 +119,9 @@ static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>  static unsigned long lid_report_interval __read_mostly = 500;
>  module_param(lid_report_interval, ulong, 0644);
>  MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
> +static bool lid_notify_init_state __read_mostly = false;
> +module_param(lid_notify_init_state, bool, 0644);
> +MODULE_PARM_DESC(lid_notify_init_state, "Notify init lid state to kernel drivers after boot/resume");
>  
>  /* --------------------------------------------------------------------------
>                                FS Interface (/proc)
> @@ -224,6 +227,15 @@ static void acpi_lid_notify_state(struct acpi_device *device,
>  	if (state)
>  		pm_wakeup_event(&device->dev, 0);
>  
> +	if (!lid_notify_init_state) {
> +		/*
> +		 * There are cases "state" is not a _LID return value, so
> +		 * correct it before notification.
> +		 */
> +		if (!bios_notify &&
> +		    lid_init_state != ACPI_BUTTON_LID_INIT_METHOD)
> +			state = acpi_lid_evaluate_state(device);
> +	}
>  	acpi_lid_notifier_call(device, state);
>  }
>  
> @@ -572,10 +584,10 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
>  
>  	if (!strncmp(val, "open", sizeof("open") - 1)) {
>  		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> -		pr_info("Notify initial lid state as open\n");
> +		pr_info("Notify initial lid state to users space as open and kernel drivers with _LID return value\n");
>  	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
>  		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> -		pr_info("Notify initial lid state with _LID return value\n");
> +		pr_info("Notify initial lid state to user/kernel space with _LID return value\n");
>  	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
>  		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
>  		pr_info("Do not notify initial lid state\n");
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index 9ca4dc4..8ca9080 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -548,7 +548,7 @@ static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
>  	/* Don't force modeset on machines where it causes a GPU lockup */
>  	if (dmi_check_system(intel_no_modeset_on_lid))
>  		goto exit;
> -	if (!acpi_lid_open()) {
> +	if (!val) {
>  		/* do modeset on next lid open event */
>  		dev_priv->modeset_restore = MODESET_ON_LID_OPEN;
>  		goto exit;

This last hunk should really be in its own patch because the intel GPU
folks would need to apply the rest of the series for their CI suite, and
also because there is no reason for this change to be alongside any
other acpi/button.c change.

Cheers,
Benjamin

> -- 
> 2.7.4
> 
