From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI: Add CPU hotplug support for processor device
 objects
Date: Tue, 20 Mar 2012 12:10:52 -0600
Message-ID: <1332267052.25679.55.camel@misato.fc.hp.com>
References: <1332184082-426-1-git-send-email-toshi.kani@hp.com>
	 <CAErSpo6EWM6ox1U4UqF6Pmhf-t-Pj58saV34vxR_3emA-Z=oRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:27748 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2CTSLm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2012 14:11:42 -0400
In-Reply-To: <CAErSpo6EWM6ox1U4UqF6Pmhf-t-Pj58saV34vxR_3emA-Z=oRg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi Bjorn,

On Tue, 2012-03-20 at 10:55 -0600, Bjorn Helgaas wrote:
> On Mon, Mar 19, 2012 at 1:08 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> > acpi_processor_install_hotplug_notify() registers processor objects to
> > receive ACPI CPU hotplug event notifications. This patch additionally
> > registers processor device objects (ACPI0007) to receive the notifications
> > as well.
> >
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  drivers/acpi/processor_driver.c |   48 ++++++++++++++++++++++++++++++--------
> >  1 files changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 8ae05ce..50be277 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -68,6 +68,7 @@
> >  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> >  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
> >  #define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> > +#define ACPI_PROCESSOR_DEVICE_HID      "ACPI0007"
> >
> >  #define ACPI_PROCESSOR_LIMIT_USER      0
> >  #define ACPI_PROCESSOR_LIMIT_THERMAL   1
> > @@ -88,7 +89,7 @@ static int acpi_processor_start(struct acpi_processor *pr);
> >
> >  static const struct acpi_device_id processor_device_ids[] = {
> >        {ACPI_PROCESSOR_OBJECT_HID, 0},
> > -       {"ACPI0007", 0},
> > +       {ACPI_PROCESSOR_DEVICE_HID, 0},
> >        {"", 0},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> > @@ -741,20 +742,46 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
> >        return;
> >  }
> >
> > +static acpi_status is_processor_device(acpi_handle handle)
> > +{
> > +       struct acpi_device_info *info;
> > +       char *hid;
> > +       acpi_status status;
> > +
> > +       status = acpi_get_object_info(handle, &info);
> > +       if (ACPI_FAILURE(status))
> > +               return status;
> > +
> > +       if (info->type == ACPI_TYPE_PROCESSOR) {
> > +               kfree(info);
> > +               return AE_OK;   /* found a processor object */
> > +       }
> > +
> > +       if (!(info->valid & ACPI_VALID_HID)) {
> > +               kfree(info);
> > +               return AE_ERROR;
> > +       }
> > +
> > +       hid = info->hardware_id.string;
> > +       if ((hid == NULL) || strcmp(hid, ACPI_PROCESSOR_DEVICE_HID)) {
> > +               kfree(info);
> > +               return AE_ERROR;
> 
> It's common to combine cleanup paths using goto and labels so things
> like the kfree() don't have to be repeated.  In this case, it's so
> simple that I'm not sure there's much to be gained, so I think it's
> fine either way.

I will change it to combine the cleanup paths.

> > +       }
> > +
> > +       kfree(info);
> > +       return AE_OK;   /* found a processor device object */
> > +}
> > +
> >  static acpi_status
> >  processor_walk_namespace_cb(acpi_handle handle,
> >                            u32 lvl, void *context, void **rv)
> >  {
> >        acpi_status status;
> >        int *action = context;
> > -       acpi_object_type type = 0;
> >
> > -       status = acpi_get_type(handle, &type);
> > +       status = is_processor_device(handle);
> >        if (ACPI_FAILURE(status))
> 
> This patch looks great to me.  The only trivial thing I'd change is to
> make "is_processor_device()" a bool, since that's what the name
> suggests, and it would make this code slightly simpler.

Good point. I will make that change as well.

> Other than that:
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Great. Thanks a lot!
-Toshi


> > -               return (AE_OK);
> > -
> > -       if (type != ACPI_TYPE_PROCESSOR)
> > -               return (AE_OK);
> > +               return AE_OK;   /* not a processor; continue to walk */
> >
> >        switch (*action) {
> >        case INSTALL_NOTIFY_HANDLER:
> > @@ -772,7 +799,8 @@ processor_walk_namespace_cb(acpi_handle handle,
> >                break;
> >        }
> >
> > -       return (AE_OK);
> > +       /* found a processor; skip walking underneath */
> > +       return AE_CTRL_DEPTH;
> >  }
> >
> >  static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
> > @@ -830,7 +858,7 @@ void acpi_processor_install_hotplug_notify(void)
> >  {
> >  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> >        int action = INSTALL_NOTIFY_HANDLER;
> > -       acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> > +       acpi_walk_namespace(ACPI_TYPE_ANY,
> >                            ACPI_ROOT_OBJECT,
> >                            ACPI_UINT32_MAX,
> >                            processor_walk_namespace_cb, NULL, &action, NULL);
> > @@ -843,7 +871,7 @@ void acpi_processor_uninstall_hotplug_notify(void)
> >  {
> >  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> >        int action = UNINSTALL_NOTIFY_HANDLER;
> > -       acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> > +       acpi_walk_namespace(ACPI_TYPE_ANY,
> >                            ACPI_ROOT_OBJECT,
> >                            ACPI_UINT32_MAX,
> >                            processor_walk_namespace_cb, NULL, &action, NULL);
> > --
> > 1.7.7.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


