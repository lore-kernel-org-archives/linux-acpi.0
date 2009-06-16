From: "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>
Subject: Re: [Intel-gfx] RFC] [Patch] [DRM/I915] :Check the LID device to
	decide whether the LVDS should be initialized
Date: Tue, 16 Jun 2009 12:59:13 +0200
Message-ID: <d7ead6de0906160359xef9a5d8q35278feb24340497@mail.gmail.com>
References: <1244187921.3558.223.camel@localhost.localdomain>
	 <1244200261.11142.20.camel@gaiman.anholt.net>
	 <1244422347.3698.6.camel@localhost.localdomain>
	 <1244585813.4896.34.camel@gaiman.anholt.net>
	 <20090609153559.2e93479d@jbarnes-x200>
	 <1244714614.3618.10.camel@localhost.localdomain>
	 <1244768401.3618.17.camel@localhost.localdomain>
	 <d7ead6de0906151133x7b10560y6c53e1663888378d@mail.gmail.com>
	 <1245123084.3583.122.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38443 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZFPK7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2009 06:59:12 -0400
Received: by bwz9 with SMTP id 9so3944840bwz.37
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2009 03:59:14 -0700 (PDT)
In-Reply-To: <1245123084.3583.122.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Jun 16, 2009 at 5:31 AM, yakui_zhao<yakui.zhao@intel.com> wrote=
:
> On Tue, 2009-06-16 at 02:33 +0800, Vladimir 'phcoder' Serbinenko wrot=
e:
>> Hello
>>
>> On Fri, Jun 12, 2009 at 3:00 AM, yakui_zhao<yakui.zhao@intel.com> wr=
ote:
>> > On Thu, 2009-06-11 at 18:03 +0800, yakui_zhao wrote:
>> > cc: Linux-acpi
>> >> Hi, All
>> >>
>> >> =A0 =A0 This is a patch that the LID device is checked to decide =
whether the LVDS should
>> >> be initialized. If there is no LID device, it won't initialize th=
e LVDS output device
>> >> in KMS mode on the boxes based on intel mobile chipset. In such c=
ase the pipe occupied
>> >> by LVDS can be used for other output device.
>> >> =A0 =A0 If the LID device can be found, it will continue the curr=
ent flowchart.
>> >>
>> There is a problem with this strategy. I once had a hardware LID
>> failure and it such cases I don't want to lose my screen output.
>> Perhaps this can be compile-time or runtime option?
> Do you confirm whether there exists the hardware LID failure?
> =A0 =A0 =A0 Will you please send me the acpidump about this failure?
>
Well it's too late since I repaired it long since then.
> In the patch it only depends on whether the exists the LID device. An=
d
> it won't check whether the LID state is correct.
Yes I understand. However I'm always doubt what firmware passes to my
code. We all know all kinds of BIOS quirks. I'm not against trying to
autodetect but user should be able to override this autodetection in
case it detects wrong
>
> Thanks.
>> >> =A0 =A0 On some boxes the mobile chipset is used and there is no =
LVDS device. In such
>> >> case we had better not initialize the LVDS output device so that =
one pipe can
>> >> be used for other output device. For example: E-TOP in bug 21496
>> >>
>> >> But unfortunately the LVDS device is still initialized on such bo=
xes based on
>> >> mobile chipset in KMS mode. It brings that this pipe occupied by =
LVDS can't be
>> >> used for other output device.
>> >>
>> >> After checking the acpidump we find that there is no LID device o=
n such boxes.
>> >> In such case we can use the LID device to decide whether the LVDS=
 device should
>> >> be initialized.
>> >>
>> >> If there is no LID device, we can think that there is no LVDS dev=
ice. It is
>> >> unnecessary to initialize the LVDS output device.
>> >> If there exists the LID device, it will continue the current flow=
chart.
>> >>
>> >> Maybe on some boxes there is no LVDS device but the LID device is=
 found. In
>> >> such case it had better be added to the quirk table.
>> >>
>> >> Welcome the comments.
>> >> =A0 =A0Yakui
>> >> ---
>> >> =A0drivers/gpu/drm/i915/intel_lvds.c | =A0 79 +++++++++++++++++++=
+++++++++++++++++++
>> >> =A01 file changed, 79 insertions(+)
>> >>
>> >> Index: linux-2.6/drivers/gpu/drm/i915/intel_lvds.c
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> --- linux-2.6.orig/drivers/gpu/drm/i915/intel_lvds.c =A02009-06-1=
1 15:27:07.000000000 +0800
>> >> +++ linux-2.6/drivers/gpu/drm/i915/intel_lvds.c =A0 =A0 =A0 2009-=
06-11 17:42:07.000000000 +0800
>> >> @@ -36,6 +36,7 @@
>> >> =A0#include "intel_drv.h"
>> >> =A0#include "i915_drm.h"
>> >> =A0#include "i915_drv.h"
>> >> +#include <linux/acpi.h>
>> >>
>> >> =A0/**
>> >> =A0 * Sets the backlight level.
>> >> @@ -503,7 +504,74 @@
>> >>
>> >> =A0 =A0 =A0 { } =A0 =A0 /* terminating entry */
>> >> =A0};
>> >> +#ifdef CONFIG_ACPI
>> >> +/*
>> >> + * check_lid_device -- check whether it is ACPI LID device.
>> >> + * @handle: ACPI device handle
>> >> + * @level : depth in the ACPI namespace tree
>> >> + * @context: the number of LID device when we find the device
>> >> + * @rv: a return value to fill if desired (Not use)
>> >> + *
>> >> + * check whether it is a LID device by comparing the HID. If it =
is,
>> >> + * increase the number of LID device.
>> >> + */
>> >> +static acpi_status
>> >> +check_lid_device(acpi_handle handle, u32 level, void *context,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void **retyurn_value)
>> >> +{
>> >> +#define =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_HID_LID =A0 =A0 =A0 =A0 =
=A0 =A0"PNP0C0D"
>> >> + =A0 =A0 struct acpi_device *acpi_dev;
>> >> + =A0 =A0 int *p_lid =3D (int *)context;
>> >> +
>> >> + =A0 =A0 acpi_dev =3D NULL;
>> >> + =A0 =A0 /* Get the acpi device for device handle */
>> >> + =A0 =A0 if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev=
) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* If there is no ACPI device for handl=
e, return */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 if (!strncmp(acpi_device_hid(acpi_dev), ACPI_HID_LID, 7=
)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* compare the device HID with "PNP0C=
0D". If it is equal, the
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* LID device is found. Increase the =
count
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 (*p_lid)++;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 return AE_OK;
>> >> +}
>> >> +/**
>> >> + * check whether there exists the ACPI LID device by enumerating=
 the ACPI
>> >> + * device tree.
>> >> + * If ACPI is disabled, there is no ACPI device tree. 0 is retur=
ned.
>> >> + * If the LID device is found, it will return zero.
>> >> + * If no LID device is found, it will return =A0-ENODEV.
>> >> + */
>> >> +static int intel_lvds_find_lid(void)
>> >> +{
>> >> + =A0 =A0 int lid_count =3D 0;
>> >>
>> >> + =A0 =A0 if (acpi_disabled) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* if ACPI is disabled, there is no A=
CPI device tree. And
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* we don't know whether there exists=
 the LID device.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* In such case we will return 0.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_UI=
NT32_MAX,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_l=
id_device, &lid_count, NULL);
>> >> +
>> >> + =A0 =A0 if (!lid_count) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* No LID device is not found. Return -=
ENODEV */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +}
>> >> +#else
>> >> +static inline int intel_lvds_find_lid(void) { return 0; }
>> >> +#endif
>> >> =A0/**
>> >> =A0 * intel_lvds_init - setup LVDS connectors on this device
>> >> =A0 * @dev: drm device
>> >> @@ -526,6 +594,17 @@
>> >> =A0 =A0 =A0 if (dmi_check_system(intel_no_lvds))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >>
>> >> + =A0 =A0 if (intel_lvds_find_lid()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* If there is no LID device, we can th=
ink that there is
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* no LVDS output device. In such cas=
e it is unnecessary to
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* create the LVDS output device.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* But maybe on some boxes there is n=
o LVDS device while the
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* LID device is found. If so, it had=
 better be added to
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the quirk list.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >> + =A0 =A0 }
>> >> +
>> >> =A0 =A0 =A0 if (IS_IGDNG(dev)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((I915_READ(PCH_LVDS) & LVDS_DETEC=
TED) =3D=3D 0)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >>
>> >>
>> >> _______________________________________________
>> >> Intel-gfx mailing list
>> >> Intel-gfx@lists.freedesktop.org
>> >> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>>
>>
>
>



--=20
Regards
Vladimir 'phcoder' Serbinenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
