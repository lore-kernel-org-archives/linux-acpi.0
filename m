From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: undo throttling at exit of forced passive mode
Date: Tue, 19 Jun 2012 09:14:30 +0800
Message-ID: <1340068470.1682.9.camel@rui.sh.intel.com>
References: <1340054964-25685-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56914 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356Ab2FSBMw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2012 21:12:52 -0400
In-Reply-To: <1340054964-25685-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, ACPI <linux-acpi@vger.kernel.org>

On =E4=B8=80, 2012-06-18 at 14:29 -0700, Jacob Pan wrote:
> When a thermal zone is in forced passive mode and temperature is abov=
e
> passive trip point, processors are throttled to various states. Howev=
er,
> when user disables forced passive throttling, the processors could be
> left in throttling state even when temperature is below passive trip
> points.
>=20
> This patch fixes the issue by always undo processor throttling when u=
ser
> exits force passive mode. It is safe in that any subsequent thermal c=
onditions
> will still be handled according to trip point settings
>=20
agreed.

Will re-base this patch on top of my changes.

thanks,
rui

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 022bacb..ea867ff 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -250,10 +250,12 @@ passive_store(struct device *dev, struct device=
_attribute *attr,
>  		mutex_lock(&thermal_list_lock);
>  		list_for_each_entry(cdev, &thermal_cdev_list, node) {
>  			if (!strncmp("Processor", cdev->type,
> -				     sizeof("Processor")))
> +					sizeof("Processor"))) {
>  				thermal_zone_unbind_cooling_device(tz,
>  								   THERMAL_TRIPS_NONE,
>  								   cdev);
> +				cdev->ops->set_cur_state(cdev, 0);
> +			}
>  		}
>  		mutex_unlock(&thermal_list_lock);
>  		tz->passive_delay =3D 0;


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
