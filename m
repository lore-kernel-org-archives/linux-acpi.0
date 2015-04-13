From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / scan: Annotate physical_node_lock in acpi_scan_is_offline()
Date: Mon, 13 Apr 2015 16:27:16 +0800
Message-ID: <552B7DE4.3070008@linaro.org>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com> <5219717.RxvSXtBaZ8@vostro.rjw.lan> <12760195.2odgqTkKju@vostro.rjw.lan> <2181841.0nPiIAbDNm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2181841.0nPiIAbDNm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Xie XiuQi <xiexiuqi@huawei.com>, guohanjun@huawei.com, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B404=E6=9C=8811=E6=97=A5 07:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> acpi_scan_is_offline() may be called under the physical_node_lock
> of the given device object's parent, so prevent lockdep from
> complaining about that by annotating that instance with
> SINGLE_DEPTH_NESTING.

I think this is trigged by setting acpi_force_hot_remove to 1,
in acpi_scan_hot_remove():

         if (device->handler && device->handler->hotplug.demand_offline
             && !acpi_force_hot_remove) {
                 if (!acpi_scan_is_offline(device, true))
                         return -EBUSY;
         } else {
                 int error =3D acpi_scan_try_to_offline(device);
                 if (error)
                         return error;
         }

then the container device will be removed by acpi_scan_try_to_offline()=
,
let's wait for Xiuqi's test result.

Thanks
Hanjun

>
> Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/scan.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -298,7 +298,11 @@ bool acpi_scan_is_offline(struct acpi_de
>   	struct acpi_device_physical_node *pn;
>   	bool offline =3D true;
>
> -	mutex_lock(&adev->physical_node_lock);
> +	/*
> +	 * acpi_container_offline() calls this for all of the container's
> +	 * children under the container's physical_node_lock lock.
> +	 */
> +	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
>
>   	list_for_each_entry(pn, &adev->physical_node_list, node)
>   		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
>
