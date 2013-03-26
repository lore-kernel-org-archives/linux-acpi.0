From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Tue, 26 Mar 2013 22:11:56 +0100
Message-ID: <51520F1C.8070904@linaro.org>
References: <20130313022759.GA120840@bee> <5151BD10.3000108@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:32875 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab3CZVMA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Mar 2013 17:12:00 -0400
Received: by mail-we0-f176.google.com with SMTP id s43so2403749wey.7
        for <linux-acpi@vger.kernel.org>; Tue, 26 Mar 2013 14:11:58 -0700 (PDT)
In-Reply-To: <5151BD10.3000108@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Changlong Xie <changlongx.xie@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, lkp@linux.intel.com

On 03/26/2013 04:21 PM, Alex Shi wrote:
> On 03/13/2013 10:27 AM, Changlong Xie wrote:
>> Hi Len,
>>
>> 	FYI, since 3.9-rc1 our three NHM EP/EX LKP(linux kernel performance=
) test servers=20
>> 	except SNB/IVB/WSM hung up unexpectly.=20
>>
>=20
> the following draft patch can fix the panic, so it proved we still ne=
ed the percpu cstate.

Alex,

I don't get the connection between the patch and "we still need the
percpu cstate" ?

Could you give more informations about how to reproduce the problem ?

How many processors has your system ?

Could you provide a small test program to trigger the issue ?

When does it appear ? At boot time ? Under load ? At idle time ? etc ..=
=2E

What is the result of your investigation which lead you to propose the
patch below ?

Thanks
  -- Daniel

> but look at the struct acpi_processor_cx {
>         u8 valid;
>         u8 type;
>         u32 address;
>         u8 entry_method;
>         u8 index;
>         u32 latency;
>         u8 bm_sts_skip;
>         char desc[ACPI_CX_DESC_LEN];
> };
>=20
> I have printed all members except the last one. all of them are same =
on all cpu.
> It's interesting.=20
>=20
>=20
> -----------
>=20
> From 5a4fc23fdf5202f8555a25a03afc4d06ac168032 Mon Sep 17 00:00:00 200=
1
> From: Alex Shi <alex.shi@intel.com>
> Date: Tue, 26 Mar 2013 22:57:47 +0800
> Subject: [PATCH] acpi: abc
>=20
> ---
>  drivers/acpi/processor_idle.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> index fc95308..61373ab 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -66,7 +66,7 @@ module_param(latency_factor, uint, 0644);
> =20
>  static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
> =20
> -static struct acpi_processor_cx *acpi_cstate[CPUIDLE_STATE_MAX];
> +static DEFINE_PER_CPU (struct acpi_processor_cx *[CPUIDLE_STATE_MAX]=
, acpi_cstate);
> =20
>  static int disabled_by_idle_boot_param(void)
>  {
> @@ -722,9 +722,10 @@ static int acpi_idle_enter_c1(struct cpuidle_dev=
ice *dev,
>  		struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor *pr;
> -	struct acpi_processor_cx *cx =3D acpi_cstate[index];
> +	struct acpi_processor_cx *cx;
> =20
>  	pr =3D __this_cpu_read(processors);
> + 	cx =3D per_cpu(acpi_cstate[index], pr->id);
> =20
>  	if (unlikely(!pr))
>  		return -EINVAL;
> @@ -745,7 +746,8 @@ static int acpi_idle_enter_c1(struct cpuidle_devi=
ce *dev,
>   */
>  static int acpi_idle_play_dead(struct cpuidle_device *dev, int index=
)
>  {
> -	struct acpi_processor_cx *cx =3D acpi_cstate[index];
> +	struct acpi_processor_cx *cx;
> + 	cx =3D per_cpu(acpi_cstate[index], dev->cpu);
> =20
>  	ACPI_FLUSH_CPU_CACHE();
> =20
> @@ -775,9 +777,10 @@ static int acpi_idle_enter_simple(struct cpuidle=
_device *dev,
>  		struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor *pr;
> -	struct acpi_processor_cx *cx =3D acpi_cstate[index];
> +	struct acpi_processor_cx *cx;
> =20
>  	pr =3D __this_cpu_read(processors);
> + 	cx =3D per_cpu(acpi_cstate[index], pr->id);
> =20
>  	if (unlikely(!pr))
>  		return -EINVAL;
> @@ -833,9 +836,10 @@ static int acpi_idle_enter_bm(struct cpuidle_dev=
ice *dev,
>  		struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor *pr;
> -	struct acpi_processor_cx *cx =3D acpi_cstate[index];
> +	struct acpi_processor_cx *cx;
> =20
>  	pr =3D __this_cpu_read(processors);
> + 	cx =3D per_cpu(acpi_cstate[index], pr->id);
> =20
>  	if (unlikely(!pr))
>  		return -EINVAL;
> @@ -960,7 +964,7 @@ static int acpi_processor_setup_cpuidle_cx(struct=
 acpi_processor *pr,
>  		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>  			continue;
>  #endif
> -		acpi_cstate[count] =3D cx;
> +		per_cpu(acpi_cstate[count], dev->cpu) =3D cx;
> =20
>  		count++;
>  		if (count =3D=3D CPUIDLE_STATE_MAX)
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
