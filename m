From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] RFC] [Patch] [DRM/I915] :Check the LID device to
	decide whether the LVDS should be initialized
Date: Thu, 18 Jun 2009 14:27:27 +0800
Message-ID: <1245306447.7697.54.camel@localhost.localdomain>
References: <1244187921.3558.223.camel@localhost.localdomain>
	 <1244200261.11142.20.camel@gaiman.anholt.net>
	 <1244422347.3698.6.camel@localhost.localdomain>
	 <1244585813.4896.34.camel@gaiman.anholt.net>
	 <20090609153559.2e93479d@jbarnes-x200>
	 <1244714614.3618.10.camel@localhost.localdomain>
	 <1244768401.3618.17.camel@localhost.localdomain>
	 <d7ead6de0906151133x7b10560y6c53e1663888378d@mail.gmail.com>
	 <1245123084.3583.122.camel@localhost.localdomain>
	 <d7ead6de0906160359xef9a5d8q35278feb24340497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43457 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbZFRG0X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 02:26:23 -0400
In-Reply-To: <d7ead6de0906160359xef9a5d8q35278feb24340497@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir 'phcoder' Serbinenko <phcoder@gmail.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-06-16 at 18:59 +0800, Vladimir 'phcoder' Serbinenko wrote:
> On Tue, Jun 16, 2009 at 5:31 AM, yakui_zhao<yakui.zhao@intel.com> wrote:
> > On Tue, 2009-06-16 at 02:33 +0800, Vladimir 'phcoder' Serbinenko wrote:
> >> Hello
> >>
> >> On Fri, Jun 12, 2009 at 3:00 AM, yakui_zhao<yakui.zhao@intel.com> wrote:
> >> > On Thu, 2009-06-11 at 18:03 +0800, yakui_zhao wrote:
> >> > cc: Linux-acpi
> >> >> Hi, All
> >> >>
> >> >>     This is a patch that the LID device is checked to decide whether the LVDS should
> >> >> be initialized. If there is no LID device, it won't initialize the LVDS output device
> >> >> in KMS mode on the boxes based on intel mobile chipset. In such case the pipe occupied
> >> >> by LVDS can be used for other output device.
> >> >>     If the LID device can be found, it will continue the current flowchart.
> >> >>
> >> There is a problem with this strategy. I once had a hardware LID
> >> failure and it such cases I don't want to lose my screen output.
> >> Perhaps this can be compile-time or runtime option?
> > Do you confirm whether there exists the hardware LID failure?
> >       Will you please send me the acpidump about this failure?
> >
> Well it's too late since I repaired it long since then.
> > In the patch it only depends on whether the exists the LID device. And
> > it won't check whether the LID state is correct.
> Yes I understand. However I'm always doubt what firmware passes to my
> code. We all know all kinds of BIOS quirks. I'm not against trying to
> autodetect but user should be able to override this autodetection in
> case it detects wrong
Do you mean that there is no LID device while there exists the LVDS
device? In such case the LVDS is detected incorrectly. Maybe we can add
it the quirk list. 

Thanks.
> >
> > Thanks.
> >> >>     On some boxes the mobile chipset is used and there is no LVDS device. In such
> >> >> case we had better not initialize the LVDS output device so that one pipe can
> >> >> be used for other output device. For example: E-TOP in bug 21496
> >> >>
> >> >> But unfortunately the LVDS device is still initialized on such boxes based on
> >> >> mobile chipset in KMS mode. It brings that this pipe occupied by LVDS can't be
> >> >> used for other output device.
> >> >>
> >> >> After checking the acpidump we find that there is no LID device on such boxes.
> >> >> In such case we can use the LID device to decide whether the LVDS device should
> >> >> be initialized.
> >> >>
> >> >> If there is no LID device, we can think that there is no LVDS device. It is
> >> >> unnecessary to initialize the LVDS output device.
> >> >> If there exists the LID device, it will continue the current flowchart.
> >> >>
> >> >> Maybe on some boxes there is no LVDS device but the LID device is found. In
> >> >> such case it had better be added to the quirk table.
> >> >>
> >> >> Welcome the comments.
> >> >>    Yakui
> >> >> ---
> >> >>  drivers/gpu/drm/i915/intel_lvds.c |   79 ++++++++++++++++++++++++++++++++++++++
> >> >>  1 file changed, 79 insertions(+)
> >> >>
> >> >> Index: linux-2.6/drivers/gpu/drm/i915/intel_lvds.c
> >> >> ===================================================================
> >> >> --- linux-2.6.orig/drivers/gpu/drm/i915/intel_lvds.c  2009-06-11 15:27:07.000000000 +0800
> >> >> +++ linux-2.6/drivers/gpu/drm/i915/intel_lvds.c       2009-06-11 17:42:07.000000000 +0800
> >> >> @@ -36,6 +36,7 @@
> >> >>  #include "intel_drv.h"
> >> >>  #include "i915_drm.h"
> >> >>  #include "i915_drv.h"
> >> >> +#include <linux/acpi.h>
> >> >>
> >> >>  /**
> >> >>   * Sets the backlight level.
> >> >> @@ -503,7 +504,74 @@
> >> >>
> >> >>       { }     /* terminating entry */
> >> >>  };
> >> >> +#ifdef CONFIG_ACPI
> >> >> +/*
> >> >> + * check_lid_device -- check whether it is ACPI LID device.
> >> >> + * @handle: ACPI device handle
> >> >> + * @level : depth in the ACPI namespace tree
> >> >> + * @context: the number of LID device when we find the device
> >> >> + * @rv: a return value to fill if desired (Not use)
> >> >> + *
> >> >> + * check whether it is a LID device by comparing the HID. If it is,
> >> >> + * increase the number of LID device.
> >> >> + */
> >> >> +static acpi_status
> >> >> +check_lid_device(acpi_handle handle, u32 level, void *context,
> >> >> +                     void **retyurn_value)
> >> >> +{
> >> >> +#define              ACPI_HID_LID            "PNP0C0D"
> >> >> +     struct acpi_device *acpi_dev;
> >> >> +     int *p_lid = (int *)context;
> >> >> +
> >> >> +     acpi_dev = NULL;
> >> >> +     /* Get the acpi device for device handle */
> >> >> +     if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev) {
> >> >> +             /* If there is no ACPI device for handle, return */
> >> >> +             return AE_OK;
> >> >> +     }
> >> >> +     if (!strncmp(acpi_device_hid(acpi_dev), ACPI_HID_LID, 7)) {
> >> >> +             /*
> >> >> +              * compare the device HID with "PNP0C0D". If it is equal, the
> >> >> +              * LID device is found. Increase the count
> >> >> +              */
> >> >> +             (*p_lid)++;
> >> >> +     }
> >> >> +     return AE_OK;
> >> >> +}
> >> >> +/**
> >> >> + * check whether there exists the ACPI LID device by enumerating the ACPI
> >> >> + * device tree.
> >> >> + * If ACPI is disabled, there is no ACPI device tree. 0 is returned.
> >> >> + * If the LID device is found, it will return zero.
> >> >> + * If no LID device is found, it will return  -ENODEV.
> >> >> + */
> >> >> +static int intel_lvds_find_lid(void)
> >> >> +{
> >> >> +     int lid_count = 0;
> >> >>
> >> >> +     if (acpi_disabled) {
> >> >> +             /*
> >> >> +              * if ACPI is disabled, there is no ACPI device tree. And
> >> >> +              * we don't know whether there exists the LID device.
> >> >> +              * In such case we will return 0.
> >> >> +              */
> >> >> +             return 0;
> >> >> +     }
> >> >> +
> >> >> +     acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> >> >> +                             ACPI_UINT32_MAX,
> >> >> +                             check_lid_device, &lid_count, NULL);
> >> >> +
> >> >> +     if (!lid_count) {
> >> >> +             /* No LID device is not found. Return -ENODEV */
> >> >> +             return -ENODEV;
> >> >> +     }
> >> >> +
> >> >> +     return 0;
> >> >> +}
> >> >> +#else
> >> >> +static inline int intel_lvds_find_lid(void) { return 0; }
> >> >> +#endif
> >> >>  /**
> >> >>   * intel_lvds_init - setup LVDS connectors on this device
> >> >>   * @dev: drm device
> >> >> @@ -526,6 +594,17 @@
> >> >>       if (dmi_check_system(intel_no_lvds))
> >> >>               return;
> >> >>
> >> >> +     if (intel_lvds_find_lid()) {
> >> >> +             /* If there is no LID device, we can think that there is
> >> >> +              * no LVDS output device. In such case it is unnecessary to
> >> >> +              * create the LVDS output device.
> >> >> +              * But maybe on some boxes there is no LVDS device while the
> >> >> +              * LID device is found. If so, it had better be added to
> >> >> +              * the quirk list.
> >> >> +              */
> >> >> +             return;
> >> >> +     }
> >> >> +
> >> >>       if (IS_IGDNG(dev)) {
> >> >>               if ((I915_READ(PCH_LVDS) & LVDS_DETECTED) == 0)
> >> >>                       return;
> >> >>
> >> >>
> >> >> _______________________________________________
> >> >> Intel-gfx mailing list
> >> >> Intel-gfx@lists.freedesktop.org
> >> >> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >>
> >>
> >>
> >
> >
> 
> 
> 

