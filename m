Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785A2FFDF8;
	Tue, 12 May 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602445; cv=none; b=OwK8OkL+EwbIb+yDNegEksTbcLpwZ/PmB0NLG/LtrSyMu1F5F5wasq+yYUZwZhpxzMRiNv1T39d1wevVmjTGXpt5W5sJpJ/DSpo3A5q1IFBOAT1U1vzxxE4AbsE7wymFP2R8EtgRuwgcBW3VxYYAz1HBujUdiU/2P2EHSz3hc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602445; c=relaxed/simple;
	bh=GHZWor7rdy45tprIWlWstOcDkMP3M+aEv6hEteW8EN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMAzgSuRHcJ1pgvwK0ve9GCTMmTpEfkw0AmB8kr1bYk+RArExJxlCRwAtOD4gSCQg4xC107+OvY+WSaIe7Go7J+XXeOGn5CP48iwCR+Zuj3eRBL2y8TXtJh4FMMoHDjnphCMbBbrdE144pUBgP+SBTbVFIyBVquNMWSU7MzOcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TY7M8Nt4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TY7M8Nt4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E471650;
	Tue, 12 May 2026 09:13:57 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60113F836;
	Tue, 12 May 2026 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778602442; bh=GHZWor7rdy45tprIWlWstOcDkMP3M+aEv6hEteW8EN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TY7M8Nt4UDSmdhmrU1PKycF2lKfojYvEgKZZTllA6T6EIcJJAOG5s0dTV1+BBqFmc
	 DwrW/PEUVkuEBxsmvpIePwV8KDGXTgriDtnkCq1esQvuHgd2gSCob83CbpWw6kv0ex
	 vKB4hBVG18OeOxX6YGT7kP5rPYTjgAVZSs+/abZA=
Message-ID: <15389814-e6d3-43bf-967b-38d0fc8f8c52@arm.com>
Date: Tue, 12 May 2026 18:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm_mpam: Parse the rest of the ACPI table
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-2-andre.przywara@arm.com>
 <f12b8d73-7c8e-43e7-b9ce-d80a7c3f10c8@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <f12b8d73-7c8e-43e7-b9ce-d80a7c3f10c8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 5/8/26 12:21, Ben Horgan wrote:
> Hi Andre,
> 
> On 4/29/26 15:13, Andre Przywara wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> The MPAM ACPI table lists the MPAM MSCs and indicates which resources
>> in the system they control. Not everything this table can describe is
>> supported by resctrl, e.g. memory-side-caches.
>>
>> Add the additional table parsing to avoid reporting these as 'unknown'
>> to the MPAM driver. This allows class+component hierarchys to be built.
>>
>> Until resctrl has support for any of these resources, users would be
>> in-kernel managers of a resource/PARTID or perf to query bandwidth
>> counters on a resource resctrl is unaware of.
> 
> Does this patch give us anything needed for MPAM-Fb? It seems to just add
> parsing for things we don't support in the MPAM driver.

I think you are right, this just parses more resource types from the MSC 
table, but is otherwise unrelated to MPAM-Fb.
I probably just cargo-culted this patch all the time ;-)
Will drop it now.

Cheers,
Andre.

> 
> Thanks,
> 
> Ben
> 
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/acpi/arm64/mpam.c | 91 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 88 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> index 84963a20c3e7..99c2bdbb3314 100644
>> --- a/drivers/acpi/arm64/mpam.c
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -95,17 +95,51 @@ static void acpi_mpam_parse_irqs(struct platform_device *pdev,
>>   		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
>>   }
>>   
>> -static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +#define UUID_MPAM_INTERCONNECT_TABLE		"fe2bd645-033b-49e6-9479-2e0b8b21d1cd"
>> +
>> +struct acpi_mpam_interconnect_descriptor_table {
>> +	u8	type_uuid[16];
>> +	u32	num_descriptors;
>> +};
>> +
>> +struct acpi_mpam_interconnect_descriptor {
>> +	u32	source_id;
>> +	u32	destination_id;
>> +	u8	link_type;
>> +	u8	reserved[3];
>> +};
>> +
>> +static int acpi_mpam_parse_resource(struct acpi_mpam_msc_node *tbl_msc,
>> +				    struct mpam_msc *msc,
>>   				    struct acpi_mpam_resource_node *res)
>>   {
>> +	struct acpi_mpam_interconnect_descriptor_table *tbl_int_tbl;
>> +	struct acpi_mpam_interconnect_descriptor *tbl_int;
>> +	guid_t int_tbl_uuid, spec_uuid;
>>   	int level, nid;
>>   	u32 cache_id;
>> +	off_t offset;
>>   
>> +	/*
>> +	 * Class IDs are somewhat arbitrary, but need to be co-ordinated.
>> +	 * 0-N are caches,
>> +	 * 64, 65: Interconnect, but ideally these would appear between the
>> +	 *     classes the controls are adjacent to.
>> +	 * 128: SMMU,
>> +	 * 192-192+level: Memory Side Caches, nothing checks that N is a
>> +	 *                small number.
>> +	 * 255: Memory Controllers
>> +	 *
>> +	 * ACPI devices would need a class id allocated based on the _HID.
>> +	 *
>> +	 * Classes that the mpam driver can't currently plumb into resctrl
>> +	 * are registered as UNKNOWN.
>> +	 */
>>   	switch (res->locator_type) {
>>   	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>>   		cache_id = res->locator.cache_locator.cache_reference;
>>   		level = find_acpi_cache_level_from_id(cache_id);
>> -		if (level <= 0) {
>> +		if (level <= 0 || level >= 64) {
>>   			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
>>   			return -EINVAL;
>>   		}
>> @@ -120,6 +154,57 @@ static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>>   		}
>>   		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>>   				       MPAM_CLASS_ID_DEFAULT, nid);
>> +	case ACPI_MPAM_LOCATION_TYPE_SMMU:
>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
>> +				       128, res->locator.smmu_locator.smmu_interface);
>> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY_CACHE:
>> +		cache_id = res->locator.mem_cache_locator.reference;
>> +		level = res->locator.mem_cache_locator.level;
>> +		if (192 + level >= 255) {
>> +			pr_err_once("Bad level for memory side cache with reference %u\n",
>> +				    cache_id);
>> +			return -EINVAL;
>> +		}
>> +
>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>> +				       192 + level, cache_id);
>> +
>> +	case ACPI_MPAM_LOCATION_TYPE_INTERCONNECT:
>> +		/* Find the descriptor table, and check it lands in the parent msc */
>> +		offset = res->locator.interconnect_ifc_locator.inter_connect_desc_tbl_off;
>> +		if (offset >= tbl_msc->length) {
>> +			pr_err_once("Bad offset for interconnect descriptor on msc %u\n",
>> +				    tbl_msc->identifier);
>> +			return -EINVAL;
>> +		}
>> +		tbl_int_tbl = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor_table,
>> +					   tbl_msc, offset);
>> +		guid_parse(UUID_MPAM_INTERCONNECT_TABLE, &spec_uuid);
>> +		import_guid(&int_tbl_uuid, tbl_int_tbl->type_uuid);
>> +		if (guid_equal(&spec_uuid, &int_tbl_uuid)) {
>> +			pr_err_once("Bad UUID for interconnect descriptor on msc %u\n",
>> +				    tbl_msc->identifier);
>> +			return -EINVAL;
>> +		}
>> +
>> +		offset += sizeof(*tbl_int_tbl);
>> +		offset += tbl_int_tbl->num_descriptors * sizeof(*tbl_int);
>> +		if (offset >= tbl_msc->length) {
>> +			pr_err_once("Bad num_descriptors for interconnect descriptor on msc %u\n",
>> +				    tbl_msc->identifier);
>> +			return -EINVAL;
>> +		}
>> +
>> +		tbl_int = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor,
>> +				       tbl_int_tbl, sizeof(*tbl_int_tbl));
>> +		cache_id = tbl_int->source_id;
>> +
>> +		/* Unknown link type? */
>> +		if (tbl_int->link_type != 0 && tbl_int->link_type == 1)
>> +			return 0;
>> +
>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
>> +				       64 + tbl_int->link_type, cache_id);
>>   	default:
>>   		/* These get discovered later and are treated as unknown */
>>   		return 0;
>> @@ -150,7 +235,7 @@ int acpi_mpam_parse_resources(struct mpam_msc *msc,
>>   			return -EINVAL;
>>   		}
>>   
>> -		err = acpi_mpam_parse_resource(msc, resource);
>> +		err = acpi_mpam_parse_resource(tbl_msc, msc, resource);
>>   		if (err)
>>   			return err;
>>   
> 

