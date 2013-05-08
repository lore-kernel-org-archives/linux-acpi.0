From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [FIX PATCH] ACPI/AC: Add sleep quirk for Thinkpad e530
Date: Wed, 08 May 2013 09:32:17 +0800
Message-ID: <5189AB21.50203@intel.com>
References: <1367843253-13021-1-git-send-email-tianyu.lan@intel.com> <1623264.1zFYjzoa3n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9803 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291Ab3EHBiL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 21:38:11 -0400
In-Reply-To: <1623264.1zFYjzoa3n@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On 2013=E5=B9=B405=E6=9C=8808=E6=97=A5 07:54, Rafael J. Wysocki wrote:
> On Monday, May 06, 2013 08:27:33 PM Lan Tianyu wrote:
>> Thinkpad e530 bios notify ac device first and then sleep
>> a specific time before doing actual operations in the
>> EC event handler(_Qxx). This will cause the AC state
>> reported by ACPI event.
>>
>> Method (_Q27, 0, NotSerialized)
>> {
>>       Notify (AC, 0x80)
>>       Sleep (0x03E8)
>>       Store (Zero, PWRS)
>>       PNOT ()
>> }
>>
>> This patch is to add a 1s sleep in the ac driver's
>> notify handler before acpi_ac_get_state() to make
>> sure get right state.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D45221
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/ac.c |   32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>> index 6d5bf64..0292cbb 100644
>> --- a/drivers/acpi/ac.c
>> +++ b/drivers/acpi/ac.c
>> @@ -28,6 +28,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/init.h>
>>  #include <linux/types.h>
>> +#include <linux/dmi.h>
>> +#include <linux/delay.h>
>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>>  #include <linux/proc_fs.h>
>>  #include <linux/seq_file.h>
>> @@ -74,6 +76,8 @@ static int acpi_ac_resume(struct device *dev);
>>  #endif
>>  static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
>> =20
>> +static int ac_flag_sleep_for_get_state;
>=20
> Hmm.  Why don't you replace ac_flag_sleep_for_get_state with the time
> to sleep in acpi_ac_notify(), something like ac_sleep_before_get_stat=
e_ms
> and then do something like this ->
>=20
>> +
>>  static struct acpi_driver acpi_ac_driver =3D {
>>  	.name =3D "ac",
>>  	.class =3D ACPI_AC_CLASS,
>> @@ -252,6 +256,15 @@ static void acpi_ac_notify(struct acpi_device *=
device, u32 event)
>>  	case ACPI_AC_NOTIFY_STATUS:
>>  	case ACPI_NOTIFY_BUS_CHECK:
>>  	case ACPI_NOTIFY_DEVICE_CHECK:
>> +		/* Some buggy bios notify ac device first and then sleep
>> +		 * a specific time before doing actual operations in the
>> +		 * EC event handler(_Qxx). This will cause the AC state
>> +		 * reported by ACPI event wrong. So add a 1s sleep here
>> +		 * to ensure get correct state.
>> +		 */
>> +		if (ac_flag_sleep_for_get_state)
>> +			msleep(1000);
>=20
> -> if (ac_sleep_before_get_state_ms > 0)
> 			msleep(ac_sleep_before_get_state_ms);
>=20
> and *then* set ac_sleep_before_get_state_ms to 1000 in the Thinkpad e=
530
> specific quirk?
>=20
> If we find another machine having this problem in the future, but nee=
ding
> a different sleep time, it will be easier to add it to the blacklist =
in that
> case.
Yes, that will be more flexible. Thanks for your advice. I will update =
soon.
>=20
> Thanks,
> Rafael
>=20
>=20
>> +
>>  		acpi_ac_get_state(ac);
>>  		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
>>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>> @@ -264,6 +277,24 @@ static void acpi_ac_notify(struct acpi_device *=
device, u32 event)
>>  	return;
>>  }
>> =20
>> +static int ac_sleep_for_get_state(const struct dmi_system_id *d)
>> +{
>> +	ac_flag_sleep_for_get_state =3D 1;
>> +	return 0;
>> +}
>> +
>> +static struct dmi_system_id __initdata ac_dmi_table[] =3D {
>> +	{
>> +	.callback =3D ac_sleep_for_get_state,
>> +	.ident =3D "thinkpad e530",
>> +	.matches =3D {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
>> +		},
>> +	},
>> +	{},
>> +};
>> +
>>  static int acpi_ac_add(struct acpi_device *device)
>>  {
>>  	int result =3D 0;
>> @@ -312,6 +343,7 @@ static int acpi_ac_add(struct acpi_device *devic=
e)
>>  		kfree(ac);
>>  	}
>> =20
>> +	dmi_check_system(ac_dmi_table);
>>  	return result;
>>  }
>> =20
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
