From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Verify device status after eject
Date: Tue, 26 Mar 2013 14:28:56 +0100
Message-ID: <11870686.7BLgAzWSyu@vostro.rjw.lan>
References: <1363202966-28436-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363202966-28436-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, yinghai@kernel.org, jiang.liu@huawei.com, isimatu.yasuaki@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Wednesday, March 13, 2013 01:29:26 PM Toshi Kani wrote:
> ACPI spec states that the OS evaluates _STA after calling _EJ0
> in order to verify if eject was successful.  Added a check to
> verify if the enabled bit of the status value is cleared after
> _EJ0.
> 
> Note, the present bit is not checked since some FW implementations
> do not clear the present bit until the hardware is physically
> removed.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
> 
> This patch is based on linux-pm.git/bleeding-edge.
> 
> ---
>  drivers/acpi/scan.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4f2265e..31d1242 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -127,6 +127,7 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
>  	struct acpi_object_list arg_list;
>  	union acpi_object arg;
>  	acpi_status status;
> +	unsigned long long sta;
>  
>  	/* If there is no handle, the device node has been unregistered. */
>  	if (!handle) {
> @@ -164,10 +165,25 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
>  		if (status == AE_NOT_FOUND) {
>  			return -ENODEV;
>  		} else {
> -			acpi_handle_warn(handle, "Eject failed\n");
> +			acpi_handle_warn(handle, "Eject failed (0x%x)\n",
> +								status);
>  			return -EIO;
>  		}
>  	}
> +
> +	/*
> +	 * Verify if eject was indeed successful.  If not, log an error
> +	 * message.  No need to call _OST since _EJ0 call was made OK.
> +	 */
> +	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_warn(handle,
> +			"Status check after eject failed (0x%x)\n", status);
> +	} else if (sta & ACPI_STA_DEVICE_ENABLED) {
> +		acpi_handle_warn(handle,
> +			"Eject incomplete - status 0x%llx\n", sta);
> +	}
> +
>  	return 0;
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
