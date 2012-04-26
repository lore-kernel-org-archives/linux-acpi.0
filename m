From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 3/4] ACPI: Add _OST support for ACPI CPU hotplug
Date: Thu, 26 Apr 2012 11:20:49 -0600
Message-ID: <1335460849.18142.4.camel@misato.fc.hp.com>
References: <1334096510-17319-1-git-send-email-toshi.kani@hp.com>
	 <1334096510-17319-4-git-send-email-toshi.kani@hp.com>
	 <CAErSpo5n22TLo+U3f_zHdkZSG=e7x4bySFPWtxT+ghYyenGc6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:41453 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2DZRXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Apr 2012 13:23:09 -0400
In-Reply-To: <CAErSpo5n22TLo+U3f_zHdkZSG=e7x4bySFPWtxT+ghYyenGc6A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2012-04-26 at 09:22 -0600, Bjorn Helgaas wrote:
> On Tue, Apr 10, 2012 at 4:21 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> > Changed acpi_processor_hotplug_notify() to call ACPI _OST method
> > when ACPI-based CPU hotplug operation completed.
> >
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  drivers/acpi/processor_driver.c |   28 ++++++++++++++++++++--------
> >  1 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 0734086..5d9b5a8 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -701,9 +701,9 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
> >  {
> >        struct acpi_processor *pr;
> >        struct acpi_device *device = NULL;
> > +       u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
> >        int result;
> >
> > -
> >        switch (event) {
> >        case ACPI_NOTIFY_BUS_CHECK:
> >        case ACPI_NOTIFY_DEVICE_CHECK:
> > @@ -715,14 +715,18 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
> >                if (!is_processor_present(handle))
> >                        break;
> >
> > -               if (acpi_bus_get_device(handle, &device)) {
> > -                       result = acpi_processor_device_add(handle, &device);
> > -                       if (result)
> > -                               printk(KERN_ERR PREFIX
> > -                                           "Unable to add the device\n");
> > +               if (!acpi_bus_get_device(handle, &device))
> > +                       break;
> > +
> > +               result = acpi_processor_device_add(handle, &device);
> > +               if (result) {
> > +                       printk(KERN_ERR PREFIX "Unable to add the device\n");
> 
> You didn't add this problem, but since you're touching the code, I'll
> point it out.  This message will look to the user like:
> 
>     ACPI: Unable to add the device
> 
> which is useless.  The user has no idea what device we're talking
> about or why we can't add it, so he can't *do* anything with the
> message.  Almost every printk of a constant string has this problem.
> Using dev_err() instead of printk() would help a lot, as would
> including the error code (result).  Of course, this would be a
> separate patch that would update all the messages in the driver at the
> same time.

I agree.  I will put it as one of my future items. :)

Thanks,
-Toshi

> >                        break;
> >                }
> > +
> > +               ost_code = ACPI_OST_SC_SUCCESS;
> >                break;
> > +
> >        case ACPI_NOTIFY_EJECT_REQUEST:
> >                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                                  "received ACPI_NOTIFY_EJECT_REQUEST\n"));
> > @@ -736,15 +740,23 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
> >                if (!pr) {
> >                        printk(KERN_ERR PREFIX
> >                                    "Driver data is NULL, dropping EJECT\n");
> > -                       return;
> > +                       break;
> >                }
> > +
> > +               /* REVISIT: update when eject is supported */
> > +               ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> >                break;
> > +
> >        default:
> >                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                                  "Unsupported event [0x%x]\n", event));
> > -               break;
> > +
> > +               /* non-hotplug event; possibly handled by other handler */
> > +               return;
> >        }
> >
> > +       /* Inform firmware that the hotplug operation has completed */
> > +       (void) acpi_evaluate_ost(handle, event, ost_code, NULL);
> >        return;
> >  }
> >
> > --
> > 1.7.7.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


