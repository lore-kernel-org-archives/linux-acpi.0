From: Shuduo Sang <shuduo.sang@canonical.com>
Subject: Re: [RFC PATCH] support Thinkpad X1 Carbon's adaptive keyboard
Date: Mon, 03 Mar 2014 21:06:29 +0800
Message-ID: <53147E55.4060103@canonical.com>
References: <53142D51.3010403@canonical.com> <87mwh71r2y.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <87mwh71r2y.fsf@nemi.mork.no>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ibm-acpi@hmh.eng.br, matthew.garrett@nebula.com, platform-driver-x86@vger.kernel.org, bruce.ma@canonical.com
List-Id: linux-acpi@vger.kernel.org


hi Bj=C3=B8rn,

Thanks for your comment. I will send V2 later.


On 03/03/2014 07:04 PM, Bj=C3=B8rn Mork wrote:
> Shuduo Sang <shuduo.sang@canonical.com> writes:
>=20
>> Hi all,
>>
>> We are working together with Lenovo to enable thinkpad X1 Carbon's
>> fancy feature, Adaptive Keyboard[1] for Linux. Adaptive keyboard has
>> five modes on Windows including Home mode, Web browser mode, Web
>> conference mode, Function mode and Lay-flat mode. We enabled Home
>> mode and Function mode currently. Will try to find out how to enable
>> other modes later. Please review and comment attached patch.
>>
>> Thanks,
>> Shuduo
>>
>> [1]:http://shop.lenovo.com/us/en/laptops/thinkpad/x-series/x1-carbon=
/#features
>>
>>
>> From da9d43beaa23071558a8031950cc21cc93946ec6 Mon Sep 17 00:00:00 20=
01
>> From: Shuduo Sang <sangshuduo@gmail.com>
>> Date: Mon, 3 Mar 2014 14:29:32 +0800
>> Subject: [PATCH] support thinkpad X1 Carbon's adaptive keyboard
>>
>> Thinkpad X1 Carbon's adaptive keyboard has five modes including Home
>> mode, Web browser mode, Web conference mode, Function mode and Lay-f=
lat
>> mode. We support Home mode and Function mode currently.
>>
>> Signed-off-by: Bruce Ma <bruce.ma@canonical.com>
>> Signed-off-by: Shuduo Sang <shuduo.sang@canonical.com>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 97
>> ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index defb6af..fcb738e 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -3437,6 +3437,101 @@ err_exit:
>>  	return (res < 0)? res : 1;
>>  }
>>
>> +/* Thinkpad X1 Carbon support 5 modes including Home mode, Web brow=
ser
>> + * mode, Web conference mode, Function mode and Lay-flat mode.
>> + * We support Home mode and Function mode currently.
>> + *
>> + * Will consider support rest of modes in future.
>> + *
>> + */
>> +enum ADAPTIVE_KEY_MODE {
>> +	HOME_MODE,
>> +	WEB_BROWSER_MODE,
>> +	WEB_CONFERENCE_MODE,
>> +	FUNCTION_MODE,
>> +	LAYFLAT_MODE
>> +};
>> +
>> +int adaptive_keyboard_modes[] =3D {
>> +	HOME_MODE,
>> +/*	WEB_BROWSER_MODE =3D 2,
>> +	WEB_CONFERENCE_MODE =3D 3, */
>> +	FUNCTION_MODE
>> +};
>> +
>> +#define DFR_CHANGE_ROW			0x101
>> +#define DFR_SHOW_QUICKVIEW_ROW		0x102
>> +
>> +/* press Fn key a while second, it will switch to Function Mode. Th=
en
>> + * release Fn key, previous mode be restored.
>> + */
>> +bool adaptive_keyboard_mode_is_saved;
>> +int adaptive_keybarod_prev_mode;
>=20
> speling:  s/keybarod/keyboard/
>=20
> You need to change it where this variable is used below as well.
>=20
>> +static int adaptive_keyboard_get_next_mode(int mode)
>> +{
>> +	int i;
>> +	int max_mode =3D sizeof(adaptive_keyboard_modes)/sizeof(int) - 1;
>=20
> ARRAY_SIZE
>=20
>=20
>> +	for (i =3D 0; i <=3D max_mode; i++) {
>> +		if (adaptive_keyboard_modes[i] =3D=3D mode)
>> +			break;
>> +	}
>> +
>> +	if (i >=3D max_mode)
>> +		i =3D 0;
>> +	else
>> +		i++;
>> +
>> +	return adaptive_keyboard_modes[i];
>> +}
>> +
>> +static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int sca=
ncode)
>> +{
>> +	u32 current_mode =3D 0;
>> +	int new_mode =3D 0;
>> +
>> +	switch (scancode) {
>> +	case DFR_CHANGE_ROW:
>> +		if (adaptive_keyboard_mode_is_saved) {
>> +			new_mode =3D adaptive_keybarod_prev_mode;
>> +			adaptive_keyboard_mode_is_saved =3D false;
>> +		} else {
>> +			if (!acpi_evalf(
>> +					hkey_handle, &current_mode,
>> +					"GTRW", "dd", 0)) {
>> +				pr_err("Cannot read adaptive keyboard mode\n");
>> +				return false;
>=20
> Not sure about this return value (resulting in an "unhandled HKEY eve=
nt"
> message).  See below.
>=20
>> +			} else {
>> +				new_mode =3D adaptive_keyboard_get_next_mode(
>> +						current_mode);
>> +			}
>> +		}
>> +
>> +		if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd", new_mode))
>> +			pr_err("Cannot set adaptive keyboard mode\n");
>> +
>> +		return true;
>> +
>> +	case DFR_SHOW_QUICKVIEW_ROW:
>> +		if (!acpi_evalf(hkey_handle,
>> +				&adaptive_keybarod_prev_mode,
>> +				"GTRW", "dd", 0)) {
>> +			pr_err("Cannot read adaptive keyboard mode\n");
>=20
> You should at least return a consistent result for this error.  Eithe=
r
> return true above or false here.
>=20
>> +		} else {
>> +			adaptive_keyboard_mode_is_saved =3D true;
>> +
>> +			if (!acpi_evalf(hkey_handle,
>> +					NULL, "STRW", "vd", FUNCTION_MODE))
>> +				pr_err("Cannot set adaptive keyboard mode\n");
>> +		}
>> +		return true;
>> +
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>>  static bool hotkey_notify_hotkey(const u32 hkey,
>>  				 bool *send_acpi_ev,
>>  				 bool *ignore_acpi_ev)
>> @@ -3456,6 +3551,8 @@ static bool hotkey_notify_hotkey(const u32 hke=
y,
>>  			*ignore_acpi_ev =3D true;
>>  		}
>>  		return true;
>> +	} else {
>> +		return adaptive_keyboard_hotkey_notify_hotkey(scancode);
>>  	}
>>  	return false;
>=20
> This isn't reached anymore...
>=20
>=20
>>  }
>=20
>=20
> I also think you should consider how this UI will look if you ever
> decide to enable all the modes.  AFAICS, you will then have inconsist=
ent
> behaviour for the DFR_CHANGE_ROW scancode in FUNCTION_MODE:
>=20
>  a) if FUNCTION_MODE was enabled by DFR_SHOW_QUICKVIEW_ROW then next
>       mode is x, where x can be any mode active before the
>       DFR_SHOW_QUICKVIEW_ROW event _including_ FUNCTION_MODE
>  b) if FUNCTION_MODE was enabled by DFR_CHANGE_ROW then next
>       mode is LAYFLAT_MODE
>=20

Press Fn key and don't release will switch Adaptive Keyboard to Functio=
n
mode whatever current mode is. And release Fn key will restore it to ol=
d
mode including Function mode. So current logic should not confuse end
user here. :)

LAYFLAT_MODE can be triged by putting screen to flat only, not by Fn
key. Maybe list LAYFLAT_MODE with other modes will confuse others and
make program need special logic to switch mode. I'm thinking over this
too. Since unsupported modes still not clear, I wish following patch ca=
n
handle them good.

> So the user won't really know the effect of a DFR_CHANGE_ROW event in
> FUNCTION_MODE.
>=20

DRF_CHANGE_ROW event in FUNCTION_MODE should always change keyboard to
Home mode.

> Wouldn't it make more sense if DFR_SHOW_QUICKVIEW_ROW always toggled
> between FUNCTION_MODE and some other mode, and DFR_CHANGE_ROW always
> cycled through the modes? =20
>=20
> Or is the UI locked by whatever the Windows driver does? (I don't hav=
e
> any X1 Carbon, so I don't know how the users expect this to work)
>=20

On Windows, DFR_CHANGE_ROW will switch keyboard among four modes. On
Linux, currently switch between Home mode and Function mode. Since not
all Windows function can be mapped to Linux like Web conference, so
Linux user don't expect those modes appear too. I think it makes sense
too. :)


>=20
> Bj=C3=B8rn
>=20
