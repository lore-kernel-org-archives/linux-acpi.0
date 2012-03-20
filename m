From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Add CPU hotplug support for processor device objects
Date: Tue, 20 Mar 2012 10:55:34 -0600
Message-ID: <CAErSpo6EWM6ox1U4UqF6Pmhf-t-Pj58saV34vxR_3emA-Z=oRg@mail.gmail.com>
References: <1332184082-426-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62755 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab2CTQz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2012 12:55:56 -0400
Received: by lbbgm6 with SMTP id gm6so210934lbb.19
        for <linux-acpi@vger.kernel.org>; Tue, 20 Mar 2012 09:55:55 -0700 (PDT)
In-Reply-To: <1332184082-426-1-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Mon, Mar 19, 2012 at 1:08 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> acpi_processor_install_hotplug_notify() registers processor objects t=
o
> receive ACPI CPU hotplug event notifications. This patch additionally
> registers processor device objects (ACPI0007) to receive the notifica=
tions
> as well.
>
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---
> =A0drivers/acpi/processor_driver.c | =A0 48 +++++++++++++++++++++++++=
+++++--------
> =A01 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index 8ae05ce..50be277 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -68,6 +68,7 @@
> =A0#define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> =A0#define ACPI_PROCESSOR_NOTIFY_POWER =A0 =A00x81
> =A0#define ACPI_PROCESSOR_NOTIFY_THROTTLING =A0 =A0 =A0 0x82
> +#define ACPI_PROCESSOR_DEVICE_HID =A0 =A0 =A0"ACPI0007"
>
> =A0#define ACPI_PROCESSOR_LIMIT_USER =A0 =A0 =A00
> =A0#define ACPI_PROCESSOR_LIMIT_THERMAL =A0 1
> @@ -88,7 +89,7 @@ static int acpi_processor_start(struct acpi_process=
or *pr);
>
> =A0static const struct acpi_device_id processor_device_ids[] =3D {
> =A0 =A0 =A0 =A0{ACPI_PROCESSOR_OBJECT_HID, 0},
> - =A0 =A0 =A0 {"ACPI0007", 0},
> + =A0 =A0 =A0 {ACPI_PROCESSOR_DEVICE_HID, 0},
> =A0 =A0 =A0 =A0{"", 0},
> =A0};
> =A0MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> @@ -741,20 +742,46 @@ static void acpi_processor_hotplug_notify(acpi_=
handle handle,
> =A0 =A0 =A0 =A0return;
> =A0}
>
> +static acpi_status is_processor_device(acpi_handle handle)
> +{
> + =A0 =A0 =A0 struct acpi_device_info *info;
> + =A0 =A0 =A0 char *hid;
> + =A0 =A0 =A0 acpi_status status;
> +
> + =A0 =A0 =A0 status =3D acpi_get_object_info(handle, &info);
> + =A0 =A0 =A0 if (ACPI_FAILURE(status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> +
> + =A0 =A0 =A0 if (info->type =3D=3D ACPI_TYPE_PROCESSOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK; =A0 /* found a processor =
object */
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!(info->valid & ACPI_VALID_HID)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_ERROR;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hid =3D info->hardware_id.string;
> + =A0 =A0 =A0 if ((hid =3D=3D NULL) || strcmp(hid, ACPI_PROCESSOR_DEV=
ICE_HID)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_ERROR;

It's common to combine cleanup paths using goto and labels so things
like the kfree() don't have to be repeated.  In this case, it's so
simple that I'm not sure there's much to be gained, so I think it's
fine either way.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kfree(info);
> + =A0 =A0 =A0 return AE_OK; =A0 /* found a processor device object */
> +}
> +
> =A0static acpi_status
> =A0processor_walk_namespace_cb(acpi_handle handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 lvl, void =
*context, void **rv)
> =A0{
> =A0 =A0 =A0 =A0acpi_status status;
> =A0 =A0 =A0 =A0int *action =3D context;
> - =A0 =A0 =A0 acpi_object_type type =3D 0;
>
> - =A0 =A0 =A0 status =3D acpi_get_type(handle, &type);
> + =A0 =A0 =A0 status =3D is_processor_device(handle);
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status))

This patch looks great to me.  The only trivial thing I'd change is to
make "is_processor_device()" a bool, since that's what the name
suggests, and it would make this code slightly simpler.

Other than that:

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (AE_OK);
> -
> - =A0 =A0 =A0 if (type !=3D ACPI_TYPE_PROCESSOR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (AE_OK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK; =A0 /* not a processor; c=
ontinue to walk */
>
> =A0 =A0 =A0 =A0switch (*action) {
> =A0 =A0 =A0 =A0case INSTALL_NOTIFY_HANDLER:
> @@ -772,7 +799,8 @@ processor_walk_namespace_cb(acpi_handle handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return (AE_OK);
> + =A0 =A0 =A0 /* found a processor; skip walking underneath */
> + =A0 =A0 =A0 return AE_CTRL_DEPTH;
> =A0}
>
> =A0static acpi_status acpi_processor_hotadd_init(struct acpi_processo=
r *pr)
> @@ -830,7 +858,7 @@ void acpi_processor_install_hotplug_notify(void)
> =A0{
> =A0#ifdef CONFIG_ACPI_HOTPLUG_CPU
> =A0 =A0 =A0 =A0int action =3D INSTALL_NOTIFY_HANDLER;
> - =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> + =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_ANY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_ROOT_OBJE=
CT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_UINT32_MA=
X,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0processor_walk=
_namespace_cb, NULL, &action, NULL);
> @@ -843,7 +871,7 @@ void acpi_processor_uninstall_hotplug_notify(void=
)
> =A0{
> =A0#ifdef CONFIG_ACPI_HOTPLUG_CPU
> =A0 =A0 =A0 =A0int action =3D UNINSTALL_NOTIFY_HANDLER;
> - =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> + =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_ANY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_ROOT_OBJE=
CT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_UINT32_MA=
X,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0processor_walk=
_namespace_cb, NULL, &action, NULL);
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
