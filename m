From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 14:14:44 +0800
Message-ID: <1348726484.10877.278.camel@rui.sh.intel.com>
References: <1348726083-8540-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3180 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab2I0GOF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 02:14:05 -0400
In-Reply-To: <1348726083-8540-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, dan.carpenter@oracle.com, hughd@google.com, linux-next@vger.kernel.org

On =E5=9B=9B, 2012-09-27 at 11:38 +0530, Durgadoss R wrote:
> This patch fixes the following mutex and NULL pointer
> problems in thermal_sys.c:
>  * mutex_unlock fix in update_temperature function
>  * mutex_unlock/NULL check fix in bind_cdev function
>  * NULL check fix in bind_tz function
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 4f77d89..848553d 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -252,8 +252,8 @@ static void bind_cdev(struct thermal_cooling_devi=
ce *cdev)
>  		}
> =20
>  		tzp =3D pos->tzp;
> -		if (!tzp->tbp)
> -			return;
> +		if (!tzp || !tzp->tbp)
> +			continue;
> =20
>  		for (i =3D 0; i < tzp->num_tbps; i++) {
>  			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> @@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device *t=
z)
>  		goto exit;
>  	}
> =20
> -	if (!tzp->tbp)
> +	if (!tzp || !tzp->tbp)
>  		goto exit;
> =20
actually, this is not a problem.
I checked the code just now, tzp can not be NULL if the code runs here.

>  	list_for_each_entry(pos, &thermal_cdev_list, node) {
> @@ -390,12 +390,13 @@ static void update_temperature(struct thermal_z=
one_device *tz)
>  	ret =3D tz->ops->get_temp(tz, &temp);
>  	if (ret) {
>  		pr_warn("failed to read out thermal zone %d\n", tz->id);
> -		return;
> +		goto exit;
>  	}
> =20
>  	tz->last_temperature =3D tz->temperature;
>  	tz->temperature =3D temp;
> =20
> +exit:
>  	mutex_unlock(&tz->lock);
>  }
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
