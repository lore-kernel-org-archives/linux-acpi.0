From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] acpi: indicate to platform when hot remove returns
 busy
Date: Mon, 5 Jun 2017 13:44:27 +0800
Message-ID: <20170605054427.GM30622@linux-l9pv.suse>
References: <20170603172036.7645-1-jlee@suse.com>
 <CAHp75VcBd8e7Ce8KbyqtnoBKv7c5W9qb9o70-oViz6iCoRMShw@mail.gmail.com>
 <20170604100453.GK30622@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56915 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdFEFok (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Mon, 5 Jun 2017 01:44:40 -0400
Content-Disposition: inline
In-Reply-To: <20170604100453.GK30622@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sun, Jun 04, 2017 at 06:04:53PM +0800, joeyli wrote:
> Hi Andy,
> 
> Thanks for your help to review my patch.
> 
> On Sat, Jun 03, 2017 at 08:37:51PM +0300, Andy Shevchenko wrote:
> > On Sat, Jun 3, 2017 at 8:20 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > In hotplug logic, it always indicates non-specific failure to
> > > platform through _OST when handing acpi hot-remove event failed. Then
> > > platform terminates the hot-remove process but it can not identify
> > > the reason.
[...snip]
> > >  }
> > 
> > Wit this change you spear a logic on two functions...
> >
> 
> You are right.
> 
> I want to give a chance to acpi_generic_hotplug_event()
> to propose a _OST code. But acpi_device_hotplug() can
> overwrite it. Not good...
>  
> > >
> > >  void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> > > @@ -413,7 +418,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> > >         if (adev->flags.is_dock_station) {
> > >                 error = dock_notify(adev, src);
> > >         } else if (adev->flags.hotplug_notify) {
> > > -               error = acpi_generic_hotplug_event(adev, src);
> > > +               error = acpi_generic_hotplug_event(adev, src, &ost_code);
> > >                 if (error == -EPERM) {
> > >                         ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> > >                         goto err_out;
> > 
> > ...instead (since the first one is defined as static) I would propose
> > to change only here like
> > 
> > switch (error) {
> > case -EPERM:
> > ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> > break;
> > case -EBUSY:
> > ost_code = ACPI_OST_SC_DEVICE_BUSY;
> > break;
> > }
> > if (error)
> >  goto err_out;
> > 
> > This is less intrusive and more flexible to modifications in the
> > future (might be split to a helper, might be easily extended, etc).
> >
> 
> this RFC patch changed the _OST code for BIOS that it may affects
> the behavior of shipped machines. And, I am not sure that the
> ACPI_OST_SC_DEVICE_BUSY approach is also useful for other hotplug
> event, like ACPI_NOTIFY_BUS_CHECK or ACPI_NOTIFY_DEVICE_CHECK.
> 
> So, I prefer to apply this change only on the code path of
> ACPI_NOTIFY_EJECT_REQUEST/ACPI_OST_EC_OSPM_EJECT. 
> 

Actually I forgot to mention one thing.  The ACPI_OST_SC_DEVICE_BUSY ost
code is specific for ejection events, ACPI_NOTIFY_EJECT_REQUEST (0x03) and
ACPI_OST_EC_OSPM_EJECT (0x103). Reference "Table 6-187" in ACPI spec v6.1.

Thanks a lot!
Joey Lee
