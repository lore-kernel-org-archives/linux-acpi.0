From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/8] ACPI: thermal: Replace pointer with name in trip_points
Date: Mon, 18 Jun 2007 00:38:51 -0400
Message-ID: <200706180038.52066.lenb@kernel.org>
References: <1180761344795-git-send-email-len.brown@intel.com> <68ccfaa8222f2a26f0689fad9e8c0c3f4c19f599.1180761191.git.len.brown@intel.com> <1180974645.28514.99.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54816 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbXFREjD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2007 00:39:03 -0400
In-Reply-To: <1180974645.28514.99.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org

On Monday 04 June 2007 12:30, Thomas Renninger wrote:

> If acpi_bus_get_device(..) fails, device will be NULL.
> I sent another patch checking for that. I couldn't find it, I redid the
> small change and test-booted (machine only has a passive tp, but I could
> see: ...devices=CPU0), seems to work.
> 
> Not sure whether the check is really needed, but I think yes. IIRC I saw
> the warn/err message for this happening ("No context for object..") for
> fan devices in some dmesg.

You'd not get those messages if CONFIG_ACPI_DEBUG=n ;-)

> 
> Thanks,
> 
>    Thomas
> 
> Show devices for active/passive cooling in thermal trip_points file
> 
> Currently the internal pointer to a ACPI handle of a device
> which is used for active/passive cooling at a certain temperature
> is exported to userspace. This pointer isn't of any use for userspace.
> 
> Instead, export the device name, so
> that automated tests (e.g. linuxfirmwarekit) can check whether the
> device (at least fans for active cooling trip points) really get activated
> on the right temperature.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
>  drivers/acpi/thermal.c |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6.22-rc3/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.22-rc3.orig/drivers/acpi/thermal.c
> +++ linux-2.6.22-rc3/drivers/acpi/thermal.c
> @@ -827,6 +827,9 @@ static int acpi_thermal_temp_open_fs(str
>  static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_thermal *tz = seq->private;
> +	struct acpi_device *device;
> +	acpi_status status;
> +
>  	int i = 0;
>  	int j = 0;
>  
> @@ -849,9 +852,10 @@ static int acpi_thermal_trip_seq_show(st
>  			   tz->trips.passive.tc1, tz->trips.passive.tc2,
>  			   tz->trips.passive.tsp);
>  		for (j = 0; j < tz->trips.passive.devices.count; j++) {
> -
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.passive.devices.handles[j]);
> +			status = acpi_bus_get_device(tz->trips.passive.devices.
> +						     handles[j], &device);
> +			seq_printf(seq, "%4.4s ", status ? "" :
> +				   acpi_device_bid(device));

seq_printf() with "%4.4s", NULL) will simply print "<NUL",
so this is a potential cosmetic issue only.

-Len

>  		}
>  		seq_puts(seq, "\n");
>  	}
> @@ -862,9 +866,13 @@ static int acpi_thermal_trip_seq_show(st
>  		seq_printf(seq, "active[%d]:               %ld C: devices=",
>  			   i,
>  			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
> -		for (j = 0; j < tz->trips.active[i].devices.count; j++)
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.active[i].devices.handles[j]);
> +		for (j = 0; j < tz->trips.active[i].devices.count; j++){
> +			status = acpi_bus_get_device(tz->trips.active[i].
> +						     devices.handles[j],
> +						     &device);
> +			seq_printf(seq, "%4.4s ", status ? "" :
> +				   acpi_device_bid(device));
> +		}
>  		seq_puts(seq, "\n");
>  	}
>  
> 
> 
