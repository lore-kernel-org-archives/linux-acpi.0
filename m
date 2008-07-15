From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/4]  ACPI: Add "acpi.power_nocheck=1" to disable power
	state check in power transitio
Date: Tue, 15 Jul 2008 10:51:29 +0800
Message-ID: <1216090289.1617.102.camel@rzhang-dt>
References: <1216021174.32159.22.camel@yakui_zhao.sh.intel.com>
	 <200807141239.04993.trenn@suse.de>
	 <1216089661.19872.48.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16291 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761433AbYGOCwe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 22:52:34 -0400
In-Reply-To: <1216089661.19872.48.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 2008-07-15 at 10:41 +0800, Zhao Yakui wrote:
> On Mon, 2008-07-14 at 12:39 +0200, Thomas Renninger wrote:
> > On Monday 14 July 2008 09:39:34 Zhao Yakui wrote:
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > >
> > >    Maybe the incorrect power state is returned on the bogus bios, which
> > > is different with the real power state. For example: the bios returns D0
> > > state and the real power state is D3. OS expects to set the device to D0
> > > state. In  such case if OS uses the power state returned by the BIOS and
> > > checks the device power state very strictly in power transition, the device
> > > can't be transited to the correct power state.
> > >
> > >    So the boot option of "acpi.power_nocheck=1" is added to avoid checking
> > > the device power state in the course of device power transition.
> > >
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8049
> > > http://bugzilla.kernel.org/show_bug.cgi?id=11000
> > >
> > > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> > >
> > > ---
> > >  Documentation/kernel-parameters.txt |    7 ++++++
> > >  drivers/acpi/bus.c                  |   14 +++++++++++-
> > >  drivers/acpi/power.c                |   42
> > > ++++++++++++++++++++++++++---------- include/acpi/acpi_drivers.h         | 
> > >   1
> > >  4 files changed, 52 insertions(+), 12 deletions(-)
> > >
> > > Index: linux-2.6/Documentation/kernel-parameters.txt
> > > ===================================================================
> > > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > > +++ linux-2.6/Documentation/kernel-parameters.txt
> > > @@ -224,6 +224,13 @@ and is between 256 and 4096 characters.
> > >  			The number can be in decimal or prefixed with 0x in hex.
> > >  			Warning: Many of these options can produce a lot of
> > >  			output and make your system unusable. Be very careful.
> > > +	acpi.power_nocheck=	[HW,ACPI]
> > > +			Format: 1/0 enable/disable the check of power state.
> > > +			On some bogus BIOS the _PSC object/_STA object of
> > > +			power resource can't return the correct device power
> > > +			state. In such case it is unneccessary to check its
> > > +			power state again in power transition.
> > > +			1 : disable the power state check
> > >
> > >  	acpi_pm_good	[X86-32,X86-64]
> > >  			Override the pmtimer bug detection: force the kernel
> > > Index: linux-2.6/drivers/acpi/power.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/power.c
> > > +++ linux-2.6/drivers/acpi/power.c
> > > @@ -54,6 +54,14 @@ ACPI_MODULE_NAME("power");
> > >  #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
> > >  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
> > >  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
> > > +
> > > +#ifdef MODULE_PARAM_PREFIX
> > > +#undef MODULE_PARAM_PREFIX
> > > +#endif
> > > +#define MODULE_PARAM_PREFIX "acpi."
> > > +int acpi_power_nocheck;
> > > +module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
> > > +
> > >  static int acpi_power_add(struct acpi_device *device);
> > >  static int acpi_power_remove(struct acpi_device *device, int type);
> > >  static int acpi_power_resume(struct acpi_device *device);
> > > @@ -228,12 +236,18 @@ static int acpi_power_on(acpi_handle han
> > >  	if (ACPI_FAILURE(status))
> > >  		return -ENODEV;
> > >
> > > -	result = acpi_power_get_state(resource->device->handle, &state);
> > > -	if (result)
> > > -		return result;
> > > -	if (state != ACPI_POWER_RESOURCE_STATE_ON)
> > > -		return -ENOEXEC;
> > > -
> > > +	if (!acpi_power_nocheck) {
> > > +		/*
> > > +		 * If acpi_power_nocheck is set, it is unnecessary to check
> > > +		 * the power state after power transition.
> > > +		 */
> > > +		result = acpi_power_get_state(resource->device->handle,
> > > +				&state);
> > > +		if (result)
> > > +			return result;
> > > +		if (state != ACPI_POWER_RESOURCE_STATE_ON)
> > > +			return -ENOEXEC;
> > > +	}
> > >  	/* Update the power resource's _device_ power state */
> > >  	resource->device->power.state = ACPI_STATE_D0;
> > 
> > A fat ACPI_EXCEPTION that the power state is bogus and already point to the 
> > acpi.power_nocheck boot param before returning -ENOEXEC would help to find 
> > this boot param for affected machines?
> Good idea. Before the -ENOEXEC is returned, had better print some
> warning message and suggest trying the boot option of
> acpi.power_nocheck=1.
> > I wonder whether this (acpi.power_nocheck=1) could even get the default, maybe 
> > after waiting for reponse about how many machines really show this and why...

Yes. that's what we want to do at the beginning.
Currently, using acpi.power_nocheck=1 by default without many tests is
too aggressive. But some warning messages being printed out when the
driver doesn't work with acpi.power_nocheck=0 will help a lot. :)

thanks,
rui


