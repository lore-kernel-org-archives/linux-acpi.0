From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/8] ACPI: thermal: Replace pointer with name in
	trip_points
Date: Mon, 04 Jun 2007 18:30:45 +0200
Message-ID: <1180974645.28514.99.camel@queen.suse.de>
References: <1180761344795-git-send-email-len.brown@intel.com>
	 <11807613453368-git-send-email-len.brown@intel.com>
	 <68ccfaa8222f2a26f0689fad9e8c0c3f4c19f599.1180761191.git.len.brown@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hh3Ct0WBoNZKU9Rdr9Ee"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:57901 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749AbXFDQar (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2007 12:30:47 -0400
In-Reply-To: <68ccfaa8222f2a26f0689fad9e8c0c3f4c19f599.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org


--=-hh3Ct0WBoNZKU9Rdr9Ee
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2007-06-02 at 01:15 -0400, Len Brown wrote:
> From: Thomas Renninger <trenn@suse.de>
> 
> For users with active thermal trip points, they need
> the fan's name, rather than its address, to understand
> where to look to observe and control fan state.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/thermal.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 1ada017..194ecfe 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -827,6 +827,7 @@ static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file)
>  static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_thermal *tz = seq->private;
> +	struct acpi_device *device;
>  	int i = 0;
>  	int j = 0;
>  
> @@ -849,9 +850,8 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  			   tz->trips.passive.tc1, tz->trips.passive.tc2,
>  			   tz->trips.passive.tsp);
>  		for (j = 0; j < tz->trips.passive.devices.count; j++) {
> -
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.passive.devices.handles[j]);
> +			acpi_bus_get_device(tz->trips.passive.devices.handles[j], &device);
> +			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
>  		}
>  		seq_puts(seq, "\n");
>  	}
> @@ -862,9 +862,10 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  		seq_printf(seq, "active[%d]:               %ld C: devices=",
>  			   i,
>  			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
> -		for (j = 0; j < tz->trips.active[i].devices.count; j++)
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.active[i].devices.handles[j]);
> +		for (j = 0; j < tz->trips.active[i].devices.count; j++){
> +			acpi_bus_get_device(tz->trips.active[i].devices.handles[j], &device);
> +			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
> +		}

If acpi_bus_get_device(..) fails, device will be NULL.
I sent another patch checking for that. I couldn't find it, I redid the
small change and test-booted (machine only has a passive tp, but I could
see: ...devices=CPU0), seems to work.

Not sure whether the check is really needed, but I think yes. IIRC I saw
the warn/err message for this happening ("No context for object..") for
fan devices in some dmesg.

Len, could you also check for the asus patch I sent you some time ago.
While testing this one, I got kernel Warnings with backtrace because of
a wrong return value in the asus module, should be just replacing return
result with return -ENODEV in the init function. Tell me and I can
resend it.

Thanks,

   Thomas

Show devices for active/passive cooling in thermal trip_points file

Currently the internal pointer to a ACPI handle of a device
which is used for active/passive cooling at a certain temperature
is exported to userspace. This pointer isn't of any use for userspace.

Instead, export the device name, so
that automated tests (e.g. linuxfirmwarekit) can check whether the
device (at least fans for active cooling trip points) really get activated
on the right temperature.

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/thermal.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

Index: linux-2.6.22-rc3/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.22-rc3.orig/drivers/acpi/thermal.c
+++ linux-2.6.22-rc3/drivers/acpi/thermal.c
@@ -827,6 +827,9 @@ static int acpi_thermal_temp_open_fs(str
 static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = seq->private;
+	struct acpi_device *device;
+	acpi_status status;
+
 	int i = 0;
 	int j = 0;
 
@@ -849,9 +852,10 @@ static int acpi_thermal_trip_seq_show(st
 			   tz->trips.passive.tc1, tz->trips.passive.tc2,
 			   tz->trips.passive.tsp);
 		for (j = 0; j < tz->trips.passive.devices.count; j++) {
-
-			seq_printf(seq, "0x%p ",
-				   tz->trips.passive.devices.handles[j]);
+			status = acpi_bus_get_device(tz->trips.passive.devices.
+						     handles[j], &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
 	}
@@ -862,9 +866,13 @@ static int acpi_thermal_trip_seq_show(st
 		seq_printf(seq, "active[%d]:               %ld C: devices=",
 			   i,
 			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
-		for (j = 0; j < tz->trips.active[i].devices.count; j++)
-			seq_printf(seq, "0x%p ",
-				   tz->trips.active[i].devices.handles[j]);
+		for (j = 0; j < tz->trips.active[i].devices.count; j++){
+			status = acpi_bus_get_device(tz->trips.active[i].
+						     devices.handles[j],
+						     &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
+		}
 		seq_puts(seq, "\n");
 	}
 


--=-hh3Ct0WBoNZKU9Rdr9Ee
Content-Disposition: attachment; filename=acpi_show_devices.patch
Content-Type: text/x-patch; name=acpi_show_devices.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Show devices for active/passive cooling in thermal trip_points file

Currently the internal pointer to a ACPI handle of a device
which is used for active/passive cooling at a certain temperature
is exported to userspace. This pointer isn't of any use for userspace.

Instead, export the device name, so
that automated tests (e.g. linuxfirmwarekit) can check whether the
device (at least fans for active cooling trip points) really get activated
on the right temperature.

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/thermal.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

Index: linux-2.6.22-rc3/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.22-rc3.orig/drivers/acpi/thermal.c
+++ linux-2.6.22-rc3/drivers/acpi/thermal.c
@@ -827,6 +827,9 @@ static int acpi_thermal_temp_open_fs(str
 static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = seq->private;
+	struct acpi_device *device;
+	acpi_status status;
+
 	int i = 0;
 	int j = 0;
 
@@ -849,9 +852,10 @@ static int acpi_thermal_trip_seq_show(st
 			   tz->trips.passive.tc1, tz->trips.passive.tc2,
 			   tz->trips.passive.tsp);
 		for (j = 0; j < tz->trips.passive.devices.count; j++) {
-
-			seq_printf(seq, "0x%p ",
-				   tz->trips.passive.devices.handles[j]);
+			status = acpi_bus_get_device(tz->trips.passive.devices.
+						     handles[j], &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
 	}
@@ -862,9 +866,13 @@ static int acpi_thermal_trip_seq_show(st
 		seq_printf(seq, "active[%d]:               %ld C: devices=",
 			   i,
 			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
-		for (j = 0; j < tz->trips.active[i].devices.count; j++)
-			seq_printf(seq, "0x%p ",
-				   tz->trips.active[i].devices.handles[j]);
+		for (j = 0; j < tz->trips.active[i].devices.count; j++){
+			status = acpi_bus_get_device(tz->trips.active[i].
+						     devices.handles[j],
+						     &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
+		}
 		seq_puts(seq, "\n");
 	}
 

--=-hh3Ct0WBoNZKU9Rdr9Ee--

