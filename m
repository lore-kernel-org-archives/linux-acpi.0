From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Check battery after resume
Date: Mon, 07 Aug 2006 17:22:51 +0200
Message-ID: <1154964171.4302.643.camel@queen.suse.de>
References: <1154625457.4302.556.camel@queen.suse.de>
	 <20060803190220.GD11577@redhat.com>
	 <1154699191.4302.610.camel@queen.suse.de>
	 <20060804170919.GL7265@redhat.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tBXMw9ntcfjpO+vmpAby"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:12957 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932143AbWHGPTA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2006 11:19:00 -0400
In-Reply-To: <20060804170919.GL7265@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>


--=-tBXMw9ntcfjpO+vmpAby
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-08-04 at 13:09 -0400, Dave Jones wrote:
> On Fri, Aug 04, 2006 at 03:46:31PM +0200, Thomas Renninger wrote:
>  > On Thu, 2006-08-03 at 15:02 -0400, Dave Jones wrote:
>  > > On Thu, Aug 03, 2006 at 07:17:37PM +0200, Thomas Renninger wrote:
>  > > 
>  > >  > +/* 
>  > >  > + * returns:
>  > >  > + *   0 on success
>  > >  > + *  <0 on failure
>  > >  > + *   1 if new battery found
>  > >  > + *   2 if battery got removed
>  > >  > + */
>  > > 
>  > > Why make this so complicated...
>  > > 
>  > >  > +	result = acpi_battery_check(battery);
>  > >  > +	if (result > 0){
>  > >  > +		acpi_bus_generate_event(device,
>  > >  > +					ACPI_NOTIFY_DEVICE_CHECK,
>  > >  > +					battery->flags.present);
>  > >  > +	}
>  > >  > +	return 0;
>  > >  > +}
>  > > 
>  > > When we simply treat the result as a boolean ?
>  > 
>  > The return value is used to:
>  >    check for error                       <0
>  >    success, no battery insertion/removal 0
>  >    battery insertion/removal             >0  (1/2)
>  > 
>  > The latter one is needed to inform userspace to reread complete battery
>  > information (possibly from other BATx dir) if battery has been
>  > inserted/removed.
> 
> The code cares about 2 possible states 'is there a battery added/removed'.
> Yet there are 4 possible states for no obvious reason.
> acpi_battery_check code could just as easily return
> 0=nothing changed, 1=battery added/removed, as you don't distinguish
> between states '1' and '2' anyway.

But it is already checked for an error at the initial acpi_battery_add
function which is mandatory:
	result = acpi_battery_check(battery);
	if (result < 0)
		goto end;

-> I need three states here: error, success no hw change, success + hw
change.

Thinking about this again, maybe an error should also be checked in the
resume case. It might be that an additional battery is added and the
ACPI code is executed the first time. The user might want to know that
something went wrong... On the other side ACPI code should throw an
exception if something happens during ACPI func execution... not sure
whether the additional printk(KERN_ERR..) is needed, it shouldn't hurt,
though.

Is this OK:
Check battery after resume

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/battery.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int state);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.resume = acpi_battery_resume,
 		},
 };
 
@@ -269,6 +271,13 @@ acpi_battery_set_alarm(struct acpi_batte
 	return 0;
 }
 
+/*
+ * returns:
+ *  <0 on failure
+ *   0 on success, no hw change
+ *   1 on success and battery got inserted/removed
+ */
+
 static int acpi_battery_check(struct acpi_battery *battery)
 {
 	int result = 0;
@@ -311,12 +320,14 @@ static int acpi_battery_check(struct acp
 			battery->flags.alarm = 1;
 			acpi_battery_set_alarm(battery, battery->trips.warning);
 		}
+		result = 1;
 	}
 
 	/* Removal? */
 
 	else if (battery->flags.present && !device->status.battery_present) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Battery removed\n"));
+		result = 1;
 	}
 
 	battery->flags.present = device->status.battery_present;
@@ -703,7 +714,7 @@ static int acpi_battery_add(struct acpi_
 	acpi_driver_data(device) = battery;
 
 	result = acpi_battery_check(battery);
-	if (result)
+	if (result < 0)
 		goto end;
 
 	result = acpi_battery_add_fs(device);
@@ -753,6 +764,33 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+static int acpi_battery_resume(struct acpi_device *device, int state){
+
+	int result = 0;
+	struct acpi_battery *battery = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	battery = (struct acpi_battery *)acpi_driver_data(device);
+
+	result = acpi_battery_check(battery);
+	if (!result){
+		if (result > 0){
+			acpi_bus_generate_event(device,
+						ACPI_NOTIFY_DEVICE_CHECK,
+						battery->flags.present);
+		}
+		else{
+			printk(KERN_ERR "%s Slot [%s]"
+			       " error while checking on resume\n",
+			       ACPI_BATTERY_DEVICE_NAME,
+			       acpi_device_bid(device));
+		}
+	}
+	return 0;
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;


--=-tBXMw9ntcfjpO+vmpAby
Content-Disposition: attachment; filename=battery_resume.patch
Content-Type: text/x-patch; name=battery_resume.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Check battery after resume

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/battery.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int state);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.resume = acpi_battery_resume,
 		},
 };
 
@@ -269,6 +271,13 @@ acpi_battery_set_alarm(struct acpi_batte
 	return 0;
 }
 
+/*
+ * returns:
+ *  <0 on failure
+ *   0 on success, no hw change
+ *   1 on success and battery got inserted/removed
+ */
+
 static int acpi_battery_check(struct acpi_battery *battery)
 {
 	int result = 0;
@@ -311,12 +320,14 @@ static int acpi_battery_check(struct acp
 			battery->flags.alarm = 1;
 			acpi_battery_set_alarm(battery, battery->trips.warning);
 		}
+		result = 1;
 	}
 
 	/* Removal? */
 
 	else if (battery->flags.present && !device->status.battery_present) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Battery removed\n"));
+		result = 1;
 	}
 
 	battery->flags.present = device->status.battery_present;
@@ -703,7 +714,7 @@ static int acpi_battery_add(struct acpi_
 	acpi_driver_data(device) = battery;
 
 	result = acpi_battery_check(battery);
-	if (result)
+	if (result < 0)
 		goto end;
 
 	result = acpi_battery_add_fs(device);
@@ -753,6 +764,33 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+static int acpi_battery_resume(struct acpi_device *device, int state){
+
+	int result = 0;
+	struct acpi_battery *battery = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	battery = (struct acpi_battery *)acpi_driver_data(device);
+
+	result = acpi_battery_check(battery);
+	if (!result){
+		if (result > 0){
+			acpi_bus_generate_event(device,
+						ACPI_NOTIFY_DEVICE_CHECK,
+						battery->flags.present);
+		}
+		else{
+			printk(KERN_ERR "%s Slot [%s]"
+			       " error while checking on resume\n",
+			       ACPI_BATTERY_DEVICE_NAME,
+			       acpi_device_bid(device));
+		}
+	}
+	return 0;
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;

--=-tBXMw9ntcfjpO+vmpAby--

