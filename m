From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: Disable explicit power state retrieval on fans
Date: Fri, 11 Dec 2009 11:52:49 +0800
Message-ID: <1260503569.27069.326.camel@rzhang1-desktop>
References: <1257883752-2163-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3098 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299AbZLKDvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Dec 2009 22:51:09 -0500
In-Reply-To: <1257883752-2163-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 2009-11-11 at 04:09 +0800, Matthew Garrett wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=531916 describes a system
> with a _PSC method for the fan that always returns "on". There's no
> benefit in us always requesting the state of the fan when performing
> transitions - we want to do everything we can to ensure that the fan turns
> on when it should do, not risk hardware damage by believing the hardware
> when it tells us the fan is already on. Given that the Leading Other OS(tm)
> works fine on this machine, it seems likely that it behaves in much this
> way.
> 
sounds reasonable.
But how can we get the power state if power resources is not available?

In acpi_bus_get_power, why not make acpi_power_get_inferred_state as the
first choice, instead of evaluating _PSC? like the patch attached.

---
 drivers/acpi/bus.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -190,16 +190,17 @@ int acpi_bus_get_power(acpi_handle handl
 		 * Get the device's power state either directly (via _PSC) or
 		 * indirectly (via power resources).
 		 */
-		if (device->power.flags.explicit_get) {
+
+		if (device->power.flags.power_resources) {
+			result = acpi_power_get_inferred_state(device);
+			if (result)
+				return result;
+		} else if (device->power.flags.explicit_get) {
 			status = acpi_evaluate_integer(device->handle, "_PSC",
 						       NULL, &psc);
 			if (ACPI_FAILURE(status))
 				return -ENODEV;
 			device->power.state = (int)psc;
-		} else if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device);
-			if (result)
-				return result;
 		}
 
 		*state = device->power.state;


> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/fan.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index f419849..835b55e 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -256,6 +256,7 @@ static int acpi_fan_add(struct acpi_device *device)
>  		goto end;
>  	}
>  
> +	device->power.flags.explicit_get = 0;
>  	device->flags.force_power_state = 1;
>  	acpi_bus_set_power(device->handle, state);
>  	device->flags.force_power_state = 0;

at least we should clear the explicit_get flag 6 lines above, i.e.
before getting the fan state?

thanks,
rui

