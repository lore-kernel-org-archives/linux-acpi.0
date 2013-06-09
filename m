From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: Do not bind to device objects with a driver
 or scan handler
Date: Sun, 09 Jun 2013 08:33:51 +0800
Message-ID: <51B3CD6F.7040606@intel.com>
References: <8441239.yeE1QYIOsS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14155 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab3FIAd1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jun 2013 20:33:27 -0400
In-Reply-To: <8441239.yeE1QYIOsS@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 06/08/2013 10:14 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> With the introduction of ACPI scan handlers, ACPI device objects
> with an ACPI scan handler attached to them must not be bound to
> an ACPI driver any more.  Unfortunately, however, the ACPI video
> driver attempts to do just that if there is a _ROM ACPI control
> method defined under a device object with an ACPI scan handler.
> 
> Prevent that from happening by making the video driver's "add"
> routine check if the device object already has a driver or
> ACPI scan handler attached to it and return an error code in
> that case.  That is not sufficient, though, because
> acpi_bus_driver_init() would then clear the device object's
> driver_data that may be set by the scan handler attached to it,
> so for the fix to work acpi_bus_driver_init() has to be modified
> to leave driver_data as is on errors.

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=58091
> Reported-and-bisected-by: Dmitry S. Demin <dmitryy.demin@gmail.com>
> Reported-and-tested-by: Jason Cassell <bluesloth600@gmail.com>
> Tracked-down-by: Aaron Lu <aaron.lu@intel.com>
> Cc: 3.9+ <stable@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c  |    5 +----
>  drivers/acpi/video.c |    3 +++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/video.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/video.c
> +++ linux-pm/drivers/acpi/video.c
> @@ -1722,6 +1722,9 @@ static int acpi_video_bus_add(struct acp
>  	int error;
>  	acpi_status status;
>  
> +	if (device->handler || device->driver)
> +		return -EINVAL;
> +
>  	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>  				device->parent->handle, 1,
>  				acpi_video_bus_match, NULL,
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1133,11 +1133,8 @@ acpi_bus_driver_init(struct acpi_device
>  		return -ENOSYS;
>  
>  	result = driver->ops.add(device);
> -	if (result) {
> -		device->driver = NULL;
> -		device->driver_data = NULL;
> +	if (result)
>  		return result;
> -	}
>  
>  	device->driver = driver;
>  
> 

