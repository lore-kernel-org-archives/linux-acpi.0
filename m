From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] ACPI: thermal fixup for broken BIOS which has invalid
 trip points
Date: Tue, 11 Mar 2008 22:23:51 +0100
Message-ID: <47D6F867.8000704@freemail.hu>
References: <1205114031.10256.193.camel@acpi-hp-zz.sh.intel.com>	 <200803110235.55358.lenb@kernel.org> <1205221971.2240.11.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail00a.mail.t-online.hu ([84.2.40.5]:55646 "EHLO
	mail00a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYCKVX5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 17:23:57 -0400
In-Reply-To: <1205221971.2240.11.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Zhang, Rui wrote:
> On Tue, 2008-03-11 at 14:35 +0800, Len Brown wrote:
>> On Sunday 09 March 2008, Zhang, Rui wrote:
>>> thermal fixup for broken BIOS which has invalid trip points.
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D8544
>>> http://marc.info/?l=3Dlinux-kernel&m=3D120496222629983&w=3D2
>>>
>>> Signed-off-by: Zhang Rui<rui.zhang@intel.com>
>>> ---
>>>  drivers/acpi/thermal.c |    4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-2.6/drivers/acpi/thermal.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-2.6.orig/drivers/acpi/thermal.c
>>> +++ linux-2.6/drivers/acpi/thermal.c
>>> @@ -326,7 +326,9 @@ static int acpi_thermal_set_cooling_mode
>>>  #define ACPI_TRIPS_ACTIVE    0x08
>>>  #define ACPI_TRIPS_DEVICES   0x10
>>>
>>> -#define ACPI_TRIPS_REFRESH_THRESHOLDS        (ACPI_TRIPS_PASSIVE |
>> ACPI_TRIPS_ACTIVE)
>>> +#define ACPI_TRIPS_REFRESH_THRESHOLDS        (ACPI_TRIPS_PASSIVE |
>> \
>>> +                                      ACPI_TRIPS_ACTIVE |    \
>>> +                                      ACPI_TRIPS_DEVICES)
>>>  #define ACPI_TRIPS_REFRESH_DEVICES   ACPI_TRIPS_DEVICES
>>>
>>>  #define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT
>> | \
>>>
>> I don't like re-evaluating _AL0 on notify 0x81 as a workaround
>> to notice that there _is_ no _AL0.  We should re-evaluate _AL0
>> on notify x82 -- per the spec.
> I agree.
>> We should print out a single exeception at boot time when
>> we realize that the BIOS has a bug of no _AL0 for the _AC0.
>> At run time, we should have no concept of a valid _AC0
>> and thus a notify x81 should not try to use it.
> OK.
> With the refreshed patch applied, ACPI thermal driver will not try to
> evaluate any invalid trip points for notification 0X81. And a warn
> message is printed out at boot time.
>=20
> Marton, can you try this patch and attach the dmesg output please? :)
>=20
> thermal fixup for broken BIOS which has invalid trip points.
>=20
> ACPI thermal driver only re-evaluate valid trip points.
> For the broken BIOS show in
> http://bugzilla.kernel.org/show_bug.cgi?id=3D8544
> the active[0] is set to invalid at boot time
> and it will not be re-evaluated again.
> We can still get a warning message at boot time.
>=20
> http://marc.info/?l=3Dlinux-kernel&m=3D120496222629983&w=3D2
>=20
> Signed-off-by: Zhang Rui<rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -401,7 +401,8 @@ static int acpi_thermal_trips_update(str
>  	}
> =20
>  	/* Passive (optional) */
> -	if (flag & ACPI_TRIPS_PASSIVE) {
> +	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) =
||
> +		(flag =3D=3D ACPI_TRIPS_INIT)) {
>  		valid =3D tz->trips.passive.flags.valid;
>  		if (psv =3D=3D -1) {
>  			status =3D AE_SUPPORT;
> @@ -440,8 +441,11 @@ static int acpi_thermal_trips_update(str
>  		memset(&devices, 0, sizeof(struct acpi_handle_list));
>  		status =3D acpi_evaluate_reference(tz->device->handle, "_PSL",
>  							NULL, &devices);
> -		if (ACPI_FAILURE(status))
> +		if (ACPI_FAILURE(status)) {
> +			printk(KERN_WARNING PREFIX
> +				"Invalid passive threshold\n");
>  			tz->trips.passive.flags.valid =3D 0;
> +		}
>  		else
>  			tz->trips.passive.flags.valid =3D 1;
> =20
> @@ -465,7 +469,8 @@ static int acpi_thermal_trips_update(str
>  		if (act =3D=3D -1)
>  			break; /* disable all active trip points */
> =20
> -		if (flag & ACPI_TRIPS_ACTIVE) {
> +		if ((flag =3D=3D ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &=
&
> +			tz->trips.active[i].flags.valid)) {
>  			status =3D acpi_evaluate_integer(tz->device->handle,
>  				name, NULL, &tz->trips.active[i].temperature);
>  			if (ACPI_FAILURE(status)) {
> @@ -497,8 +502,11 @@ static int acpi_thermal_trips_update(str
>  			memset(&devices, 0, sizeof(struct acpi_handle_list));
>  			status =3D acpi_evaluate_reference(tz->device->handle,
>  						name, NULL, &devices);
> -			if (ACPI_FAILURE(status))
> +			if (ACPI_FAILURE(status)) {
> +				printk(KERN_WARNING PREFIX
> +					"Invalid active%d threshold\n", i);
>  				tz->trips.active[i].flags.valid =3D 0;
> +			}
>  			else
>  				tz->trips.active[i].flags.valid =3D 1;

I tried Linux 2.6.25-rc5 with Clevo D410J. The following message appear=
s:

| ACPI Exception (thermal-0514): AE_ERROR, ACPI thermal trip point stat=
e changed
| Please send acpidump to linux-acpi@vger.kernel.org
|  [20070126]

I applied this patch to 2.6.25-rc5 on Clevo D410J. I found that the pre=
vious
message does not appear anymore.

The third trial I did was to also apply the previous debug patch, so I =
can
see if there was any events. The result is:

[    8.955518] ACPI thermal trips update, flag is 1f
[    8.955686] Checking invalid passive trip point...
[    8.956254] Checking invalid active[0] trip point...
[    8.956367] ACPI: Invalid active0 threshold
[    8.956921] ACPI: LNXTHERM:01 is registered as thermal_zone0
[    8.957833] ACPI: Thermal Zone [THRM] (57 C)

=2E..

[  236.669619] ACPI thermal trips update, flag is c
[  236.669638] Checking valid passive trip point...
[  236.672311] Checking invalid active[0] trip point...

I think that this patch works good with my hardware.

	M=E1rton N=E9meth
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
