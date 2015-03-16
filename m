From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v10 10/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
Date: Mon, 16 Mar 2015 19:45:25 +0800
Message-ID: <5506C255.3020307@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <1426077587-1561-11-git-send-email-hanjun.guo@linaro.org> <20150313145111.GB5229@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150313145111.GB5229@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B403=E6=9C=8813=E6=97=A5 22:51, Lorenzo Pieralisi wrote:
> On Wed, Mar 11, 2015 at 12:39:36PM +0000, Hanjun Guo wrote:
>
> [...]
>
>> +static void __init psci_0_2_set_functions(void)
>> +{
>> +	pr_info("Using standard PSCI v0.2 function IDs\n");
>> +	psci_function_id[PSCI_FN_CPU_SUSPEND] =3D PSCI_0_2_FN64_CPU_SUSPEN=
D;
>> +	psci_ops.cpu_suspend =3D psci_cpu_suspend;
>> +
>> +	psci_function_id[PSCI_FN_CPU_OFF] =3D PSCI_0_2_FN_CPU_OFF;
>> +	psci_ops.cpu_off =3D psci_cpu_off;
>> +
>> +	psci_function_id[PSCI_FN_CPU_ON] =3D PSCI_0_2_FN64_CPU_ON;
>> +	psci_ops.cpu_on =3D psci_cpu_on;
>> +
>> +	psci_function_id[PSCI_FN_MIGRATE] =3D PSCI_0_2_FN64_MIGRATE;
>> +	psci_ops.migrate =3D psci_migrate;
>> +
>> +	psci_function_id[PSCI_FN_AFFINITY_INFO] =3D PSCI_0_2_FN64_AFFINITY=
_INFO;
>> +	psci_ops.affinity_info =3D psci_affinity_info;
>> +
>> +	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =3D
>> +		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
>> +	psci_ops.migrate_info_type =3D psci_migrate_info_type;
>> +
>> +	arm_pm_restart =3D psci_sys_reset;
>> +
>> +	pm_power_off =3D psci_sys_poweroff;
>> +}
>> +
>>   /*
>>    * PSCI Function IDs for v0.2+ are well defined so use
>>    * standard values.
>> @@ -306,29 +335,7 @@ static int __init psci_0_2_init(struct device_n=
ode *np)
>>   		}
>>   	}
>>
>> -	pr_info("Using standard PSCI v0.2 function IDs\n");
>> -	psci_function_id[PSCI_FN_CPU_SUSPEND] =3D PSCI_0_2_FN64_CPU_SUSPEN=
D;
>> -	psci_ops.cpu_suspend =3D psci_cpu_suspend;
>> -
>> -	psci_function_id[PSCI_FN_CPU_OFF] =3D PSCI_0_2_FN_CPU_OFF;
>> -	psci_ops.cpu_off =3D psci_cpu_off;
>> -
>> -	psci_function_id[PSCI_FN_CPU_ON] =3D PSCI_0_2_FN64_CPU_ON;
>> -	psci_ops.cpu_on =3D psci_cpu_on;
>> -
>> -	psci_function_id[PSCI_FN_MIGRATE] =3D PSCI_0_2_FN64_MIGRATE;
>> -	psci_ops.migrate =3D psci_migrate;
>> -
>> -	psci_function_id[PSCI_FN_AFFINITY_INFO] =3D PSCI_0_2_FN64_AFFINITY=
_INFO;
>> -	psci_ops.affinity_info =3D psci_affinity_info;
>> -
>> -	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =3D
>> -		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
>> -	psci_ops.migrate_info_type =3D psci_migrate_info_type;
>> -
>> -	arm_pm_restart =3D psci_sys_reset;
>> -
>> -	pm_power_off =3D psci_sys_poweroff;
>> +	psci_0_2_set_functions();
>
> You should have factored out the firmware version probing too, that's
> the only way we can detect the PSCI firmware version when booting thr=
ough
> ACPI. You can end up initializing pointers for v0.2+ with a mismatchi=
ng
> version implemented in PSCI firmware, eg 0.1.
>
> We should do that incrementally, I will put together a patch to
> factor out the FW version probing first, you can rebase on top of it.

Incrementally patches on top of this patch set? I think v10 of this
patch set is ready for merge, but I'm open for suggestions if we will
not miss the merge window for Catalin.

>
>>   out_put_node:
>>   	of_node_put(np);
>> @@ -381,7 +388,7 @@ static const struct of_device_id psci_of_match[]=
 __initconst =3D {
>>   	{},
>>   };
>>
>> -int __init psci_init(void)
>> +int __init psci_dt_init(void)
>>   {
>>   	struct device_node *np;
>>   	const struct of_device_id *matched_np;
>> @@ -396,6 +403,29 @@ int __init psci_init(void)
>>   	return init_fn(np);
>>   }
>>
>> +/*
>> + * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
>> + * explicitly clarified in SBBR
>> + */
>> +int __init psci_acpi_init(void)
>> +{
>> +	if (!acpi_psci_present()) {
>> +		pr_info("is not implemented in ACPI.\n");
>> +		return -EOPNOTSUPP;
>> +	}
>
> If PSCI is not present, that's a problem related to SMP init, right ?
> That's where a warning should be printed if any, not here, the SBBR
> mandates PSCI as secondaries bring up method, warn otherwise.

The SBBR is also said that if PSCI is not available, Parking protocol
will be used as secondaries bring up method, so I said that it is ok
to me that we don't print warn message for no PSCI support when parsing
=46ADT.

So maybe we can go back to the previous solution, print some warning
message if no PSCI when parsing FADT?

Thanks
Hanjun
