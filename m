From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: generate wakeup events on fixed power button
Date: Mon, 16 Apr 2012 09:58:52 +0800
Message-ID: <1334541532.2387.321.camel@rui.sh.intel.com>
References: <20120412163514.487C09D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8934 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab2DPB62 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Apr 2012 21:58:28 -0400
In-Reply-To: <20120412163514.487C09D401E@zog.reactivated.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, pgf@laptop.org, dilinger@queued.net, linux-pm@vger.kernel.org

On =E5=9B=9B, 2012-04-12 at 17:35 +0100, Daniel Drake wrote:
> When the system is woken up by the ACPI fixed power button, currently=
 there
> is no way of userspace becoming aware that the power button was press=
ed.
>=20
> OLPC would like to know this, so that we can respond appropriately.
> For example, if the system was woken up by a network packet, we know
> we can go back to sleep very quickly. But if the user explicitly woke=
 the
> system with the power button, we're going to want to stay awake for a
> while.
>=20
> The wakeup count mechanism seems like a good fit for communicating th=
is.
> Mark the fixed power button as wakeup-enabled, and increment its wake=
up
> counter when the system is woken with the power button. (The wakeup c=
ounter
> is also incremented when the power button is pressed during system
> operation; this is already handled by an existing acpi-button codepat=
h).
>=20
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/acpi/scan.c  |    1 +
>  drivers/acpi/sleep.c |   43 ++++++++++++++++++++++++++++++++++++++++=
+--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 767e2dc..bf1f4f7 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1566,6 +1566,7 @@ static int acpi_bus_scan_fixed(void)
>  						ACPI_BUS_TYPE_POWER_BUTTON,
>  						ACPI_STA_DEFAULT,
>  						&ops);
> +		device_init_wakeup(&device->dev, true);
>  	}
> =20
>  	if ((acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON) =3D=3D 0) {
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 1d661b5..2c88796 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -47,6 +47,7 @@ static u8 wake_sleep_flags(void)
>  }
> =20
>  static u8 sleep_states[ACPI_S_STATE_COUNT];
> +static bool pwr_btn_event_pending;
> =20
>  static void acpi_sleep_tts_switch(u32 acpi_state)
>  {
> @@ -176,6 +177,14 @@ static int acpi_pm_prepare(void)
>  	return error;
>  }
> =20
> +static int find_powerf_dev(struct device *dev, void *data)
> +{
> +	struct acpi_device *device =3D to_acpi_device(dev);
> +	const char *hid =3D acpi_device_hid(device);
> +
> +	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
> +}
> +
>  /**
>   *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>   *
> @@ -184,6 +193,7 @@ static int acpi_pm_prepare(void)
>   */
>  static void acpi_pm_finish(void)
>  {
> +	struct device *pwr_btn_dev;
>  	u32 acpi_state =3D acpi_target_sleep_state;
> =20
>  	acpi_ec_unblock_transactions();
> @@ -201,6 +211,21 @@ static void acpi_pm_finish(void)
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
> =20
>  	acpi_target_sleep_state =3D ACPI_STATE_S0;
> +
> +	/* If we were woken with the fixed power button, provide a small
> +	 * hint to userspace in the form of a wakeup event on the fixed pow=
er
> +	 * button device (if it can be found).
> +	 *
> +	 * We delay the event generation til now, as the PM layer requires
> +	 * timekeeping to be running before we generate events. */
> +	if (!pwr_btn_event_pending)
> +		return;
> +
> +	pwr_btn_event_pending =3D false;
> +	pwr_btn_dev =3D bus_find_device(&acpi_bus_type, NULL, NULL,
> +				      find_powerf_dev);
> +	if (pwr_btn_dev)
> +		pm_wakeup_event(pwr_btn_dev, 0);
>  }
> =20
>  /**
> @@ -291,9 +316,23 @@ static int acpi_suspend_enter(suspend_state_t pm=
_state)
>  	/* ACPI 3.0 specs (P62) says that it's the responsibility
>  	 * of the OSPM to clear the status bit [ implying that the
>  	 * POWER_BUTTON event should not reach userspace ]
> +	 *
> +	 * However, we do generate a small hint for userspace in the form o=
f
> +	 * a wakeup event. We flag this condition for now and generate the
> +	 * event later, as we're currently too early in resume to be able t=
o
> +	 * generate wakeup events.
>  	 */
> -	if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3))
> -		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> +	if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
> +		acpi_event_status pwr_btn_status;
> +
> +		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
> +
> +		if (pwr_btn_status & ACPI_EVENT_FLAG_SET) {
> +			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> +			/* Flag for later */
> +			pwr_btn_event_pending =3D true;
> +		}
> +	}
> =20
>  	/*
>  	 * Disable and clear GPE status before interrupt is enabled. Some G=
PEs


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
