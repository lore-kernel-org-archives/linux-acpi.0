From: joeyli <jlee@suse.com>
Subject: Re: [PATCH v2] acpi: indicate to platform when hot remove returns
 busy
Date: Sat, 10 Jun 2017 08:59:29 +0800
Message-ID: <20170610005929.GL16674@linux-l9pv.suse>
References: <20170609105451.461-1-jlee@suse.com>
 <CAHp75VeA9d5HWD_vyxMvoAG7PWR9nwTi4DL=Vdb9GxLsKzjY-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53920 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdFJA7q (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 9 Jun 2017 20:59:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeA9d5HWD_vyxMvoAG7PWR9nwTi4DL=Vdb9GxLsKzjY-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, Jun 09, 2017 at 06:36:32PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 9, 2017 at 1:54 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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
> 
> Below looks better for my taste.
> See also comments.
> 

Still thanks for your review.

> > +static int acpi_ost_status_code(u32 src, int error)
> > +{
> > +       switch (src) {
> > +       case ACPI_NOTIFY_EJECT_REQUEST:
> > +       case ACPI_OST_EC_OSPM_EJECT:
> 
> > +               if (error == -EPERM)
> > +                       return ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> > +               else if (error == -EBUSY)
> 
> Redundant else...
>

You are right, I will remove it.
 
> > +                       return ACPI_OST_SC_DEVICE_BUSY;
> 
> Perhaps switch case here as well?
> switch (error) {
>  case -EPERM;
>    return X;
>  case -EBUSY:
>    return Y;
> }
>

I want to use the event source as the target of switch because
different event source has different ost_src definition. If I
add the support of insertion event then the code will be like
this:

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
Just we didn't support it in kernel (maybe just didn't see any
machine used it).
 
> > +               break;
> > +       }
> > +       return error ? ACPI_OST_SC_NON_SPECIFIC_FAILURE : ACPI_OST_SC_SUCCESS;
> > +}
> 
> 
> > +       ost_code = acpi_ost_status_code(src, error);
> >   err_out:
> 
> I guess you need to swap those lines.
>

Do you mean move the "err_out:" to the position before
acpi_ost_status_code()? The err_out tag used by the
validation checking of acpi handler that it wants to
jump to evaluate _OST: 

void acpi_device_hotplug(struct acpi_device *adev, u32 src)
{
        u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
        int error = -ENODEV;

        lock_device_hotplug();
        mutex_lock(&acpi_scan_lock);

	/*
	 * The device object's ACPI handle cannot become invalid as long as we
	 * are holding acpi_scan_lock, but it might have become invalid before
	 * that lock was acquired.
	 */
	if (adev->handle == INVALID_ACPI_HANDLE)
		goto err_out;
	[...snip]
> >   err_out:
> >         acpi_evaluate_ost(adev->handle, src, ost_code, NULL);
>

Thanks a lot!
Joey Lee 
