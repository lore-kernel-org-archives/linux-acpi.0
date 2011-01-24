From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Mon, 24 Jan 2011 08:34:19 +0800
Message-ID: <1295829259.1866.759.camel@rui>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7443 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab1AXAfk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jan 2011 19:35:40 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

the "Rename exported func generate_netlink_event to
thermal_netlink_event" patch is on top of this one.

you'd better either send them in one patch series, or state this in the
email. :)

On Fri, 2011-01-21 at 18:52 +0800, R, Durgadoss wrote:
> Hi Len,
> 
> This patch from Thomas fixes the compile dependency.
> Looks fine as far as I have tested.
> 
> Could you please apply it on top of the old patch ?
> 
> Thanks,
> Durga
> ---
> thermal: Avoid CONFIG_NET compile dependency
> 
> Tested-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: R.Durgadoss <durgadoss.r@intel.com>
> CC: Len Brown <len.brown@intel.com>
> 
Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

> ---
>  drivers/thermal/Kconfig       |    1 -
>  drivers/thermal/thermal_sys.c |  177 ++++++++++++++++++++++-------------------
>  include/linux/thermal.h       |    5 +-
>  3 files changed, 98 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index f7a5dba..bf7c687 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -4,7 +4,6 @@
>  
>  menuconfig THERMAL
>  	tristate "Generic Thermal sysfs driver"
> -	depends on NET
>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
>  	  thermal management. Usually it's made up of one or more thermal
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 7d0e63c..5bbacff 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -32,8 +32,6 @@
>  #include <linux/thermal.h>
>  #include <linux/spinlock.h>
>  #include <linux/reboot.h>
> -#include <net/netlink.h>
> -#include <net/genetlink.h>
>  
>  MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
> @@ -60,6 +58,10 @@ static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  
> +#ifdef CONFIG_NET /* needed for netlink messages */
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
>  static unsigned int thermal_event_seqnum;
>  
>  static struct genl_family thermal_event_genl_family = {
> @@ -76,6 +78,96 @@ static struct genl_multicast_group thermal_event_mcgrp = {
>  static int genetlink_init(void);
>  static void genetlink_exit(void);
>  
> +int generate_netlink_event(u32 orig, enum events event)

> +{
> +	struct sk_buff *skb;
> +	struct nlattr *attr;
> +	struct thermal_genl_event *thermal_event;
> +	void *msg_header;
> +	int size;
> +	int result;
> +
> +	/* allocate memory */
> +	size = nla_total_size(sizeof(struct thermal_genl_event)) + \
> +				nla_total_size(0);
> +
> +	skb = genlmsg_new(size, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	/* add the genetlink message header */
> +	msg_header = genlmsg_put(skb, 0, thermal_event_seqnum++,
> +				 &thermal_event_genl_family, 0,
> +				 THERMAL_GENL_CMD_EVENT);
> +	if (!msg_header) {
> +		nlmsg_free(skb);
> +		return -ENOMEM;
> +	}
> +
> +	/* fill the data */
> +	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT, \
> +			sizeof(struct thermal_genl_event));
> +
> +	if (!attr) {
> +		nlmsg_free(skb);
> +		return -EINVAL;
> +	}
> +
> +	thermal_event = nla_data(attr);
> +	if (!thermal_event) {
> +		nlmsg_free(skb);
> +		return -EINVAL;
> +	}
> +
> +	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
> +
> +	thermal_event->orig = orig;
> +	thermal_event->event = event;
> +
> +	/* send multicast genetlink message */
> +	result = genlmsg_end(skb, msg_header);
> +	if (result < 0) {
> +		nlmsg_free(skb);
> +		return result;
> +	}
> +
> +	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
> +	if (result)
> +		printk(KERN_INFO "failed to send netlink event:%d", result);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(generate_netlink_event);
> +
> +static int genetlink_init(void)
> +{
> +	int result;
> +
> +	result = genl_register_family(&thermal_event_genl_family);
> +	if (result)
> +		return result;
> +
> +	result = genl_register_mc_group(&thermal_event_genl_family,
> +					&thermal_event_mcgrp);
> +	if (result)
> +		genl_unregister_family(&thermal_event_genl_family);
> +	return result;
> +}
> +
> +static void genetlink_exit(void)
> +{
> +	genl_unregister_family(&thermal_event_genl_family);
> +}
> +
> +#else
> +
> +static void genetlink_exit(void) {};
> +static int genetlink_init(void) { return 0; }
> +int generate_netlink_event(u32 orig, enum events event) { return 0; }
> +EXPORT_SYMBOL(generate_netlink_event);
> +
> +#endif /* CONFIG_NET */
> +
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int err;
> @@ -1225,82 +1317,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  
>  EXPORT_SYMBOL(thermal_zone_device_unregister);
>  
> -int generate_netlink_event(u32 orig, enum events event)
> -{
> -	struct sk_buff *skb;
> -	struct nlattr *attr;
> -	struct thermal_genl_event *thermal_event;
> -	void *msg_header;
> -	int size;
> -	int result;
> -
> -	/* allocate memory */
> -	size = nla_total_size(sizeof(struct thermal_genl_event)) + \
> -				nla_total_size(0);
> -
> -	skb = genlmsg_new(size, GFP_ATOMIC);
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	/* add the genetlink message header */
> -	msg_header = genlmsg_put(skb, 0, thermal_event_seqnum++,
> -				 &thermal_event_genl_family, 0,
> -				 THERMAL_GENL_CMD_EVENT);
> -	if (!msg_header) {
> -		nlmsg_free(skb);
> -		return -ENOMEM;
> -	}
> -
> -	/* fill the data */
> -	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT, \
> -			sizeof(struct thermal_genl_event));
> -
> -	if (!attr) {
> -		nlmsg_free(skb);
> -		return -EINVAL;
> -	}
> -
> -	thermal_event = nla_data(attr);
> -	if (!thermal_event) {
> -		nlmsg_free(skb);
> -		return -EINVAL;
> -	}
> -
> -	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
> -
> -	thermal_event->orig = orig;
> -	thermal_event->event = event;
> -
> -	/* send multicast genetlink message */
> -	result = genlmsg_end(skb, msg_header);
> -	if (result < 0) {
> -		nlmsg_free(skb);
> -		return result;
> -	}
> -
> -	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
> -	if (result)
> -		printk(KERN_INFO "failed to send netlink event:%d", result);
> -
> -	return result;
> -}
> -EXPORT_SYMBOL(generate_netlink_event);
> -
> -static int genetlink_init(void)
> -{
> -	int result;
> -
> -	result = genl_register_family(&thermal_event_genl_family);
> -	if (result)
> -		return result;
> -
> -	result = genl_register_mc_group(&thermal_event_genl_family,
> -					&thermal_event_mcgrp);
> -	if (result)
> -		genl_unregister_family(&thermal_event_genl_family);
> -	return result;
> -}
> -
>  static int __init thermal_init(void)
>  {
>  	int result = 0;
> @@ -1316,11 +1332,6 @@ static int __init thermal_init(void)
>  	return result;
>  }
>  
> -static void genetlink_exit(void)
> -{
> -	genl_unregister_family(&thermal_event_genl_family);
> -}
> -
>  static void __exit thermal_exit(void)
>  {
>  	class_unregister(&thermal_class);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 8651556..1c31614 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -127,6 +127,8 @@ struct thermal_zone_device {
>  	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
>  #endif
>  };
> +
> +#ifdef CONFIG_NET
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>  #define THERMAL_GENL_VERSION                    0x01
> @@ -158,6 +160,8 @@ enum {
>  	__THERMAL_GENL_CMD_MAX,
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> +#endif
> +extern int generate_netlink_event(u32 orig, enum events event);
>  
>  struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
>  		const struct thermal_zone_device_ops *, int tc1, int tc2,
> @@ -172,6 +176,5 @@ void thermal_zone_device_update(struct thermal_zone_device *);
>  struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
>  		const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
> -extern int generate_netlink_event(u32 orig, enum events event);
>  
>  #endif /* __THERMAL_H__ */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


