From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] ACPI: Add _OST support for ACPI CPU hotplug
Date: Thu, 26 Apr 2012 09:22:59 -0600
Message-ID: <CAErSpo5n22TLo+U3f_zHdkZSG=e7x4bySFPWtxT+ghYyenGc6A@mail.gmail.com>
References: <1334096510-17319-1-git-send-email-toshi.kani@hp.com> <1334096510-17319-4-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35224 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757629Ab2DZPXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Apr 2012 11:23:21 -0400
Received: by lahj13 with SMTP id j13so1080195lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Apr 2012 08:23:19 -0700 (PDT)
In-Reply-To: <1334096510-17319-4-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 10, 2012 at 4:21 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> Changed acpi_processor_hotplug_notify() to call ACPI _OST method
> when ACPI-based CPU hotplug operation completed.
>
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---
> =A0drivers/acpi/processor_driver.c | =A0 28 ++++++++++++++++++++-----=
---
> =A01 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index 0734086..5d9b5a8 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -701,9 +701,9 @@ static void acpi_processor_hotplug_notify(acpi_ha=
ndle handle,
> =A0{
> =A0 =A0 =A0 =A0struct acpi_processor *pr;
> =A0 =A0 =A0 =A0struct acpi_device *device =3D NULL;
> + =A0 =A0 =A0 u32 ost_code =3D ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* d=
efault */
> =A0 =A0 =A0 =A0int result;
>
> -
> =A0 =A0 =A0 =A0switch (event) {
> =A0 =A0 =A0 =A0case ACPI_NOTIFY_BUS_CHECK:
> =A0 =A0 =A0 =A0case ACPI_NOTIFY_DEVICE_CHECK:
> @@ -715,14 +715,18 @@ static void acpi_processor_hotplug_notify(acpi_=
handle handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_processor_present(handle))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acpi_bus_get_device(handle, &device=
)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D acpi_process=
or_device_add(handle, &device);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR PREFIX
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 "Unable to add the device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!acpi_bus_get_device(handle, &devic=
e))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D acpi_processor_device_add(ha=
ndle, &device);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR PREFIX =
"Unable to add the device\n");

You didn't add this problem, but since you're touching the code, I'll
point it out.  This message will look to the user like:

    ACPI: Unable to add the device

which is useless.  The user has no idea what device we're talking
about or why we can't add it, so he can't *do* anything with the
message.  Almost every printk of a constant string has this problem.
Using dev_err() instead of printk() would help a lot, as would
including the error code (result).  Of course, this would be a
separate patch that would update all the messages in the driver at the
same time.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ost_code =3D ACPI_OST_SC_SUCCESS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 =A0case ACPI_NOTIFY_EJECT_REQUEST:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"r=
eceived ACPI_NOTIFY_EJECT_REQUEST\n"));
> @@ -736,15 +740,23 @@ static void acpi_processor_hotplug_notify(acpi_=
handle handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!pr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR PREFIX
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"Driver data is NULL, dropping EJECT\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* REVISIT: update when eject is suppor=
ted */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ost_code =3D ACPI_OST_SC_EJECT_NOT_SUPP=
ORTED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"U=
nsupported event [0x%x]\n", event));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-hotplug event; possibly handled =
by other handler */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* Inform firmware that the hotplug operation has compl=
eted */
> + =A0 =A0 =A0 (void) acpi_evaluate_ost(handle, event, ost_code, NULL)=
;
> =A0 =A0 =A0 =A0return;
> =A0}
>
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
