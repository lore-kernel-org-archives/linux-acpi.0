From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS
	provides one
Date: Mon, 25 Aug 2008 09:58:16 +0800
Message-ID: <1219629496.24775.22.camel@rzhang-dt>
References: <20080821174852.0689681d@hyperion.delvare>
	 <1219615897-21130-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62911 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbYHYB65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 21:58:57 -0400
In-Reply-To: <1219615897-21130-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: khali@linux-fr.org, linux-acpi@vger.kernel.org

On Mon, 2008-08-25 at 06:11 +0800, Thomas Renninger wrote:
> On a HP tx2500z laptop one thermal device provides this function:
>             Name (REGN, "Processor Thermal Zone")
>=20
> Evaluate it and pass it as a name to hwmon.
>=20
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/acpi/thermal.c        |   15 ++++++++++++++-
>  drivers/thermal/thermal_sys.c |   11 +++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 9127036..8095e9e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1600,11 +1600,24 @@ static void acpi_thermal_notify(acpi_handle
> handle, u32 event, void *data)
>  static int acpi_thermal_get_info(struct acpi_thermal *tz)
>  {
>         int result =3D 0;
> -
> +       char *name =3D NULL;
> +       acpi_status status;
>=20
>         if (!tz)
>                 return -EINVAL;
>=20
> +       /* Get optional name of the thermal zone */
> +       status =3D acpi_evaluate_string(tz->device->handle, "REGN",
> NULL,
> +                                     &name);

As this is not defined in the ACPI spec, I don't know if it's
appropriate to implement this in the generic code.

> +       if (ACPI_SUCCESS(status)){
> +               ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal zone %s has
> name: "
> +                                 "%s\n", acpi_device_bid(tz->device)=
,
> name));
> +               /* This is hard coded limited to 16, why? */
> +               strncpy(tz->thermal_zone->temp_input.name, name, 16);
> +               kfree(name);
> +               tz->thermal_zone->temp_input.name[15] =3D '\n';
> +       }
> +
>         /* Get temperature [_TMP] (required) */
>         result =3D acpi_thermal_get_temperature(tz);
>         if (result)
> diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c
> index fe07462..51a7077 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -371,8 +371,15 @@ thermal_add_hwmon_sysfs(struct
> thermal_zone_device *tz)
>         tz->hwmon =3D hwmon;
>         hwmon->count++;
>=20
> -       snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
> -                "temp%d_input", hwmon->count);
> +       /*
> +        * What happens if we get duplicate zone names from the BIOS?
> +        * Is that allowed? If not, should we still just add the
> +        * hwmon count at the end?
> +        * tz->temp_input.name is char[16], this is ugly to do...
> +        */
> +       if (!tz->temp_input.name)
> +               snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
> +                        "temp%d_input", hwmon->count);
we should create a new attribute here rather than replacing the old one=
=2E
the new hwmon sysfs I/F should be like:
temp1_input:	current temperature
temp1_crit:	critical threshold
temp1_label:	string like "=EF=BB=BFProcessor Thermal Zone"

thanks,
rui
>         tz->temp_input.attr.attr.name =3D tz->temp_input.name;
>         tz->temp_input.attr.attr.mode =3D 0444;
>         tz->temp_input.attr.show =3D temp_input_show;
> --
> 1.5.4.5
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
