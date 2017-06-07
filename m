From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] acpi: indicate to platform when hot remove returns
 busy
Date: Wed, 7 Jun 2017 23:24:17 +0800
Message-ID: <20170607152417.GX30622@linux-l9pv.suse>
References: <20170607060727.23712-1-jlee@suse.com>
 <CAHp75VcmMcxVT3LZNU2Vr2qNGigkNUoa3BFJmyE+WSvPG6QCwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39085 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdFGPYf (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 7 Jun 2017 11:24:35 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VcmMcxVT3LZNU2Vr2qNGigkNUoa3BFJmyE+WSvPG6QCwg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Jun 07, 2017 at 11:50:13AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 7, 2017 at 9:07 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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
> > not just terminate the hot-remove process by unknow reason. For
> > example, platform can wait for a while then triggers hot-remove
> > again.
> >
> > This RFC patch adds one more parameter to the handler function of
> > acpi generic hotplug event to give the function a chance to propose
> > the return code of _OST. In this case, it sets ost return code to
> > ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
> > -EBUSY.
> 
> > -static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
> > +static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type,
> > +                                     u32 *ost_code)
> >  {
> > +       int error = -EINVAL;
> > +
> >         switch (type) {
> >         case ACPI_NOTIFY_BUS_CHECK:
> >                 return acpi_scan_bus_check(adev);
> > @@ -389,9 +392,11 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
> >                 }
> >                 acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
> >                                   ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
> > -               return acpi_scan_hot_remove(adev);
> > +               error = acpi_scan_hot_remove(adev);
> > +               if (error == -EBUSY && ost_code)
> > +                       *ost_code = ACPI_OST_SC_DEVICE_BUSY;
> >         }
> > -       return -EINVAL;
> > +       return error;
> >  }
> >
> >  void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> > @@ -413,7 +418,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> >         if (adev->flags.is_dock_station) {
> >                 error = dock_notify(adev, src);
> >         } else if (adev->flags.hotplug_notify) {
> > -               error = acpi_generic_hotplug_event(adev, src);
> > +               error = acpi_generic_hotplug_event(adev, src, &ost_code);
> >                 if (error == -EPERM) {
> >                         ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> 
> Looking again to the code I still think you may easily do all stuff
> here in shorter and cleaner manner.
> Do we anticipate that there will be more callers that would like to
> get ost_code for one specific type of event?
> Above intrusion to the acpi_generic_hotplug_event() looks to me like
> non-generic hack.
>

Thanks for your suggestion, I will use switch-case to handle it in
next version.

I checked the ACPI spec and code path of other events:

 - For the standard nodification, the possible return value:
	- ACPI_NOTIFY_BUS_CHECK: acpi_scan_bus_check() returns 0 or -ENODEV
	- ACPI_NOTIFY_DEVICE_CHECK: acpi_scan_device_check() returns 0, -ENODEV or -EALREADY 
   So, standard notification needs only Success(0) or Non-specific failure(1)
 
 - For docker, currently the dock_notify() only returns 0 or -ENODEV.
	But, actually the handle_eject_request() may returns 0 or -EBUSY, but
	dock_notify() ignored it.
	If there have any machines that it has _OST for dock device, we should
	consider to return ACPI_OST_SC_DEVICE_BUSY to dock. Currently I didn't
	see benefit on this.

 - For additional notify handlers
	I only found acpi_pci_root_scan_dependent() that it always returns 0.

 - There have ACPI_OST_EC_OSPM_INSERTION(0x200) that OSPM didn't support
   It's definded in "Insertion Processing (Source Event: 0x200) Status Codes"
   in spec. It will use specific _OST event.

The event types are used by different acpi devices type. And, there have
the insertion event may shows in the future. I will use a switch-case to
handle the change in acpi_generic_hotplug_event().

Thanks a lot!
Joey Lee
