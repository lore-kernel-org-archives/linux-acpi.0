From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [FIX PATCH] ACPI/AC: Add sleep quirk for Thinkpad e530
Date: Wed, 08 May 2013 01:54:48 +0200
Message-ID: <1623264.1zFYjzoa3n@vostro.rjw.lan>
References: <1367843253-13021-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37700 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123Ab3EGXqY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 19:46:24 -0400
In-Reply-To: <1367843253-13021-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, May 06, 2013 08:27:33 PM Lan Tianyu wrote:
> Thinkpad e530 bios notify ac device first and then sleep
> a specific time before doing actual operations in the
> EC event handler(_Qxx). This will cause the AC state
> reported by ACPI event.
> 
> Method (_Q27, 0, NotSerialized)
> {
>       Notify (AC, 0x80)
>       Sleep (0x03E8)
>       Store (Zero, PWRS)
>       PNOT ()
> }
> 
> This patch is to add a 1s sleep in the ac driver's
> notify handler before acpi_ac_get_state() to make
> sure get right state.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=45221
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/ac.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 6d5bf64..0292cbb 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -28,6 +28,8 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> +#include <linux/dmi.h>
> +#include <linux/delay.h>
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> @@ -74,6 +76,8 @@ static int acpi_ac_resume(struct device *dev);
>  #endif
>  static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
>  
> +static int ac_flag_sleep_for_get_state;

Hmm.  Why don't you replace ac_flag_sleep_for_get_state with the time
to sleep in acpi_ac_notify(), something like ac_sleep_before_get_state_ms
and then do something like this ->

> +
>  static struct acpi_driver acpi_ac_driver = {
>  	.name = "ac",
>  	.class = ACPI_AC_CLASS,
> @@ -252,6 +256,15 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>  	case ACPI_AC_NOTIFY_STATUS:
>  	case ACPI_NOTIFY_BUS_CHECK:
>  	case ACPI_NOTIFY_DEVICE_CHECK:
> +		/* Some buggy bios notify ac device first and then sleep
> +		 * a specific time before doing actual operations in the
> +		 * EC event handler(_Qxx). This will cause the AC state
> +		 * reported by ACPI event wrong. So add a 1s sleep here
> +		 * to ensure get correct state.
> +		 */
> +		if (ac_flag_sleep_for_get_state)
> +			msleep(1000);

-> if (ac_sleep_before_get_state_ms > 0)
			msleep(ac_sleep_before_get_state_ms);

and *then* set ac_sleep_before_get_state_ms to 1000 in the Thinkpad e530
specific quirk?

If we find another machine having this problem in the future, but needing
a different sleep time, it will be easier to add it to the blacklist in that
case.

Thanks,
Rafael


> +
>  		acpi_ac_get_state(ac);
>  		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
> @@ -264,6 +277,24 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>  	return;
>  }
>  
> +static int ac_sleep_for_get_state(const struct dmi_system_id *d)
> +{
> +	ac_flag_sleep_for_get_state = 1;
> +	return 0;
> +}
> +
> +static struct dmi_system_id __initdata ac_dmi_table[] = {
> +	{
> +	.callback = ac_sleep_for_get_state,
> +	.ident = "thinkpad e530",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
> +		},
> +	},
> +	{},
> +};
> +
>  static int acpi_ac_add(struct acpi_device *device)
>  {
>  	int result = 0;
> @@ -312,6 +343,7 @@ static int acpi_ac_add(struct acpi_device *device)
>  		kfree(ac);
>  	}
>  
> +	dmi_check_system(ac_dmi_table);
>  	return result;
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
