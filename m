From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / PM: allow deeper wakeup power states with no _SxD nor _SxW
Date: Fri, 23 Mar 2018 00:22:27 +0100
Message-ID: <3441706.zTHvev0s8F@aspire.rjw.lan>
References: <20180320040735.13025-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320040735.13025-1-drake@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com, mathias.nyman@intel.com, linux-usb@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 20, 2018 5:07:35 AM CET Daniel Drake wrote:
> acpi_dev_pm_get_state() is used to determine the range of allowable
> device power states when going into S3 suspend. This is implemented
> by executing the _S3D and _S3W ACPI methods.
> 
> Linux follows the ACPI spec behaviour in that when _S3D is implemented
> and _S3W is not, Linux will not go into a power state deeper than the one
> returned by _S3D for a wakeup-enabled device.
> 
> However, this same logic is being applied to the case when neither
> _S3D nor _S3W are present, and the result is that this function
> decides that the device must stay in D0 (fully on) state.
> 
> This is breaking USB wakeups on Asus V222GA and Acer XC-830. _S3D and
> _S3W are not present, so the USB controller is left in the D0 running
> state during S3, and hence it is unable to generate a PME# wake event.
> 
> The ACPI spec is unclear on which power states are permissable for
> wakeup-enabled devices when both _S3D and _S3W are missing.
> However, USB wakeups work fine on these platforms under Windows, where
> device manager shows that they are using D3 device state for the USB
> controller in S3.
> 
> I assume that the "max = min" clamping done by the code here is
> specifically written for the _S3D but no _S3W case. By making the
> code true to those conditions, avoiding them on these platforms,
> the controller will be put into D3 state and USB wakeups start working.
> 
> Additionally I feel that this change makes the code more directly
> mirror the wording of the ACPI spec and it's associated lack of clarity.
> 
> Thanks to Mathias Nyman for pointing us in the right direction.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Link: http://lkml.kernel.org/r/CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com
> 
> https://phabricator.endlessm.com/T21410
> ---
> 
> Notes:
>     This should be considered for Linux 4.17 to give it a decent amount
>     of testing time before release.
>     
>     v2: fix unused variable warning
> 
>  drivers/acpi/device_pm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c4d0a1c912f0..3d96e4da2d98 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  	unsigned long long ret;
>  	int d_min, d_max;
>  	bool wakeup = false;
> +	bool has_sxd = false;
>  	acpi_status status;
>  
>  	/*
> @@ -581,6 +582,10 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  			else
>  				return -ENODATA;
>  		}
> +
> +		if (status == AE_OK)
> +			has_sxd = true;
> +
>  		d_min = ret;
>  		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
>  			&& adev->wakeup.sleep_state >= target_state;
> @@ -599,7 +604,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  		method[3] = 'W';
>  		status = acpi_evaluate_integer(handle, method, NULL, &ret);
>  		if (status == AE_NOT_FOUND) {
> -			if (target_state > ACPI_STATE_S0)
> +			/* No _SxW. In this case, the ACPI spec says that we
> +			 * must not go into any power state deeper than the
> +			 * value returned from _SxD.
> +			 */
> +			if (has_sxd && target_state > ACPI_STATE_S0)
>  				d_max = d_min;
>  		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
>  			/* Fall back to D3cold if ret is not a valid state. */
> 

Applied, thanks!
