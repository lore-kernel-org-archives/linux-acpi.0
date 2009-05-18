From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Mon, 18 May 2009 10:08:23 +0800
Message-ID: <1242612503.3685.15.camel@localhost.localdomain>
References: <1242106060.3773.216.camel@localhost.localdomain>
	 <1242265659.3773.428.camel@localhost.localdomain>
	 <20090514105626.GA17294@srcf.ucam.org>
	 <200905141249.35822.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48100 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbZERCHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 May 2009 22:07:08 -0400
In-Reply-To: <200905141249.35822.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>

On Fri, 2009-05-15 at 02:49 +0800, Bjorn Helgaas wrote:
> On Thursday 14 May 2009 04:56:27 am Matthew Garrett wrote:
> > On Thu, May 14, 2009 at 09:47:39AM +0800, yakui_zhao wrote:
> > > On Wed, 2009-05-13 at 21:08 +0800, Matthew Garrett wrote:
> > > > The default behaviour should be to be compatible with Windows, 
> > > > regardless of what the spec says. There's an argument for providing a 
> > > > strict interpretation of the spec for testing purposes, but I don't
> > > > see 
> > > > any reason for it to be split up into dozens of individual kernel 
> > > > parameters
> > > The ACPI 1.0 spec is followed by windows XP. And the power state is not
> > > checked in power transition under windows XP.
> > > But we don't know whether it is still skipped on the new version
> > > windows.(For example: Windows 7).
> > >
> > > If the module param is removed, we must delete the source code related
> > > with power state check. And if the power state is checked in power
> > > transition on windows 7, what we should do? It is not reasonable to add
> > > them again.
> > 
> > If Windows 7 changes the behaviour then the correct approach is to key 
> > this behaviour on whether the system firmware requests the Windows 7 OSI 
> > string. The code can be #if 0ed out until then, or placed under an 
> > acpi.strict kernel option that turns on all standards-compliant but 
> > windows-incompatible code.
> > 
> > > Maybe it is better to determine whether the power state check is skipped
> > > in power transition.
> > 
> > We have a stated policy that Linux will default to being Windows 
> > compatible. You've demonstrated that in this case Linux isn't Windows 
> > compatible, which means that it's a bug. The correct behaviour for Linux 
> > here is to ignore the _STA value (or, indeed, not to call _STA at all in 
> > this path).
> 
> I think we should use a patch like the one below.
> 
> I'd *like* to remove this whole chunk, which would allow us to remove
> acpi_power_nocheck, the DMI table, and the kernel parameter completely:
> 
>         /*
>          * Get device's current power state
>          */
>         if (!acpi_power_nocheck) {
>                 /*
>                  * Maybe the incorrect power state is returned on the bogus
>                  * bios, which is different with the real power state.
>                  * For example: the bios returns D0 state and the real power
>                  * state is D3. OS expects to set the device to D0 state. In
>                  * such case if OS uses the power state returned by the BIOS,
>                  * the device can't be transisted to the correct power state.
>                  * So if the acpi_power_nocheck is set, it is unnecessary to
>                  * get the power state by calling acpi_bus_get_power.
>                  */
>                 acpi_bus_get_power(device->handle, &device->power.state);
>         }
>         if ((state == device->power.state) && !device->flags.force_power_state) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
>                                   state));
>                 return 0;
>         }
> 
> Then we could also remove the "force_power_state" ugliness.  But I'm
> afraid of breaking something because I don't understand the subtleties
> of power transitions.
The flag of "force_power_state" can't be removed. For example: The ACPI
fan is in Off state. But the bogus bios reports that it is in D0 state.
If there is no flag of "force_power_state", we can't turn on the FAN
device.
> 
> 
> ACPI: never check power state after _ON/_OFF
> 
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> We used to evaluate _STA to check the power state of a device after
> running _ON or _OFF.  But as far as I can tell, there's no benefit
> to evaluating _STA, and sometimes we trip over bugs when BIOSes don't
> implement _STA correctly.
> 
> Yakui says Windows XP doesn't evaluate _STA during power transition.
> So let's skip it in Linux, too.
It is also OK that the power state is never checked during power
transition. I verify this on Windows XP. In such case we can delete the
DMI check, kernel parameter, the code related with power state check.

But we don't know whether the power state check is still skipped during
power transition on windows 7.

So IMO the better solution is still to keep the kernel parameter. It
will break nothing. And the default value is to skip the power state
check in power transition.
> 
> References:
>     http://bugzilla.kernel.org/show_bug.cgi?id=13243
>     http://marc.info/?l=linux-acpi&m=124166053803753&w=2
>     http://marc.info/?l=linux-acpi&m=124175761408256&w=2
>     http://marc.info/?l=linux-acpi&m=124210593114061&w=2
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> CC: Yakui Zhao <yakui.zhao@intel.com>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> CC: Witold Szczeponik <Witold.Szczeponik@gmx.net>
> CC: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/power.c |   28 ++--------------------------
>  1 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 56665a6..d74365d 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -194,7 +194,7 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
>  
>  static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0, state;
> +	int result = 0;
>  	int found = 0;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
> @@ -236,18 +236,6 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	if (!acpi_power_nocheck) {
> -		/*
> -		 * If acpi_power_nocheck is set, it is unnecessary to check
> -		 * the power state after power transition.
> -		 */
> -		result = acpi_power_get_state(resource->device->handle,
> -				&state);
> -		if (result)
> -			return result;
> -		if (state != ACPI_POWER_RESOURCE_STATE_ON)
> -			return -ENOEXEC;
> -	}
>  	/* Update the power resource's _device_ power state */
>  	resource->device->power.state = ACPI_STATE_D0;
>  
> @@ -258,7 +246,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  
>  static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0, state;
> +	int result = 0;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
>  	struct list_head *node, *next;
> @@ -293,18 +281,6 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	if (!acpi_power_nocheck) {
> -		/*
> -		 * If acpi_power_nocheck is set, it is unnecessary to check
> -		 * the power state after power transition.
> -		 */
> -		result = acpi_power_get_state(handle, &state);
> -		if (result)
> -			return result;
> -		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
> -			return -ENOEXEC;
> -	}
> -
>  	/* Update the power resource's _device_ power state */
>  	resource->device->power.state = ACPI_STATE_D3;
>  

