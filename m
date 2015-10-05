From: Wei Huang <wei@redhat.com>
Subject: Re: [PATCH v3 1/7] acpi: Add early device probing infrastructure
Date: Mon, 5 Oct 2015 12:07:42 -0500
Message-ID: <5612AE5E.8080504@redhat.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
 <560EF1BD.1020004@redhat.com> <20151003110402.6aa3022b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbbJERHq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Oct 2015 13:07:46 -0400
In-Reply-To: <20151003110402.6aa3022b@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/03/2015 05:04 AM, Marc Zyngier wrote:
> On Fri, 2 Oct 2015 16:06:05 -0500
> Wei Huang <wei@redhat.com> wrote:
> 
> Hi Wei,
> 
>> Hi Marc,
> 
> [...]
> 
>>> +struct acpi_probe_entry {
>>> +	__u8 id[ACPI_TABLE_ID_LEN];
>>> +	__u8 type;
>>> +	acpi_probe_entry_validate_subtbl subtable_valid;
>>> +	union {
>>> +		acpi_tbl_table_handler probe_table;
>>> +		acpi_tbl_entry_handler probe_subtbl;
>>> +	};
>>
>> Could we avoid using union for probe_table & probe_subtbl? The benefit is that we don't need to do function casting below and compiler can automatically check the correctness.
>>
>>> +	kernel_ulong_t driver_data;
>>> +};
>>> +
>>> +#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn)	\
>>> +	static const struct acpi_probe_entry __acpi_probe_##name	\
>>> +		__used __section(__##table##_acpi_probe_table)		\
>>> +		 = {							\
>>> +			.id = table_id,					\
>>> +			.type = subtable,				\
>>> +			.subtable_valid = valid,			\
>>> +			.probe_table = (acpi_tbl_table_handler)fn,	\
>>> +			.driver_data = data, 				\
>>> +		   }
>>> +
>>
>> Something like: 
>>
>> #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn, subfn)	\
>> 	static const struct acpi_probe_entry __acpi_probe_##name	\
>> 		__used __section(__##table##_acpi_probe_table)		\
>> 		 = {							\
>> 			.id = table_id,					\
>> 			.type = subtable,				\
>> 			.subtable_valid = valid,			\
>> 			.probe_table = fn,				\
>> 			.probe_subtbl = subfn,				\
>> 			.driver_data = data, 				\
>> 		   }
>>
>> Then in patch 3, you can define new entries as:
>>
>> IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
>> 		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
>> 		     NULL, gic_v2_acpi_init);
>> IRQCHIP_ACPI_DECLARE(gic_v2_maybe, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
>> 		     gic_validate_dist, ACPI_MADT_GIC_VERSION_NONE,
>> 		     NULL, gic_v2_acpi_init);
>>
> 
> That's exactly what I was trying to avoid. If you want to do that, do
> it in the IRQCHIP_ACPI_DECLARE macro, as there is strictly no need for
> this this NULL to appear here (MADT always matches by subtable).
> 
> Or even better, have two ACPI_DECLARE* that populate the probe entry in
> a mutually exclusive way (either probe_table is set and both
> valid/subtbl are NULL, or probe_table is NULL and the two other fields
> are set).

Yes, this approach would be sufficient. So users can clearly tell them
apart in terms of usage cases.

Thanks,
-Wei

> 
> Thanks,
> 
> 	M.
> 
