From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 3/3] toshiba_acpi: Change HCI/SCI functions return
 code type
Date: Tue, 30 Sep 2014 13:58:14 -0700
Message-ID: <20140930205814.GB47302@vmdeb7>
References: <1412044809-3366-1-git-send-email-coproscefalo@gmail.com>
 <1412044809-3366-4-git-send-email-coproscefalo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412044809-3366-4-git-send-email-coproscefalo@gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Azael Avalos <coproscefalo@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 29, 2014 at 08:40:09PM -0600, Azael Avalos wrote:
> Currently the HCI/SCI read/write functions are returning
> the status of the ACPI call and also assigning the
> returned value of the HCI/SCI function, however, only
> the HCI/SCI status is being checked.
>=20
> This patch changes such functions, returning the value
> of the HCI/SCI function instead of the ACPI call status,
> eliminating one parameter, and returning something
> useful that indeed is being checked.
>=20
> Signed-off-by: Azael Avalos <coproscefalo@gmail.com>

Cc linux-acpi

Rafael,

This follows a couple patches renaming interfaces and error codes. Whil=
e
there is some information to be had in checking for ACPI specific error=
s, I
don't think it's significant to warrant asking Azael to go the other wa=
y and
check for them specifically and add errorcodes to the interface rather =
than
cleanup the functionality as it stands today and simplifiy the code as =
he does
here.

Any objection?

> ---
>  drivers/platform/x86/toshiba_acpi.c | 129 +++++++++++++++++---------=
----------
>  1 file changed, 62 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x=
86/toshiba_acpi.c
> index 589a858..5d509ea 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -317,47 +317,49 @@ static acpi_status tci_raw(struct toshiba_acpi_=
dev *dev,
>   * may be useful (such as "not supported").
>   */
> =20
> -static acpi_status hci_write1(struct toshiba_acpi_dev *dev, u32 reg,
> -			      u32 in1, u32 *result)
> +static u32 hci_write1(struct toshiba_acpi_dev *dev, u32 reg, u32 in1=
)
>  {
>  	u32 in[TCI_WORDS] =3D { HCI_SET, reg, in1, 0, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> -	*result =3D (status =3D=3D AE_OK) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return ACPI_SUCCESS(status) ? out[0] : TOS_FAILURE;
>  }
> =20
> -static acpi_status hci_read1(struct toshiba_acpi_dev *dev, u32 reg,
> -			     u32 *out1, u32 *result)
> +static u32 hci_read1(struct toshiba_acpi_dev *dev, u32 reg, u32 *out=
1)
>  {
>  	u32 in[TCI_WORDS] =3D { HCI_GET, reg, 0, 0, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> +	if (ACPI_FAILURE(status))
> +		return TOS_FAILURE;
> +
>  	*out1 =3D out[2];
> -	*result =3D (status =3D=3D AE_OK) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return out[0];
>  }
> =20
> -static acpi_status hci_write2(struct toshiba_acpi_dev *dev, u32 reg,
> -			      u32 in1, u32 in2, u32 *result)
> +static u32 hci_write2(struct toshiba_acpi_dev *dev, u32 reg, u32 in1=
, u32 in2)
>  {
>  	u32 in[TCI_WORDS] =3D { HCI_SET, reg, in1, in2, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> -	*result =3D (status =3D=3D AE_OK) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return ACPI_SUCCESS(status) ? out[0] : TOS_FAILURE;
>  }
> =20
> -static acpi_status hci_read2(struct toshiba_acpi_dev *dev, u32 reg,
> -			     u32 *out1, u32 *out2, u32 *result)
> +static u32 hci_read2(struct toshiba_acpi_dev *dev, u32 reg, u32 *out=
1, u32 *out2)
>  {
>  	u32 in[TCI_WORDS] =3D { HCI_GET, reg, *out1, *out2, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> +	if (ACPI_FAILURE(status))
> +		return TOS_FAILURE;
> +
>  	*out1 =3D out[2];
>  	*out2 =3D out[3];
> -	*result =3D (status =3D=3D AE_OK) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return out[0];
>  }
> =20
>  /* common sci tasks
> @@ -407,25 +409,26 @@ static void sci_close(struct toshiba_acpi_dev *=
dev)
>  		pr_info("Toshiba SCI is not present\n");
>  }
> =20
> -static acpi_status sci_read(struct toshiba_acpi_dev *dev, u32 reg,
> -			    u32 *out1, u32 *result)
> +static u32 sci_read(struct toshiba_acpi_dev *dev, u32 reg, u32 *out1=
)
>  {
>  	u32 in[TCI_WORDS] =3D { SCI_GET, reg, 0, 0, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> +	if (ACPI_FAILURE(status))
> +		return TOS_FAILURE;
> +
>  	*out1 =3D out[2];
> -	*result =3D (ACPI_SUCCESS(status)) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return out[0];
>  }
> =20
> -static acpi_status sci_write(struct toshiba_acpi_dev *dev, u32 reg,
> -			     u32 in1, u32 *result)
> +static u32 sci_write(struct toshiba_acpi_dev *dev, u32 reg, u32 in1)
>  {
>  	u32 in[TCI_WORDS] =3D { SCI_SET, reg, in1, 0, 0, 0 };
>  	u32 out[TCI_WORDS];
>  	acpi_status status =3D tci_raw(dev, in, out);
> -	*result =3D (ACPI_SUCCESS(status)) ? out[0] : TOS_FAILURE;
> -	return status;
> +
> +	return ACPI_SUCCESS(status) ? out[0] : TOS_FAILURE;
>  }
> =20
>  /* Illumination support */
> @@ -457,7 +460,6 @@ static void toshiba_illumination_set(struct led_c=
lassdev *cdev,
>  	struct toshiba_acpi_dev *dev =3D container_of(cdev,
>  			struct toshiba_acpi_dev, led_dev);
>  	u32 state, result;
> -	acpi_status status;
> =20
>  	/* First request : initialize communication. */
>  	if (!sci_open(dev))
> @@ -465,9 +467,9 @@ static void toshiba_illumination_set(struct led_c=
lassdev *cdev,
> =20
>  	/* Switch the illumination on/off */
>  	state =3D brightness ? 1 : 0;
> -	status =3D sci_write(dev, SCI_ILLUMINATION, state, &result);
> +	result =3D sci_write(dev, SCI_ILLUMINATION, state);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status)) {
> +	if (result =3D=3D TOS_FAILURE) {
>  		pr_err("ACPI call for illumination failed\n");
>  		return;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -481,16 +483,15 @@ static enum led_brightness toshiba_illumination=
_get(struct led_classdev *cdev)
>  	struct toshiba_acpi_dev *dev =3D container_of(cdev,
>  			struct toshiba_acpi_dev, led_dev);
>  	u32 state, result;
> -	acpi_status status;
> =20
>  	/*=A0First request : initialize communication. */
>  	if (!sci_open(dev))
>  		return LED_OFF;
> =20
>  	/* Check the illumination */
> -	status =3D sci_read(dev, SCI_ILLUMINATION, &state, &result);
> +	result =3D sci_read(dev, SCI_ILLUMINATION, &state);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status) || result =3D=3D TOS_INPUT_DATA_ERROR) {
> +	if (result =3D=3D TOS_FAILURE || result =3D=3D TOS_INPUT_DATA_ERROR=
) {
>  		pr_err("ACPI call for illumination failed\n");
>  		return LED_OFF;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -541,14 +542,13 @@ static int toshiba_kbd_illum_available(struct t=
oshiba_acpi_dev *dev)
>  static int toshiba_kbd_illum_status_set(struct toshiba_acpi_dev *dev=
, u32 time)
>  {
>  	u32 result;
> -	acpi_status status;
> =20
>  	if (!sci_open(dev))
>  		return -EIO;
> =20
> -	status =3D sci_write(dev, SCI_KBD_ILLUM_STATUS, time, &result);
> +	result =3D sci_write(dev, SCI_KBD_ILLUM_STATUS, time);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status) || result =3D=3D TOS_INPUT_DATA_ERROR) {
> +	if (result =3D=3D TOS_FAILURE || result =3D=3D TOS_INPUT_DATA_ERROR=
) {
>  		pr_err("ACPI call to set KBD backlight status failed\n");
>  		return -EIO;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -562,14 +562,13 @@ static int toshiba_kbd_illum_status_set(struct =
toshiba_acpi_dev *dev, u32 time)
>  static int toshiba_kbd_illum_status_get(struct toshiba_acpi_dev *dev=
, u32 *time)
>  {
>  	u32 result;
> -	acpi_status status;
> =20
>  	if (!sci_open(dev))
>  		return -EIO;
> =20
> -	status =3D sci_read(dev, SCI_KBD_ILLUM_STATUS, time, &result);
> +	result =3D sci_read(dev, SCI_KBD_ILLUM_STATUS, time);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status) || result =3D=3D TOS_INPUT_DATA_ERROR) {
> +	if (result =3D=3D TOS_FAILURE || result =3D=3D TOS_INPUT_DATA_ERROR=
) {
>  		pr_err("ACPI call to get KBD backlight status failed\n");
>  		return -EIO;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -585,11 +584,10 @@ static enum led_brightness toshiba_kbd_backligh=
t_get(struct led_classdev *cdev)
>  	struct toshiba_acpi_dev *dev =3D container_of(cdev,
>  			struct toshiba_acpi_dev, kbd_led);
>  	u32 state, result;
> -	acpi_status status;
> =20
>  	/* Check the keyboard backlight state */
> -	status =3D hci_read1(dev, HCI_KBD_ILLUMINATION, &state, &result);
> -	if (ACPI_FAILURE(status) || result =3D=3D TOS_INPUT_DATA_ERROR) {
> +	result =3D hci_read1(dev, HCI_KBD_ILLUMINATION, &state);
> +	if (result =3D=3D TOS_FAILURE || result =3D=3D TOS_INPUT_DATA_ERROR=
) {
>  		pr_err("ACPI call to get the keyboard backlight failed\n");
>  		return LED_OFF;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -606,12 +604,11 @@ static void toshiba_kbd_backlight_set(struct le=
d_classdev *cdev,
>  	struct toshiba_acpi_dev *dev =3D container_of(cdev,
>  			struct toshiba_acpi_dev, kbd_led);
>  	u32 state, result;
> -	acpi_status status;
> =20
>  	/* Set the keyboard backlight state */
>  	state =3D brightness ? 1 : 0;
> -	status =3D hci_write1(dev, HCI_KBD_ILLUMINATION, state, &result);
> -	if (ACPI_FAILURE(status) || result =3D=3D TOS_INPUT_DATA_ERROR) {
> +	result =3D hci_write1(dev, HCI_KBD_ILLUMINATION, state);
> +	if (result =3D=3D TOS_FAILURE || result =3D=3D TOS_INPUT_DATA_ERROR=
) {
>  		pr_err("ACPI call to set KBD Illumination mode failed\n");
>  		return;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -624,14 +621,13 @@ static void toshiba_kbd_backlight_set(struct le=
d_classdev *cdev,
>  static int toshiba_touchpad_set(struct toshiba_acpi_dev *dev, u32 st=
ate)
>  {
>  	u32 result;
> -	acpi_status status;
> =20
>  	if (!sci_open(dev))
>  		return -EIO;
> =20
> -	status =3D sci_write(dev, SCI_TOUCHPAD, state, &result);
> +	result =3D sci_write(dev, SCI_TOUCHPAD, state);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status)) {
> +	if (result =3D=3D TOS_FAILURE) {
>  		pr_err("ACPI call to set the touchpad failed\n");
>  		return -EIO;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -644,14 +640,13 @@ static int toshiba_touchpad_set(struct toshiba_=
acpi_dev *dev, u32 state)
>  static int toshiba_touchpad_get(struct toshiba_acpi_dev *dev, u32 *s=
tate)
>  {
>  	u32 result;
> -	acpi_status status;
> =20
>  	if (!sci_open(dev))
>  		return -EIO;
> =20
> -	status =3D sci_read(dev, SCI_TOUCHPAD, state, &result);
> +	result =3D sci_read(dev, SCI_TOUCHPAD, state);
>  	sci_close(dev);
> -	if (ACPI_FAILURE(status)) {
> +	if (result =3D=3D TOS_FAILURE) {
>  		pr_err("ACPI call to query the touchpad failed\n");
>  		return -EIO;
>  	} else if (result =3D=3D TOS_NOT_SUPPORTED) {
> @@ -767,7 +762,7 @@ static u32 hci_get_bt_present(struct toshiba_acpi=
_dev *dev, bool *present)
> =20
>  	value =3D 0;
>  	value2 =3D 0;
> -	hci_read2(dev, HCI_WIRELESS, &value, &value2, &hci_result);
> +	hci_result =3D hci_read2(dev, HCI_WIRELESS, &value, &value2);
>  	if (hci_result =3D=3D TOS_SUCCESS)
>  		*present =3D (value & HCI_WIRELESS_BT_PRESENT) ? true : false;
> =20
> @@ -781,7 +776,7 @@ static u32 hci_get_radio_state(struct toshiba_acp=
i_dev *dev, bool *radio_state)
> =20
>  	value =3D 0;
>  	value2 =3D 0x0001;
> -	hci_read2(dev, HCI_WIRELESS, &value, &value2, &hci_result);
> +	hci_result =3D hci_read2(dev, HCI_WIRELESS, &value, &value2);
> =20
>  	*radio_state =3D value & HCI_WIRELESS_KILL_SWITCH;
>  	return hci_result;
> @@ -808,8 +803,8 @@ static int bt_rfkill_set_block(void *data, bool b=
locked)
>  		goto out;
>  	}
> =20
> -	hci_write2(dev, HCI_WIRELESS, value, HCI_WIRELESS_BT_POWER, &result=
1);
> -	hci_write2(dev, HCI_WIRELESS, value, HCI_WIRELESS_BT_ATTACH, &resul=
t2);
> +	result1 =3D hci_write2(dev, HCI_WIRELESS, value, HCI_WIRELESS_BT_PO=
WER);
> +	result2 =3D hci_write2(dev, HCI_WIRELESS, value, HCI_WIRELESS_BT_AT=
TACH);
> =20
>  	if (result1 !=3D TOS_SUCCESS || result2 !=3D TOS_SUCCESS)
>  		err =3D -EIO;
> @@ -854,7 +849,7 @@ static int get_tr_backlight_status(struct toshiba=
_acpi_dev *dev, bool *enabled)
>  	u32 hci_result;
>  	u32 status;
> =20
> -	hci_read1(dev, HCI_TR_BACKLIGHT, &status, &hci_result);
> +	hci_result =3D hci_read1(dev, HCI_TR_BACKLIGHT, &status);
>  	*enabled =3D !status;
>  	return hci_result =3D=3D TOS_SUCCESS ? 0 : -EIO;
>  }
> @@ -864,7 +859,7 @@ static int set_tr_backlight_status(struct toshiba=
_acpi_dev *dev, bool enable)
>  	u32 hci_result;
>  	u32 value =3D !enable;
> =20
> -	hci_write1(dev, HCI_TR_BACKLIGHT, value, &hci_result);
> +	hci_result =3D hci_write1(dev, HCI_TR_BACKLIGHT, value);
>  	return hci_result =3D=3D TOS_SUCCESS ? 0 : -EIO;
>  }
> =20
> @@ -886,7 +881,7 @@ static int __get_lcd_brightness(struct toshiba_ac=
pi_dev *dev)
>  		brightness++;
>  	}
> =20
> -	hci_read1(dev, HCI_LCD_BRIGHTNESS, &value, &hci_result);
> +	hci_result =3D hci_read1(dev, HCI_LCD_BRIGHTNESS, &value);
>  	if (hci_result =3D=3D TOS_SUCCESS)
>  		return brightness + (value >> HCI_LCD_BRIGHTNESS_SHIFT);
> =20
> @@ -1001,7 +996,7 @@ static int get_video_status(struct toshiba_acpi_=
dev *dev, u32 *status)
>  {
>  	u32 hci_result;
> =20
> -	hci_read1(dev, HCI_VIDEO_OUT, status, &hci_result);
> +	hci_result =3D hci_read1(dev, HCI_VIDEO_OUT, status);
>  	return hci_result =3D=3D TOS_SUCCESS ? 0 : -EIO;
>  }
> =20
> @@ -1105,7 +1100,7 @@ static int get_fan_status(struct toshiba_acpi_d=
ev *dev, u32 *status)
>  {
>  	u32 hci_result;
> =20
> -	hci_read1(dev, HCI_FAN, status, &hci_result);
> +	hci_result =3D hci_read1(dev, HCI_FAN, status);
>  	return hci_result =3D=3D TOS_SUCCESS ? 0 : -EIO;
>  }
> =20
> @@ -1145,7 +1140,7 @@ static ssize_t fan_proc_write(struct file *file=
, const char __user *buf,
> =20
>  	if (sscanf(cmd, " force_on : %i", &value) =3D=3D 1 &&
>  	    value >=3D 0 && value <=3D 1) {
> -		hci_write1(dev, HCI_FAN, value, &hci_result);
> +		hci_result =3D hci_write1(dev, HCI_FAN, value);
>  		if (hci_result !=3D TOS_SUCCESS)
>  			return -EIO;
>  		else
> @@ -1173,7 +1168,7 @@ static int keys_proc_show(struct seq_file *m, v=
oid *v)
>  	u32 value;
> =20
>  	if (!dev->key_event_valid && dev->system_event_supported) {
> -		hci_read1(dev, HCI_SYSTEM_EVENT, &value, &hci_result);
> +		hci_result =3D hci_read1(dev, HCI_SYSTEM_EVENT, &value);
>  		if (hci_result =3D=3D TOS_SUCCESS) {
>  			dev->key_event_valid =3D 1;
>  			dev->last_key_event =3D value;
> @@ -1183,7 +1178,7 @@ static int keys_proc_show(struct seq_file *m, v=
oid *v)
>  			/* This is a workaround for an unresolved issue on
>  			 * some machines where system events sporadically
>  			 * become disabled. */
> -			hci_write1(dev, HCI_SYSTEM_EVENT, 1, &hci_result);
> +			hci_result =3D hci_write1(dev, HCI_SYSTEM_EVENT, 1);
>  			pr_notice("Re-enabled hotkeys\n");
>  		} else {
>  			pr_err("Error reading hotkey status\n");
> @@ -1677,7 +1672,7 @@ static int toshiba_acpi_setup_keyboard(struct t=
oshiba_acpi_dev *dev)
>  	if (acpi_has_method(dev->acpi_dev->handle, "INFO"))
>  		dev->info_supported =3D 1;
>  	else {
> -		hci_write1(dev, HCI_SYSTEM_EVENT, 1, &hci_result);
> +		hci_result =3D hci_write1(dev, HCI_SYSTEM_EVENT, 1);
>  		if (hci_result =3D=3D TOS_SUCCESS)
>  			dev->system_event_supported =3D 1;
>  	}
> @@ -1700,7 +1695,7 @@ static int toshiba_acpi_setup_keyboard(struct t=
oshiba_acpi_dev *dev)
>  		goto err_remove_filter;
>  	}
> =20
> -	hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_ENABLE, &hci_result);
> +	hci_result =3D hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_ENABLE)=
;
>  	return 0;
> =20
>   err_remove_filter:
> @@ -1961,7 +1956,7 @@ static void toshiba_acpi_notify(struct acpi_dev=
ice *acpi_dev, u32 event)
>  			toshiba_acpi_report_hotkey(dev, scancode);
>  	} else if (dev->system_event_supported) {
>  		do {
> -			hci_read1(dev, HCI_SYSTEM_EVENT, &value, &hci_result);
> +			hci_result =3D hci_read1(dev, HCI_SYSTEM_EVENT, &value);
>  			switch (hci_result) {
>  			case TOS_SUCCESS:
>  				toshiba_acpi_report_hotkey(dev, (int)value);
> @@ -1972,8 +1967,8 @@ static void toshiba_acpi_notify(struct acpi_dev=
ice *acpi_dev, u32 event)
>  				 * issue on some machines where system events
>  				 * sporadically become disabled.
>  				 */
> -				hci_write1(dev, HCI_SYSTEM_EVENT, 1,
> -					   &hci_result);
> +				hci_result =3D
> +					hci_write1(dev, HCI_SYSTEM_EVENT, 1);
>  				pr_notice("Re-enabled hotkeys\n");
>  				/* fall through */
>  			default:
> @@ -1991,7 +1986,7 @@ static int toshiba_acpi_suspend(struct device *=
device)
>  	u32 result;
> =20
>  	if (dev->hotkey_dev)
> -		hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_DISABLE, &result);
> +		result =3D hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_DISABLE);
> =20
>  	return 0;
>  }
> @@ -2008,7 +2003,7 @@ static int toshiba_acpi_resume(struct device *d=
evice)
>  		if (ACPI_FAILURE(status))
>  			pr_info("Unable to re-enable hotkeys\n");
> =20
> -		hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_ENABLE, &result);
> +		result =3D hci_write1(dev, HCI_HOTKEY_EVENT, HCI_HOTKEY_ENABLE);
>  	}
> =20
>  	return 0;
> --=20
> 2.0.0
>=20
>=20

--=20
Darren Hart
Intel Open Source Technology Center
