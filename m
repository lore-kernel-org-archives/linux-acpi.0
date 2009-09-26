From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PATCH 5/6] thinkpad-acpi: add internal hotkey event API
Date: Sat, 26 Sep 2009 14:29:30 +0530
Message-ID: <1253955570.3897.4.camel@ht.satnam>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
	 <1253466567-4285-6-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60610 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbZIZJAs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 05:00:48 -0400
In-Reply-To: <1253466567-4285-6-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Hello,

On Sun, 2009-09-20 at 14:09 -0300, Henrique de Moraes Holschuh wrote:
> Add an internal API to the driver, to allow subdrivers to request and
> receive HKEY 0x1000 events.  This API will be used by the backlight
> (brightness up/down) and upcoming ALSA mixer (volume up/down/mute)
> subdrivers.
>=20
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/platform/x86/thinkpad_acpi.c |   48 ++++++++++++++++++++++++=
++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/=
x86/thinkpad_acpi.c
> index 50aa4c1..ffd584c 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -2014,6 +2014,9 @@ static u16 *hotkey_keycode_map;
> =20
>  static struct attribute_set *hotkey_dev_attributes;
> =20
> +static void tpacpi_driver_event(const unsigned int hkey_event);
> +static void hotkey_driver_event(const unsigned int scancode);
> +
>  /* HKEY.MHKG() return bits */
>  #define TP_HOTKEY_TABLET_MASK (1 << 3)
> =20
> @@ -2168,6 +2171,35 @@ static int hotkey_user_mask_set(const u32 mask=
)
>  	return rc;
>  }
> =20
> +/*
> + * Sets the driver hotkey mask.
> + *
> + * Can be called even if the hotkey subdriver is inactive
> + */
> +static int tpacpi_hotkey_driver_mask_set(const u32 mask)


  CC [M]  drivers/platform/x86/thinkpad_acpi.o
drivers/platform/x86/thinkpad_acpi.c:2225: warning: =E2=80=98tpacpi_hot=
key_driver_mask_set=E2=80=99 defined but not used

Thanks,
--
JSR

> +{
> +	int rc;
> +
> +	/* Do the right thing if hotkey_init has not been called yet */
> +	if (!tp_features.hotkey) {
> +		hotkey_driver_mask =3D mask;
> +		return 0;
> +	}
> +
> +	mutex_lock(&hotkey_mutex);
> +
> +	HOTKEY_CONFIG_CRITICAL_START
> +	hotkey_driver_mask =3D mask;
> +	hotkey_source_mask |=3D (mask & ~hotkey_all_mask);
> +	HOTKEY_CONFIG_CRITICAL_END
> +
> +	rc =3D hotkey_mask_set((hotkey_acpi_mask | hotkey_driver_mask) &
> +							~hotkey_source_mask);
> +	mutex_unlock(&hotkey_mutex);
> +
> +	return rc;
> +}
> +
>  static int hotkey_status_get(int *status)
>  {
>  	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
> @@ -2227,6 +2259,7 @@ static void tpacpi_input_send_key(const unsigne=
d int scancode)
>  /* Do NOT call without validating scancode first */
>  static void tpacpi_input_send_key_masked(const unsigned int scancode=
)
>  {
> +	hotkey_driver_event(scancode);
>  	if (hotkey_user_mask & (1 << scancode))
>  		tpacpi_input_send_key(scancode);
>  }
> @@ -7625,6 +7658,21 @@ static struct ibm_struct fan_driver_data =3D {
>   *******************************************************************=
*********
>   *******************************************************************=
*********/
> =20
> +/*
> + * HKEY event callout for other subdrivers go here
> + * (yes, it is ugly, but it is quick, safe, and gets the job done
> + */
> +static void tpacpi_driver_event(const unsigned int hkey_event)
> +{
> +}
> +
> +
> +
> +static void hotkey_driver_event(const unsigned int scancode)
> +{
> +	tpacpi_driver_event(0x1001 + scancode);
> +}
> +
>  /* sysfs name ------------------------------------------------------=
---- */
>  static ssize_t thinkpad_acpi_pdev_name_show(struct device *dev,
>  			   struct device_attribute *attr,

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
