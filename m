From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/5] ACPI, PM, Specify lowest allowed state for device
 sleep state
Date: Wed, 16 May 2012 10:58:57 +0800
Message-ID: <1337137137.6493.0.camel@yhuang-dev>
References: <1337052191-19411-1-git-send-email-ying.huang@intel.com>
	 <201205152048.08196.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201205152048.08196.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2012-05-15 at 20:48 +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 15, 2012, Huang Ying wrote:
> > Lower device sleep state can save more power, but has more exit
> > latency too.  Sometimes, to satisfy some power QoS and other
> > requirement, we need to constrain the lowest device sleep state.
> > 
> > In this patch, a parameter to specify lowest allowed state for
> > acpi_pm_device_sleep_state is added.  So that the caller can enforce
> > the constraint via the parameter.
> > 
> > This is needed by PCIe D3cold support, where the lowest power state
> > allowed may be D3_HOT instead of default D3_COLD.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > ---
> >  drivers/acpi/sleep.c       |   24 +++++++++++++++++++-----
> >  drivers/pci/pci-acpi.c     |    3 ++-
> >  drivers/pnp/pnpacpi/core.c |    4 ++--
> >  include/acpi/acpi_bus.h    |    6 +++---
> >  4 files changed, 26 insertions(+), 11 deletions(-)
> > 
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -677,8 +677,9 @@ int acpi_suspend(u32 acpi_state)
> >   *	@dev: device to examine; its driver model wakeup flags control
> >   *		whether it should be able to wake up the system
> >   *	@d_min_p: used to store the upper limit of allowed states range
> > - *	Return value: preferred power state of the device on success, -ENODEV on
> > - *		failure (ie. if there's no 'struct acpi_device' for @dev)
> > + *	@d_max_in: specify the lowest allowed states
> > + *	Return value: preferred power state of the device on success, -ENODEV
> > + *	(ie. if there's no 'struct acpi_device' for @dev) or -EINVAL on failure
> >   *
> >   *	Find the lowest power (highest number) ACPI device power state that
> >   *	device @dev can be in while the system is in the sleep state represented
> > @@ -693,13 +694,15 @@ int acpi_suspend(u32 acpi_state)
> >   *	via @wake.
> >   */
> >  
> > -int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
> > +int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p, int d_max_in)
> >  {
> >  	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> >  	struct acpi_device *adev;
> >  	char acpi_method[] = "_SxD";
> >  	unsigned long long d_min, d_max;
> >  
> > +	if (d_max_in < ACPI_STATE_D0 || d_max_in > ACPI_STATE_D3)
> > +		return -EINVAL;
> >  	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
> >  		printk(KERN_DEBUG "ACPI handle has no context!\n");
> >  		return -ENODEV;
> > @@ -707,8 +710,10 @@ int acpi_pm_device_sleep_state(struct de
> >  
> >  	acpi_method[2] = '0' + acpi_target_sleep_state;
> >  	/*
> > -	 * If the sleep state is S0, we will return D3, but if the device has
> > -	 * _S0W, we will use the value from _S0W
> > +	 * If the sleep state is S0, the lowest limit from ACPI is D3,
> > +	 * but if the device has _S0W, we will use the value from _S0W
> > +	 * as the lowest limit from ACPI.  Finally, we will constrain
> > +	 * the lowest limit with the specified one.
> >  	 */
> >  	d_min = ACPI_STATE_D0;
> >  	d_max = ACPI_STATE_D3;
> > @@ -754,6 +759,15 @@ int acpi_pm_device_sleep_state(struct de
> >  
> >  	if (d_min_p)
> >  		*d_min_p = d_min;
> > +	if (d_max_in < d_min)
> > +		return -EINVAL;
> 
> This check should go before the modification of the variable pointed to by
> d_min_p, so that we don't change things in case the error code is returned.
> 
> Apart from this, the patch looks good to me.

Sure.  Will change this.

Best Regards,
Huang Ying
