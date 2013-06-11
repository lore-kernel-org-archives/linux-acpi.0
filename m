From: Larry Baker <baker@usgs.gov>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Tue, 11 Jun 2013 14:34:53 -0700
Message-ID: <6E6994CE-F8F3-4929-82C5-F1A582B631C5@usgs.gov>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from SMTP1.doi.gov ([137.227.82.11]:34052 "EHLO smtp1.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab3FKVkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2013 17:40:12 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so5930533pac.1        for
 <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2013 14:34:56 -0700 (PDT)
In-Reply-To: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rob E Russell <robr@us.ibm.com>

Sorry, I snipped the C states table from my modified intel_idle.c, not =
the original.  I should have shown

> static const struct x86_cpu_id intel_idle_ids[] =3D {=20
> <snip>
> 	ICPU(0x2c, idle_cpu_nehalem),
> <snip>
> 	{}
> };
> MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov



On 11 Jun 2013, at 2:30 PM, Larry Baker wrote:

> I have an IBM System x3650 M3 with an Intel Xeon L5630 processor.  My=
 IBM support team alerted me to an issue with C6 states for those proce=
ssors when running Linux and the intel_idle kernel module is used.  The=
 IBM solutions page, http://www-947.ibm.com/support/entry/portal/docdis=
play?lndocid=3Dmigr-5091901, recommends disabling intel_idle.  I propos=
e intel_idle disable C6 for the affected processors.
>=20
> Description:
>=20
> Intel Xeon 5600 and Core i7-900 processors (Family 6 Model 44) have a=
 flaw when the C6 state is used.  See Intel=AE Xeon=AE Processor 5600 S=
eries Specification Update May 2012 (http://www.intel.eu/content/dam/ww=
w/public/us/en/documents/specification-updates/xeon-5600-specification-=
update.pdf) and Intel=AE CoreTM i7-900 Desktop Processor Extreme Editio=
n Series and Intel=AE CoreTM i7-900 Desktop Processor Series on 32-nm P=
rocess Specification Update June 2013 (http://www.intel.com/content/dam=
/www/public/us/en/documents/specification-updates/core-i7-900-ee-and-de=
sktop-processor-series-32nm-spec-update.pdf):
>=20
>> Package C6 Transitions May Cause Memory Bit Errors to be Observed
>>=20
>> Problem:
>> During Package C6 transitions, internal signaling noise may cause th=
e DDRx_CKE signal to become asserted during self-refresh. These asserti=
ons may result in memory bit errors upon exiting from the package C6 st=
ate. Due to this erratum the DDRx_CKE signals can be driven during time=
s in which the DDR3 JEDEC specification requires that they are idle.
>>=20
>> Implication:
>> DDRx_CKE signals can be driven during package C6 memory self-refresh=
 creating an invalid memory DRAM state.  A system hang, memory ECC erro=
rs or unpredictable system behavior may occur when exiting the package =
C6 state.
>>=20
>> Workaround:=20
>> It is possible for the BIOS to contain a workaround for this erratum=
=2E
>>=20
>> Status:
>> For the steppings affected, see the Summary Table of Changes.
>=20
> The intel_idle kernel module uses the standard Nehalem C states table=
 for these processors (boot_cpu_data.x86_model=3D=3D0x2c):
>=20
>> static const struct x86_cpu_id intel_idle_ids[] =3D {
>> <snip>
>> 	ICPU(0x2c, idle_cpu_xeon5600),
>> <snip>
>> 	{}
>> };
>> MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
>=20
> I propose two alternatives for intel_idle.c to avoid the processor fl=
aw.  (I didn't try to compile them -- I only modified intel_idle.c.)  T=
he first limits max_cstates=3D3, and prints in a console message if the=
 limit was forced.  The second creates a Xeon 5600-specific C states ta=
ble which leaves off the C6 state.  No message is printed in that case.=
  I like the idea of a message, and I like the idea of a proper C state=
s table.  I did not look to see if acpi_idle can also benefit from a si=
milar modification.
>=20
> Thank you,
>=20
> Larry Baker
> US Geological Survey
> 650-329-5608
> baker@usgs.gov
>=20
> =3D=3D=3D=3D=3D Version 1 Patch - Limit max_cstate=3D3 for Family 6 M=
odel 44 Processors =3D=3D=3D=3D=3D
>=20
> --- intel_idle.c.orig	2013-06-11 11:41:49.000000000 -0700
> +++ intel_idle-fix-v1.c	2013-06-11 13:47:15.000000000 -0700
> @@ -534,2 +534,13 @@
>=20
> +/*
> + * Disable C6-state for Xeon 5600 and Core i7-900.  Refer to Xeon 56=
00 errata
> + * BD104 and Core i7-900 errata BC82: Package C6 Transitions May Res=
ult in
> + * Single and Multi-Bit Memory Errors.
> + */
> +	if (boot_cpu_data.x86_model =3D=3D 0x2c &&
> +	    max_cstate > 3) {
> +		pr_debug(PREFIX "limiting model 0x2c to max_cstate=3D3\n");
> +		max_cstate =3D 3;
> +	}
> +
> 	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
>=20
> =3D=3D=3D=3D=3D Version 2 Patch - Disable C6 for Family 6 Model 44 Pr=
ocessors =3D=3D=3D=3D=3D
>=20
> --- intel_idle.c.orig	2013-06-11 11:41:49.000000000 -0700
> +++ intel_idle-fix-v2.c	2013-06-11 13:51:32.000000000 -0700
> @@ -158,2 +158,33 @@
>=20
> +/*
> + * Disable C6-state for Xeon 5600 and Core i7-900.  Refer to Xeon 56=
00 errata
> + * BD104 and Core i7-900 errata BC82: Package C6 Transitions May Res=
ult in
> + * Single and Multi-Bit Memory Errors.
> + */
> +static struct cpuidle_state xeon5600_cstates[CPUIDLE_STATE_MAX] =3D =
{
> +	{
> +		.name =3D "C1-NHM",
> +		.desc =3D "MWAIT 0x00",
> +		.flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency =3D 3,
> +		.target_residency =3D 6,
> +		.enter =3D &intel_idle },
> +	{
> +		.name =3D "C1E-NHM",
> +		.desc =3D "MWAIT 0x01",
> +		.flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency =3D 10,
> +		.target_residency =3D 20,
> +		.enter =3D &intel_idle },
> +	{
> +		.name =3D "C3-NHM",
> +		.desc =3D "MWAIT 0x10",
> +		.flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLA=
G_TLB_FLUSHED,
> +		.exit_latency =3D 20,
> +		.target_residency =3D 80,
> +		.enter =3D &intel_idle },
> +	{
> +		.enter =3D NULL }
> +};
> +
> static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] =3D {
> @@ -440,2 +471,8 @@
>=20
> +static const struct idle_cpu idle_cpu_xeon5600 =3D {
> +	.state_table =3D xeon5600_cstates,
> +	.auto_demotion_disable_flags =3D NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_D=
EMOTE,
> +	.disable_promotion_to_c1e =3D true,
> +};
> +
> static const struct idle_cpu idle_cpu_atom =3D {
> @@ -472,3 +509,3 @@
> 	ICPU(0x25, idle_cpu_nehalem),
> -	ICPU(0x2c, idle_cpu_nehalem),
> +	ICPU(0x2c, idle_cpu_xeon5600),
> 	ICPU(0x2e, idle_cpu_nehalem),
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
