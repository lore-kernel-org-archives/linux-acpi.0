From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: acpi button event to input layer (was [RFC] [PATCH] Make ACPI button driver an input device)
Date: Wed, 6 Sep 2006 08:43:40 -0400
Message-ID: <200609060843.41559.dtor@insightbb.com>
References: <200608281506.50738.luming.yu@intel.com> <200609060115.50348.dtor@insightbb.com> <200609061733.58222.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:36439 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1750818AbWIFMnn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 08:43:43 -0400
In-Reply-To: <200609061733.58222.luming.yu@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Wednesday 06 September 2006 05:33, Yu Luming wrote:
> >
> >  Here they are, with 2 changes:
> >
> >  =C3=82=C2=A0- button module now depends on CONFIG_INPUT (per discu=
ssion with Len)
> >  =C3=82=C2=A0- if "_LID" evaluation fails SW__LID event is not deli=
vered to userspace
> >
> >  acpi-button-as-input is on top of acpi-button-cleanup...
> >
>=20
> Thanks for the patch. The attached one is the update patch against  2=
=2E6.18-rc6 git tree, including the 2 patches.=20
>=20
> >+                       if (!ACPI_FAILURE(acpi_evaluate_integer(hand=
le, "_LID",
> >+                                                               NULL=
, &state)))
> >+                               input_report_switch(input, SW_LID, !=
state);
>=20
> why it needs to report !state , NOT just state?
> Ps. ACPI defines 0 as closed,  non-0 as open.
>=20

Arbitrary decision on my part. I consider switch be active when lid is
closed; when lid is open it is "normal" state.

> >@@ -304,6 +365,12 @@ static int acpi_button_add(struct acpi_d
> >        button->device =3D device;
> >        acpi_driver_data(device) =3D button;
> >
> >+       button->input =3D input =3D input_allocate_device();
>=20
> On my test box, I got=20
> drwxr-xr-x 5 root root 0 2006-09-19 18:04 input3
> drwxr-xr-x 5 root root 0 2006-09-19 18:04 input4
> drwxr-xr-x 5 root root 0 2006-09-19 18:04 input5
>=20
> input 3 is power button, input4 is lid switch,=20
> input 5  is CM power button.
>=20
> why these buttons/switch need to have their own input device and even=
t interface?
> Can one input device for all acpi button/lid work?

Right now it naturally ties up in the way corresponding acpi
devices get registered and bound with button driver. It also
better represents real picture, isn't it? After all they are
separate devices as presented by ACPI.

>=20
> >+       input->name =3D acpi_device_name(device);
> Can I get more useful name under  /sys/class/input, rather than input=
3,4,5...

Not in sysfs. All core input devices in sysfs registered as inputX.
Handlers add their own names (mouseX, eventX). Having uniform name
allows to avoid clashes (if you add a custom name for a power button
what happen when you have 2 of these?). Cusom names belong to /dev
(either statically created or via udev rules). You can see what each
inputX is by looking at "name" sttribute in sysfs.

> >+       error =3D input_register_device(input);
> Shouldn't input_register_device be called before acpi_button_install_=
notify_handlers?
> Probably, we need to make sure input_report_switch/key can be invoked=
 only after
> input _register_device has been invoked and succeeded.

It does not really matter. As long as input device was allocated with
input_allocate_device it can withstand input_event calls even if it
is not finished registration with the input core. The events will
be simply dropped (since there are no handles attached to the device
yet).


--=20
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
