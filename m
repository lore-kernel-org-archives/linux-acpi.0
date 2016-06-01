From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 3/3] ACPI / button: Add quirks for initial lid state
 notification
Date: Wed, 01 Jun 2016 13:01:11 +0200
Message-ID: <1464778871.2432.12.camel@hadess.net>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	 <284674cb8228f4f2b40f940a3c4a666f367d7b6a.1464775699.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:50896 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcFALBU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jun 2016 07:01:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id BE9AC486423
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jun 2016 13:01:18 +0200 (CEST)
In-Reply-To: <284674cb8228f4f2b40f940a3c4a666f367d7b6a.1464775699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Wed, 2016-06-01 at 18:10 +0800, Lv Zheng wrote:
> Linux userspace (systemd-logind) keeps on rechecking lid state when t=
he
> lid state is closed. If it failed to update the lid state to open aft=
er
> boot/resume, the system suspending right after the boot/resume could =
be
> resulted.
> Graphics drivers also uses the lid notifications to implment
> MODESET_ON_LID_OPEN option.

"implement"

> Before the situation is improved from the userspace and from the grap=
hics
> driver, users can simply configure ACPI button driver to send initial
> "open" lid state using button.lid_init_state=3Dopen to avoid such kin=
d of
> issues. And our ultimate target should be making
> button.lid_init_state=3Dignore the default behavior. This patch imple=
ments
> the 2 options and keep the old behavior (button.lid_init_state=3Dmeth=
od).

I still don't think it's reasonable to expect any changes in user-space=
=20
unless you start documenting what the API to user-space actually is.

(I work on UPower, which also exports that information, and which gets
used in gnome-settings-daemon in a number of ways)

> Link 1: https://lkml.org/2016/3/7/460
> Link 2: https://github.com/systemd/systemd/issues/2087
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Bastien Nocera: <hadess@hadess.net>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
> =C2=A0drivers/acpi/button.c |=C2=A0=C2=A0=C2=A061
> +++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 6e291c1..148f4e5 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -53,6 +53,10 @@
> =C2=A0#define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
> =C2=A0#define ACPI_BUTTON_TYPE_LID		0x05
> =C2=A0
> +#define ACPI_BUTTON_LID_INIT_IGNORE	0x00
> +#define ACPI_BUTTON_LID_INIT_OPEN	0x01
> +#define ACPI_BUTTON_LID_INIT_METHOD	0x02
> +
> =C2=A0#define _COMPONENT		ACPI_BUTTON_COMPONENT
> =C2=A0ACPI_MODULE_NAME("button");
> =C2=A0
> @@ -105,6 +109,7 @@ struct acpi_button {
> =C2=A0
> =C2=A0static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
> =C2=A0static struct acpi_device *lid_device;
> +static u8 lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
> =C2=A0
> =C2=A0/* ------------------------------------------------------------=
---
> -----------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0FS Interface (/proc)
> @@ -285,6 +290,21 @@ static int acpi_lid_update_state(struct
> acpi_device *device)
> =C2=A0	return acpi_lid_notify_state(device, state);
> =C2=A0}
> =C2=A0
> +static void acpi_lid_initialize_state(struct acpi_device *device)
> +{
> +	switch (lid_init_state) {
> +	case ACPI_BUTTON_LID_INIT_OPEN:
> +		(void)acpi_lid_notify_state(device, 1);
> +		break;
> +	case ACPI_BUTTON_LID_INIT_METHOD:
> +		(void)acpi_lid_update_state(device);
> +		break;
> +	case ACPI_BUTTON_LID_INIT_IGNORE:
> +	default:
> +		break;
> +	}
> +}
> +
> =C2=A0static void acpi_button_notify(struct acpi_device *device, u32
> event)
> =C2=A0{
> =C2=A0	struct acpi_button *button =3D acpi_driver_data(device);
> @@ -341,6 +361,8 @@ static int acpi_button_resume(struct device *dev)
> =C2=A0	struct acpi_button *button =3D acpi_driver_data(device);
> =C2=A0
> =C2=A0	button->suspended =3D false;
> +	if (button->type =3D=3D ACPI_BUTTON_TYPE_LID)
> +		acpi_lid_initialize_state(device);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0#endif
> @@ -421,6 +443,7 @@ static int acpi_button_add(struct acpi_device
> *device)
> =C2=A0	if (error)
> =C2=A0		goto err_remove_fs;
> =C2=A0	if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
> +		acpi_lid_initialize_state(device);
> =C2=A0		/*
> =C2=A0		=C2=A0* This assumes there's only one lid device, or if
> there are
> =C2=A0		=C2=A0* more we only care about the last one...
> @@ -450,4 +473,42 @@ static int acpi_button_remove(struct acpi_device
> *device)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int param_set_lid_init_state(const char *val, struct
> kernel_param *kp)
> +{
> +	int result =3D 0;
> +
> +	if (!strncmp(val, "open", sizeof("open") - 1)) {
> +		lid_init_state =3D ACPI_BUTTON_LID_INIT_OPEN;
> +		pr_info("Notify initial lid state as open\n");
> +	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
> +		lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
> +		pr_info("Notify initial lid state with _LID return
> value\n");
> +	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
> +		lid_init_state =3D ACPI_BUTTON_LID_INIT_IGNORE;
> +		pr_info("Do not notify initial lid state\n");
> +	} else
> +		result =3D -EINVAL;
> +	return result;
> +}
> +
> +static int param_get_lid_init_state(char *buffer, struct
> kernel_param *kp)
> +{
> +	switch (lid_init_state) {
> +	case ACPI_BUTTON_LID_INIT_OPEN:
> +		return sprintf(buffer, "open");
> +	case ACPI_BUTTON_LID_INIT_METHOD:
> +		return sprintf(buffer, "method");
> +	case ACPI_BUTTON_LID_INIT_IGNORE:
> +		return sprintf(buffer, "ignore");
> +	default:
> +		return sprintf(buffer, "invalid");
> +	}
> +	return 0;
> +}
> +
> +module_param_call(lid_init_state,
> +		=C2=A0=C2=A0param_set_lid_init_state,
> param_get_lid_init_state,
> +		=C2=A0=C2=A0NULL, 0644);
> +MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial
> state");
> +
> =C2=A0module_acpi_driver(acpi_button_driver);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
