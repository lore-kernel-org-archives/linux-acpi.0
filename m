From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv3] ACPI-Thermal: Make Thermal trip points writeable
Date: Mon, 09 Apr 2012 13:59:55 +0800
Message-ID: <1333951195.2387.192.camel@rui.sh.intel.com>
References: <1333710717-24691-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5931 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab2DIF71 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Apr 2012 01:59:27 -0400
In-Reply-To: <1333710717-24691-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi, Durga,

On =E4=BA=94, 2012-04-06 at 16:41 +0530, Durgadoss R wrote:
> Some of the thermal drivers using the Generic Thermal Framework
> require (all/some) trip points to be writeable. This patch makes
> the trip point temperatures writeable on a per-trip point basis,
> and modifies the required function call in thermal.c. This patch
> also updates the Documentation to reflect the new change.
>=20
I'm okay with this patch, except some minor comments.

> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
> v1
> * patch1/2: Code for making trip points writeable
> * patch2/2: Change the callee in thermal.c
> v2
> * Make both the changes in a single patch
> * Update Documentation/thermal/sysfs-api.txt
> v3
> * Re-submitting, on top of the latest mainline kernel
> ---
>  Documentation/thermal/sysfs-api.txt |    4 +-
>  drivers/acpi/thermal.c              |    4 +-
>  drivers/thermal/thermal_sys.c       |  112 +++++++++++++++++++++++--=
----------
>  include/linux/thermal.h             |   10 ++-
>  4 files changed, 87 insertions(+), 43 deletions(-)
>=20

> +/**
>   * thermal_zone_device_register - register a new thermal zone device
>   * @type:	the thermal zone device type
>   * @trips:	the number of trip points the thermal zone support
> + * @flag:	a bit string indicating the writeablility of trip points
>   * @devdata:	private device data
>   * @ops:	standard thermal zone device callbacks
>   * @tc1:	thermal coefficient 1 for passive calculations
> @@ -1107,7 +1147,7 @@ EXPORT_SYMBOL(thermal_zone_device_update);
>   * section 11.1.5.1 of the ACPI specification 3.0.
>   */
>  struct thermal_zone_device *thermal_zone_device_register(char *type,
> -	int trips, void *devdata,
> +	int trips, int flag, void *devdata,
>  	const struct thermal_zone_device_ops *ops,
>  	int tc1, int tc2, int passive_delay, int polling_delay)
>  {

Do we need a simple check of the "flag" parameter?
e.g,
if (flag >> trips)
    return -EINVAL;

BTW, should we introduce some helper function like this
THERMAL_SET_TRIP_WRITABLE (trip, flag) flag |=3D 1 << trip;

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
