From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv3 12/15] Thermal: Register a governor for user space
Date: Mon, 10 Sep 2012 16:37:40 +0800
Message-ID: <1347266260.1682.1080.camel@rui.sh.intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
	 <1346500296-25200-13-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54524 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab2IJIgy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Sep 2012 04:36:54 -0400
In-Reply-To: <1346500296-25200-13-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com

On =E5=85=AD, 2012-09-01 at 17:21 +0530, Durgadoss R wrote:
> This patch registers a governor which will let the
> user land manage the platform thermals. Whenever a
> trip happens, this governor just notifies the user
> space using kobj_uevent().
>=20
Hmm, we can make this governor configurable, not the step_wise (which i=
s
used as the default governor), right?

thanks,
rui

> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
>  include/linux/thermal.h       |    2 ++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 936b025..93672aa 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -130,6 +130,15 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_unregister_governor);
> =20
> +static int notify_user_space(struct thermal_zone_device *tz, int tri=
p)
> +{
> +	mutex_lock(&tz->lock);
> +	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
> +	mutex_unlock(&tz->lock);
> +
> +	return 0;
> +}
> +
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int err;
> @@ -1860,6 +1869,12 @@ static inline int genetlink_init(void) { retur=
n 0; }
>  static inline void genetlink_exit(void) {}
>  #endif /* !CONFIG_NET */
> =20
> +struct thermal_governor thermal_gov_user_space =3D {
> +	.name		=3D USER_SPACE_THERMAL_GOVERNOR,
> +	.throttle	=3D notify_user_space,
> +	.owner		=3D THIS_MODULE,
> +};
> +
>  static int __init thermal_init(void)
>  {
>  	int result =3D 0;
> @@ -1871,6 +1886,8 @@ static int __init thermal_init(void)
>  		mutex_destroy(&thermal_idr_lock);
>  		mutex_destroy(&thermal_list_lock);
>  	}
> +	/* Register a governor to notify user space */
> +	thermal_register_governor(&thermal_gov_user_space);
>  	result =3D genetlink_init();
>  	return result;
>  }
> @@ -1882,6 +1899,7 @@ static void __exit thermal_exit(void)
>  	idr_destroy(&thermal_cdev_idr);
>  	mutex_destroy(&thermal_idr_lock);
>  	mutex_destroy(&thermal_list_lock);
> +	thermal_unregister_governor(&thermal_gov_user_space);
>  	genetlink_exit();
>  }
> =20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2bd9158..aa903dd 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -48,6 +48,8 @@
> =20
>  /* Default Thermal Governor: Does Linear Throttling */
>  #define DEFAULT_THERMAL_GOVERNOR	"step_wise"
> +/* User space Thermal governor */
> +#define USER_SPACE_THERMAL_GOVERNOR	"user_space"
> =20
>  struct thermal_zone_device;
>  struct thermal_cooling_device;


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
