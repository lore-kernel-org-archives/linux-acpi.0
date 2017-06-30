From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH v3] acpi: indicate to platform when hot remove
 returns busy
Date: Fri, 30 Jun 2017 13:49:07 +0800
Message-ID: <20170630054907.GB13714@linux-l9pv.suse>
References: <20170621074544.18436-1-jlee@suse.com>
 <136250372.B1LmTaN194@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <136250372.B1LmTaN194@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Michal Hocko <mhocko@suse.cz>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Jun 29, 2017 at 12:13:18AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 21, 2017 03:45:44 PM Lee, Chun-Yi wrote:
> > In hotplug logic, it always indicates non-specific failure to
> > platform through _OST when handing acpi hot-remove event failed. Then
> > platform terminates the hot-remove process but it can not identify
> > the reason.
> > 
> > Base on current hot-remove code, there have two situations that it
> > returns busy:
> >  - OSPM try to offline an individual device, but the device offline
> >    function returns busy.
> >  - When the ejection event is applied to an "not offlined yet" container.
> >    OSPM send kobject change event to userspace and returns busy.
> > 
> > Both of them will returns -EBUSY to acpi device hotplug function then
> > hotplug function indicates non-specific failure to platform just like
> > any other error, e.g. -ENODEV or -EIO.
> > 
> > The benefit to platform for identifying the OS busy state is that
> > platform can be applied different approach to handle the busy but
> > not just terminate the hot-remove process by unknown reason. For
> > example, platform can wait for a while then triggers hot-remove
> > again.
> > 
> > This RFC patch adds one more parameter to the handler function of
> > acpi generic hotplug event to give the function a chance to propose
> > the return code of _OST. In this case, it sets ost return code to
> > ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
> > -EBUSY.
> > 
> > v3:
> > Removed redundant 'else' in acpi_ost_status_code(). (Andy Shevchenko)
> > 
> > v2:
> > Do not overwrite ost code in acpi_generic_hotplug_event(). Move
> > the "error code to ost code" logic to a help function. (Andy Shevchenko)
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Michal Hocko <mhocko@suse.cz>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  drivers/acpi/scan.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 3a10d7573477..41f5065190c7 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -384,6 +384,20 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
> >  	return -EINVAL;
> >  }
> >  
> > +static int acpi_ost_status_code(u32 src, int error)
> > +{
> > +	switch (src) {
> > +	case ACPI_NOTIFY_EJECT_REQUEST:
> > +	case ACPI_OST_EC_OSPM_EJECT:
> > +		if (error == -EPERM)
> > +			return ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> > +		if (error == -EBUSY)
> > +			return ACPI_OST_SC_DEVICE_BUSY;
> > +		break;
> > +	}
> > +	return error ? ACPI_OST_SC_NON_SPECIFIC_FAILURE : ACPI_OST_SC_SUCCESS;
> > +}
> 
> I'm not sure why you need the function above?
> 
> It only has one user anyway.
>

Because different hotplug source event may has different
OST code definition. So I want to use a function to handle
the the complexity. The originial function like this: 

static int acpi_ost_status_code(u32 src, int error)
{
        switch (src) {
        case ACPI_NOTIFY_EJECT_REQUEST:
        case ACPI_OST_EC_OSPM_EJECT:
                if (error == -EPERM)
                        return ACPI_OST_SC_EJECT_NOT_SUPPORTED;
                if (error == -EBUSY)
                        return ACPI_OST_SC_DEVICE_BUSY;
                break;
        case ACPI_OST_EC_OSPM_INSERTION:
                if (error == -EPERM)
                        return ACPI_OST_SC_INSERT_NOT_SUPPORTED;
                if (error == -EBUSY)
                        return ACPI_OST_SC_INSERT_IN_PROGRESS;
                break;
        }
        return error ? ACPI_OST_SC_NON_SPECIFIC_FAILURE : ACPI_OST_SC_SUCCESS;
}

The ACPI_OST_EC_OSPM_INSERTION represents "Insertion Processing
(Source Event: 0x200)" that it has different ost code definition.
Because the machine supports "Insertion" that has not yet appeared.
So I removed the ACPI_OST_EC_OSPM_INSERTION case block.  
 
> > +
> >  void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> >  {
> >  	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
> > @@ -404,10 +418,6 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> >  		error = dock_notify(adev, src);
> >  	} else if (adev->flags.hotplug_notify) {
> >  		error = acpi_generic_hotplug_event(adev, src);
> > -		if (error == -EPERM) {
> > -			ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> > -			goto err_out;
> > -		}
> >  	} else {
> >  		int (*notify)(struct acpi_device *, u32);
> >  
> > @@ -423,9 +433,8 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> >  		else
> >  			goto out;
> >  	}
> > -	if (!error)
> > -		ost_code = ACPI_OST_SC_SUCCESS;
> 
> I just would do:
> 
>     switch (error) {
>     case 0:
>         ost_code = ACPI_OST_SC_SUCCESS;
>         break;
>     case -EBUSY:
>         ost_code = ACPI_OST_SC_DEVICE_BUSY;
>         break;
>     default:
>         ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
>         break;
>     }
>

Currently the above switch-case works. But if considering
ACPI_OST_EC_OSPM_INSERTION in the future then it's not enough.

Thanks a lot!
Joey Lee
