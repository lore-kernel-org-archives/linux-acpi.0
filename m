From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [PATCH] ACPI button: provide lid status functions
Date: Thu, 10 Sep 2009 18:08:05 -0700
Message-ID: <20090910180805.1e150ca0@jbarnes-g45>
References: <1252621686-27307-1-git-send-email-jbarnes@virtuousgeek.org>
	<1252621686-27307-2-git-send-email-jbarnes@virtuousgeek.org>
	<1252630922.3609.200.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-150.bluehost.com ([67.222.38.40]:53042 "HELO
	outbound-mail-150.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751315AbZIKBOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2009 21:14:48 -0400
In-Reply-To: <1252630922.3609.200.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org

On Fri, 11 Sep 2009 09:02:02 +0800
ykzhao <yakui.zhao@intel.com> wrote:

> On Fri, 2009-09-11 at 06:28 +0800, Jesse Barnes wrote:
> cc: linux-acpi
> > Some drivers need to know when a lid event occurs and get the
> > current status.  This can be useful for when a platform firmware
> > clobbers some hardware state at lid time, and a driver needs to
> > restore things when the lid is opened again.
> >=20
> > Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> > ---
> >  drivers/acpi/button.c |   45
> > +++++++++++++++++++++++++++++++++++++++++++-- include/acpi/button.h
> > |   10 ++++++++++ 2 files changed, 53 insertions(+), 2 deletions(-)
> >  create mode 100644 include/acpi/button.h
> >=20
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 9195deb..ebb593e 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -113,6 +113,9 @@ static const struct file_operations
> > acpi_button_state_fops =3D { .release =3D single_release,
> >  };
> > =20
> > +static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
> > +static struct acpi_device *lid_device;
> > +
> >  /*
> > -------------------------------------------------------------------=
-------
> > FS Interface (/proc)
> > -------------------------------------------------------------------=
-------
> > */ @@ -229,11 +232,38 @@ static int acpi_button_remove_fs(struct
> > acpi_device *device) /*
> > -------------------------------------------------------------------=
-------
> > Driver Interface
> > -------------------------------------------------------------------=
-------
> > */ +int acpi_lid_notifier_register(struct notifier_block *nb) +{
> > +	return
> > blocking_notifier_chain_register(&acpi_lid_notifier, nb); +}
> > +EXPORT_SYMBOL(acpi_lid_notifier_register);
> > +
> > +int acpi_lid_notifier_unregister(struct notifier_block *nb)
> > +{
> > +	return
> > blocking_notifier_chain_unregister(&acpi_lid_notifier, nb); +}
> > +EXPORT_SYMBOL(acpi_lid_notifier_unregister);
> > +
> > +int acpi_lid_open(void)
> > +{
> > +	acpi_status status;
> > +	unsigned long long state;
> > +
> > +	status =3D acpi_evaluate_integer(lid_device->handle, "_LID",
> > NULL,
> > +				       &state);
> > +	if (ACPI_FAILURE(status))
> > +		return -ENODEV;
> > +
> > +	return !!state;
> > +}
> > +EXPORT_SYMBOL(acpi_lid_open);
> > +
> >  static int acpi_lid_send_state(struct acpi_device *device)
> >  {
> >  	struct acpi_button *button =3D acpi_driver_data(device);
> >  	unsigned long long state;
> >  	acpi_status status;
> > +	int ret;
> > =20
> >  	status =3D acpi_evaluate_integer(device->handle, "_LID",
> > NULL, &state); if (ACPI_FAILURE(status))
> > @@ -242,7 +272,12 @@ static int acpi_lid_send_state(struct
> > acpi_device *device) /* input layer checks if event is redundant */
> >  	input_report_switch(button->input, SW_LID, !state);
> >  	input_sync(button->input);
> > -	return 0;
> > +
> > +	ret =3D blocking_notifier_call_chain(&acpi_lid_notifier,
> > state, device);
> > +	if (ret =3D=3D NOTIFY_DONE)
> > +		ret =3D
> > blocking_notifier_call_chain(&acpi_lid_notifier, state,
> > +						   device);
> > +	return ret;
> >  }
> > =20
> >  static void acpi_button_notify(struct acpi_device *device, u32
> > event) @@ -364,8 +399,14 @@ static int acpi_button_add(struct
> > acpi_device *device) error =3D input_register_device(input);
> >  	if (error)
> >  		goto err_remove_fs;
> > -	if (button->type =3D=3D ACPI_BUTTON_TYPE_LID)
> > +	if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
> >  		acpi_lid_send_state(device);
> > +		/*
> > +		 * This assumes there's only one lid device, or if
> > there are
> > +		 * more we only care about the last one...
> > +		 */
> > +		lid_device =3D device;
> > +	}
> > =20
> >  	if (device->wakeup.flags.valid) {
> >  		/* Button's GPE is run-wake GPE */
> > diff --git a/include/acpi/button.h b/include/acpi/button.h
> > new file mode 100644
> > index 0000000..bb643a7
> > --- /dev/null
> > +++ b/include/acpi/button.h
> > @@ -0,0 +1,10 @@
> > +#ifndef ACPI_BUTTON_H
> > +#define ACPI_BUTTON_H
> It will be better that the function prototype is defined in the
> following:
>=20
> #if (defined(CONFIG_ACPI_BUTTON) ||
> defined(CONFIG_ACPI_BUTTON_MODULE)) extern =EF=BB=BFint
> acpi_lid_notifier_register(struct notifier_block *nb); extern int
> acpi_lid_notifier_unregister(struct notifier_block *nb); extern int
> acpi_lid_open(void); #else
> static inline int acpi_lid_notifier_register( ...)  { return 0;}
> static inline int acpi_lid_notifier_unregister(struct notifier_block
> *nb) { return 0; }
> static inline int acpi_lid_open(void) { return 1; }
> #endif

Oh right, I missed that part.  I'll send a followup patch on top with
this fix (unless you beat me to it).

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
