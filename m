From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] acpi: indicate to platform when hot remove returns
 busy
Date: Sun, 4 Jun 2017 18:04:53 +0800
Message-ID: <20170604100453.GK30622@linux-l9pv.suse>
References: <20170603172036.7645-1-jlee@suse.com>
 <CAHp75VcBd8e7Ce8KbyqtnoBKv7c5W9qb9o70-oViz6iCoRMShw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51336 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFDKFM (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Sun, 4 Jun 2017 06:05:12 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VcBd8e7Ce8KbyqtnoBKv7c5W9qb9o70-oViz6iCoRMShw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi Andy,

Thanks for your help to review my patch.

On Sat, Jun 03, 2017 at 08:37:51PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 3, 2017 at 8:20 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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
> 
> Wit this change you spear a logic on two functions...
>

You are right.

I want to give a chance to acpi_generic_hotplug_event()
to propose a _OST code. But acpi_device_hotplug() can
overwrite it. Not good...
 
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
> >                         goto err_out;
> 
> ...instead (since the first one is defined as static) I would propose
> to change only here like
> 
> switch (error) {
> case -EPERM:
> ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> break;
> case -EBUSY:
> ost_code = ACPI_OST_SC_DEVICE_BUSY;
> break;
> }
> if (error)
>  goto err_out;
> 
> This is less intrusive and more flexible to modifications in the
> future (might be split to a helper, might be easily extended, etc).
>

this RFC patch changed the _OST code for BIOS that it may affects
the behavior of shipped machines. And, I am not sure that the
ACPI_OST_SC_DEVICE_BUSY approach is also useful for other hotplug
event, like ACPI_NOTIFY_BUS_CHECK or ACPI_NOTIFY_DEVICE_CHECK.

So, I prefer to apply this change only on the code path of
ACPI_NOTIFY_EJECT_REQUEST/ACPI_OST_EC_OSPM_EJECT. 

Here is my first version, that it just simply put if-else logic:

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2433569..b105087 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -414,10 +414,14 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
                error = dock_notify(adev, src);
        } else if (adev->flags.hotplug_notify) {
                error = acpi_generic_hotplug_event(adev, src);
-               if (error == -EPERM) {
+               if (error == -EPERM)
                        ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
+               else if ((error == -EBUSY) &&
+                        (src == ACPI_NOTIFY_EJECT_REQUEST ||
+                         src == ACPI_OST_EC_OSPM_EJECT))
+                       ost_code = ACPI_OST_SC_DEVICE_BUSY;
+               if (error)
                        goto err_out;
-               }
        } else {
                int (*notify)(struct acpi_device *, u32);

Because it checks the event source that the logic is duplicate
with the switch code in acpi_generic_hotplug_event(). So I
reuse the switch code in acpi_generic_hotplug_event().

Thanks a lot!
Joey Lee
