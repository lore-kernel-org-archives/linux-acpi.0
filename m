From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 3/4]  ACPI: Add "acpi.power_nocheck=1" to disable power
	state check in power transitio
Date: Tue, 15 Jul 2008 10:41:01 +0800
Message-ID: <1216089661.19872.48.camel@yakui_zhao.sh.intel.com>
References: <1216021174.32159.22.camel@yakui_zhao.sh.intel.com>
	 <200807141239.04993.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15268 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbYGOC3j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 22:29:39 -0400
In-Reply-To: <200807141239.04993.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-07-14 at 12:39 +0200, Thomas Renninger wrote:
> On Monday 14 July 2008 09:39:34 Zhao Yakui wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> >    Maybe the incorrect power state is returned on the bogus bios, which
> > is different with the real power state. For example: the bios returns D0
> > state and the real power state is D3. OS expects to set the device to D0
> > state. In  such case if OS uses the power state returned by the BIOS and
> > checks the device power state very strictly in power transition, the device
> > can't be transited to the correct power state.
> >
> >    So the boot option of "acpi.power_nocheck=1" is added to avoid checking
> > the device power state in the course of device power transition.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=8049
> > http://bugzilla.kernel.org/show_bug.cgi?id=11000
> >
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> >
> > ---
> >  Documentation/kernel-parameters.txt |    7 ++++++
> >  drivers/acpi/bus.c                  |   14 +++++++++++-
> >  drivers/acpi/power.c                |   42
> > ++++++++++++++++++++++++++---------- include/acpi/acpi_drivers.h         | 
> >   1
> >  4 files changed, 52 insertions(+), 12 deletions(-)
> >
> > Index: linux-2.6/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > +++ linux-2.6/Documentation/kernel-parameters.txt
> > @@ -224,6 +224,13 @@ and is between 256 and 4096 characters.
> >  			The number can be in decimal or prefixed with 0x in hex.
> >  			Warning: Many of these options can produce a lot of
> >  			output and make your system unusable. Be very careful.
> > +	acpi.power_nocheck=	[HW,ACPI]
> > +			Format: 1/0 enable/disable the check of power state.
> > +			On some bogus BIOS the _PSC object/_STA object of
> > +			power resource can't return the correct device power
> > +			state. In such case it is unneccessary to check its
> > +			power state again in power transition.
> > +			1 : disable the power state check
> >
> >  	acpi_pm_good	[X86-32,X86-64]
> >  			Override the pmtimer bug detection: force the kernel
> > Index: linux-2.6/drivers/acpi/power.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/power.c
> > +++ linux-2.6/drivers/acpi/power.c
> > @@ -54,6 +54,14 @@ ACPI_MODULE_NAME("power");
> >  #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
> >  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
> >  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
> > +
> > +#ifdef MODULE_PARAM_PREFIX
> > +#undef MODULE_PARAM_PREFIX
> > +#endif
> > +#define MODULE_PARAM_PREFIX "acpi."
> > +int acpi_power_nocheck;
> > +module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
> > +
> >  static int acpi_power_add(struct acpi_device *device);
> >  static int acpi_power_remove(struct acpi_device *device, int type);
> >  static int acpi_power_resume(struct acpi_device *device);
> > @@ -228,12 +236,18 @@ static int acpi_power_on(acpi_handle han
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> >
> > -	result = acpi_power_get_state(resource->device->handle, &state);
> > -	if (result)
> > -		return result;
> > -	if (state != ACPI_POWER_RESOURCE_STATE_ON)
> > -		return -ENOEXEC;
> > -
> > +	if (!acpi_power_nocheck) {
> > +		/*
> > +		 * If acpi_power_nocheck is set, it is unnecessary to check
> > +		 * the power state after power transition.
> > +		 */
> > +		result = acpi_power_get_state(resource->device->handle,
> > +				&state);
> > +		if (result)
> > +			return result;
> > +		if (state != ACPI_POWER_RESOURCE_STATE_ON)
> > +			return -ENOEXEC;
> > +	}
> >  	/* Update the power resource's _device_ power state */
> >  	resource->device->power.state = ACPI_STATE_D0;
> 
> A fat ACPI_EXCEPTION that the power state is bogus and already point to the 
> acpi.power_nocheck boot param before returning -ENOEXEC would help to find 
> this boot param for affected machines?
Good idea. Before the -ENOEXEC is returned, had better print some
warning message and suggest trying the boot option of
acpi.power_nocheck=1.
> I wonder whether this (acpi.power_nocheck=1) could even get the default, maybe 
> after waiting for reponse about how many machines really show this and why...
We expect that it(acpi.power_nocheck=1) would become the default. But we
will have to wait for response.
> The current implementation sets:
>                device->power.state = ACPI_STATE_UNKNOWN;
> if -ENOEXEC is returned (or other errors happen) thermal management is rather 
> blown up then? Setting a sane default (as you did if the boot param is 
> passed) if things go wrong and print a warning sounds reasonable in general?
Agree. If the device is transited from D3/D0 to Unknown state, it will
be reasonable to print the warning message and suggest trying the boot
option of "acpi.power_nocheck=1". Of course if there is no _ON/_OFF
object, it will be broken BIOS and the boot option of
"acpi.power_nocheck=1" won't solve the problem.

>  
In current upstream kernel after OS turns on/off the power resource
device by evaluating the _ON/_OFF object, OS will check the power
resource state(by evaluating the _STA object) to verify whether the
power resource is really turned on/off. But if the _STA object of power
resource returns the bogus state(For example: always returns the ON
state), OS will fail in power resource transition. Similarly when the
ACPI device is transited from D3 to D0, OS will firstly check the
current device state. If the bogus returns the incorrect device
state(For example: the _PSC object always returns D0) and the current
state is the same with the target state, OS won't transit the device
state again. This is not what we expected.

If the boot option of "acpi.power_nocheck=1" is added, OS won't check
the power state again in the course of power transition and always
assume that the power resource transition is successful (Of course it is
an exception if there is no _ON/_OFF object). At the same time in the
course of transiting the device state, it is unnecessary to check the
current device state by calling the function of acpi_bus_get_power. 
> 
> While going through power.c it looks like there could be more warnings or more 
> better fallbacks added:
> in acpi_power_add():
>        switch (state) {
>         case ACPI_POWER_RESOURCE_STATE_ON:
>                 device->power.state = ACPI_STATE_D0;
>                 break;
>         case ACPI_POWER_RESOURCE_STATE_OFF:
>                 device->power.state = ACPI_STATE_D3;
>                 break;
>         default:
>                 device->power.state = ACPI_STATE_UNKNOWN;
>                 break;
>         }
> The last one is a BIOS bug.
> Also the power state must never be ACPI_STATE_UNKNOWN or the whole driver is 
> rather useless?
> E.g. the check in acpi_power_transition() indicates that if the state is 
> ACPI_STATE_UNKNOWN things are rather broken:
>         if ((device->power.state < ACPI_STATE_D0)
>             || (device->power.state > ACPI_STATE_D3))
>                 return -ENODEV;
> 
> What do you think about this cleanup patch.
> I wonder whether it makes sense to not only throw an error message at places 
> where ACPI_STATE_UNKNOWN is set, but also set ACPI_STATE_D3 (or 
> ACPI_STATE_D0, whatever is expected) and try to keep power resource 
> management up, even on bogus BIOS values?
I think it is OK. Maybe it will also be helpful that OS prints some
error message when -ENOEXEC/-ENODEV is  returned by the function of
acpi_power_on/acpi_power_off_device. For example:

@@ -441,8 +441,12 @@ int acpi_power_transition(struct acpi_de
         */
        for (i = 0; i < tl->count; i++) {
                result = acpi_power_on(tl->handles[i], device);
-               if (result)
+               if (result) {
+                       printk(KERN_WARNING "Failure in power resource %
s "
+                       "ON transition\n",
+                               acpi_ut_get_node_name(tl->handles[i]));
                        goto end;
+               }
        }

        if (device->power.state == state) {
@@ -454,8 +458,12 @@ int acpi_power_transition(struct acpi_de
         */
        for (i = 0; i < cl->count; i++) {
                result = acpi_power_off_device(cl->handles[i], device);
-               if (result)
+               if (result) {
+                       printk(KERN_WARNING "Failure in power resource %
s "
+                       "OFF transition.\n",
+                               acpi_ut_get_node_name(cl->handles[i]));
                        goto end;
+               }
        }


> ---
>  drivers/acpi/power.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> Index: pci-2.6/drivers/acpi/power.c
> ===================================================================
> --- pci-2.6.orig/drivers/acpi/power.c
> +++ pci-2.6/drivers/acpi/power.c
> @@ -337,7 +337,7 @@ int acpi_device_sleep_wake(struct acpi_d
>  	if (ACPI_SUCCESS(status)) {
>  		return 0;
>  	} else if (status != AE_NOT_FOUND) {
> -		printk(KERN_ERR PREFIX "_DSW execution failed\n");
> +		ACPI_EXCEPTION((AE_INFO, status, "_DSW execution failed\n"));
>  		dev->wakeup.flags.valid = 0;
>  		return -ENODEV;
>  	}
> @@ -347,7 +347,7 @@ int acpi_device_sleep_wake(struct acpi_d
>  	in_arg[0].integer.value = enable;
>  	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
>  	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
> -		printk(KERN_ERR PREFIX "_PSW execution failed\n");
> +		ACPI_EXCEPTION((AE_INFO, status, "_PSW execution failed\n"));
>  		dev->wakeup.flags.valid = 0;
>  		return -ENODEV;
>  	}
> @@ -379,7 +379,11 @@ int acpi_enable_wakeup_device_power(stru
>  	for (i = 0; i < dev->wakeup.resources.count; i++) {
>  		int ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
>  		if (ret) {
> -			printk(KERN_ERR PREFIX "Transition power state\n");
> +			/* ToDo make use of acpi_status in acpi_power_on and
> +			 *  others for better error tracking
> +			 */
> +			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
> +					"Transition power state\n"));
>  			dev->wakeup.flags.valid = 0;
>  			return -ENODEV;
>  		}
> @@ -462,8 +466,13 @@ int acpi_power_get_inferred_state(struct
>  			continue;
>  
>  		result = acpi_power_get_list_state(list, &list_state);
> -		if (result)
> +		if (result) {
> +			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
> +					"Could not infer state for"
> +					"power resource [%s]\n",
> +					acpi_device_bid(device)));
>  			return result;
> +		}
>  
>  		if (list_state == ACPI_POWER_RESOURCE_STATE_ON) {
>  			device->power.state = i;
> @@ -680,6 +689,9 @@ static int acpi_power_add(struct acpi_de
>  		device->power.state = ACPI_STATE_D3;
>  		break;
>  	default:
> +		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
> +				"Power resource [%s] returned bogus value\n",
> +				acpi_device_bid(device)));
>  		device->power.state = ACPI_STATE_UNKNOWN;
>  		break;
>  	}
> 
> 
>        Thomas
> 
> >
> > @@ -279,11 +293,17 @@ static int acpi_power_off_device(acpi_ha
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> >
> > -	result = acpi_power_get_state(handle, &state);
> > -	if (result)
> > -		return result;
> > -	if (state != ACPI_POWER_RESOURCE_STATE_OFF)
> > -		return -ENOEXEC;
> > +	if (!acpi_power_nocheck) {
> > +		/*
> > +		 * If acpi_power_nocheck is set, it is unnecessary to check
> > +		 * the power state after power transition.
> > +		 */
> > +		result = acpi_power_get_state(handle, &state);
> > +		if (result)
> > +			return result;
> > +		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
> > +			return -ENOEXEC;
> > +	}
> >
> >  	/* Update the power resource's _device_ power state */
> >  	resource->device->power.state = ACPI_STATE_D3;
> > Index: linux-2.6/include/acpi/acpi_drivers.h
> > ===================================================================
> > --- linux-2.6.orig/include/acpi/acpi_drivers.h
> > +++ linux-2.6/include/acpi/acpi_drivers.h
> > @@ -91,6 +91,7 @@ int acpi_enable_wakeup_device_power(stru
> >  int acpi_disable_wakeup_device_power(struct acpi_device *dev);
> >  int acpi_power_get_inferred_state(struct acpi_device *device);
> >  int acpi_power_transition(struct acpi_device *device, int state);
> > +extern int acpi_power_nocheck;
> >  #endif
> >
> >  /*
> > --------------------------------------------------------------------------
> > Index: linux-2.6/drivers/acpi/bus.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/bus.c
> > +++ linux-2.6/drivers/acpi/bus.c
> > @@ -223,7 +223,19 @@ int acpi_bus_set_power(acpi_handle handl
> >  	/*
> >  	 * Get device's current power state
> >  	 */
> > -	acpi_bus_get_power(device->handle, &device->power.state);
> > +	if (!acpi_power_nocheck) {
> > +		/*
> > +		 * Maybe the incorrect power state is returned on the bogus
> > +		 * bios, which is different with the real power state.
> > +		 * For example: the bios returns D0 state and the real power
> > +		 * state is D3. OS expects to set the device to D0 state. In
> > +		 * such case if OS uses the power state returned by the BIOS,
> > +		 * the device can't be transisted to the correct power state.
> > +		 * So if the acpi_power_nocheck is set, it is unnecessary to
> > +		 * get the power state by calling acpi_bus_get_power.
> > +		 */
> > +		acpi_bus_get_power(device->handle, &device->power.state);
> > +	}
> >  	if ((state == device->power.state) && !device->flags.force_power_state) {
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
> >  				  state));
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

