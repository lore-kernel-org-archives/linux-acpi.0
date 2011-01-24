From: Zhang Rui <rui.zhang@intel.com>
Subject: re: Rename exported func generate_netlink_event to
 thermal_netlink_event
Date: Mon, 24 Jan 2011 08:24:13 +0800
Message-ID: <1295828653.1866.751.camel@rui>
References: <D6D887BA8C9DFF48B5233887EF046541094482F503@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15062 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab1AXAZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jan 2011 19:25:36 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094482F503@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2011-01-21 at 18:49 +0800, R, Durgadoss wrote:
> Hi Len,
> 
> I tested this patch from Thomas.
> This works fine for me.
> 
> Could you please apply this on top of the old patch?
> 
> Thanks,
> Durga
> --------------------------------------------
> thermal: Rename exported func generate_netlink_event to thermal_netlink_event
> 
> Tested-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: R.Durgadoss <durgadoss.r@intel.com>
> CC: Len Brown <len.brown@intel.com>
> 
Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/thermal/thermal_sys.c |    8 ++++----
>  include/linux/thermal.h       |    2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 5bbacff..02283f3 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -78,7 +78,7 @@ static struct genl_multicast_group thermal_event_mcgrp = {
>  static int genetlink_init(void);
>  static void genetlink_exit(void);
>  
> -int generate_netlink_event(u32 orig, enum events event)
> +int thermal_netlink_event(u32 orig, enum events event)
>  {
>  	struct sk_buff *skb;
>  	struct nlattr *attr;
> @@ -137,7 +137,7 @@ int generate_netlink_event(u32 orig, enum events event)
>  
>  	return result;
>  }
> -EXPORT_SYMBOL(generate_netlink_event);
> +EXPORT_SYMBOL(thermal_netlink_event);
>  
>  static int genetlink_init(void)
>  {
> @@ -163,8 +163,8 @@ static void genetlink_exit(void)
>  
>  static void genetlink_exit(void) {};
>  static int genetlink_init(void) { return 0; }
> -int generate_netlink_event(u32 orig, enum events event) { return 0; }
> -EXPORT_SYMBOL(generate_netlink_event);
> +int thermal_netlink_event(u32 orig, enum events event) { return 0; }
> +EXPORT_SYMBOL(thermal_netlink_event);
>  
>  #endif /* CONFIG_NET */
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 1c31614..c24756e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -161,7 +161,7 @@ enum {
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
>  #endif
> -extern int generate_netlink_event(u32 orig, enum events event);
> +extern int thermal_netlink_event(u32 orig, enum events event);
>  
>  struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
>  		const struct thermal_zone_device_ops *, int tc1, int tc2,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


