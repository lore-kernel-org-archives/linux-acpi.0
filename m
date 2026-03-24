Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA30402BAB;
	Tue, 24 Mar 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365042; cv=none; b=h8tqPTPpM6gOK6ZsIsOzmmPzd3+B8IanKVA4NtFX0NInCjlTmUebpn1dnHqJ+N9FMtt1ZNvMJ00W9KtdnjCP8I5UxCNpPQaFZbETb/QuvtQFuKaP2V3qmBR3ehLpicjs/WQTAEu3gwOlJQi+P1hOpz5rZrJLyEgmOcLhjAe/CyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365042; c=relaxed/simple;
	bh=QNmhiboPhTxoKZOkSDx1M9k0BHm6Q/x6fQ5gZzrRjWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuPKtUgpkwHMEKSyW/2qDRv3jKPfyA8KEvHDi6NGkn5WMI63BRlGvfeMJaBFYQ5gH//L/BJ7YkM9X4/RGOu9FiP6AAZjCfc3vcWWATQYnSzwP8Viu8918TDbUYu4WLoVLCE04FdMRF9U9bBdRcD6qDymjYeHpPPdYRK1iY7F16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BbnByRRJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BbnByRRJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1F414BF;
	Tue, 24 Mar 2026 08:10:33 -0700 (PDT)
Received: from [172.27.42.179] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80ECF3F836;
	Tue, 24 Mar 2026 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774365039; bh=QNmhiboPhTxoKZOkSDx1M9k0BHm6Q/x6fQ5gZzrRjWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BbnByRRJqwrzoWg223sexUhotlxbljo3LaHFfNU9g0yLr7zeP+YflI17hy2vWe1C5
	 QWY7UrkgTdaLsU6RK4F39oYKa2sC81wODV+XbVlk0IWylLDb3RyVmS6viXzQ9EBh5E
	 Bo+vPS/McH2TIy6LCnIfERxzhzM/JWJbdTmw1WyA=
Message-ID: <e1d447dd-cbba-4dce-bf4d-c6a7a79f4342@arm.com>
Date: Tue, 24 Mar 2026 10:10:39 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure,
 acpi_pptt_cache_v1_full
To: Ben Horgan <ben.horgan@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324113300.1002569-1-ben.horgan@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260324113300.1002569-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/24/26 6:33 AM, Ben Horgan wrote:
> acpi_pptt_cache_v1_full was initially added as a stop gap until the
> equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
> contained all the fields of the Cache Type Structure. Since, commit :
> 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
> type1"), acpi_pptt_v1 contains all these fields making
> acpi_pptt_cache_v1_full redundant.
> 
> Remove acpi_pptt_cache_v1_full.

Looks good, thanks for taking care of this.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

> 
> No functional change intended.
> 
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/acpi/pptt.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..ea28ba61ddd9 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,25 +21,6 @@
>   #include <linux/cacheinfo.h>
>   #include <acpi/processor.h>
>   
> -/*
> - * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
> - * only contains the cache_id field rather than all the fields of the
> - * Cache Type Structure. Use this alternative structure until it is
> - * resolved in acpica.
> - */
> -struct acpi_pptt_cache_v1_full {
> -	struct acpi_subtable_header header;
> -	u16 reserved;
> -	u32 flags;
> -	u32 next_level_of_cache;
> -	u32 size;
> -	u32 number_of_sets;
> -	u8 associativity;
> -	u8 attributes;
> -	u16 line_size;
> -	u32 cache_id;
> -} __packed;
> -
>   static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>   							u32 pptt_ref)
>   {
> @@ -75,16 +56,16 @@ static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_
>   	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
>   }
>   
> -static struct acpi_pptt_cache_v1_full *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
> +static struct acpi_pptt_cache_v1 *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
>   {
> -	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1_full))
> +	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1))
>   		return NULL;
>   
>   	/* No use for v1 if the only additional field is invalid */
>   	if (!(cache->flags & ACPI_PPTT_CACHE_ID_VALID))
>   		return NULL;
>   
> -	return (struct acpi_pptt_cache_v1_full *)cache;
> +	return (struct acpi_pptt_cache_v1 *)cache;
>   }
>   
>   static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
> @@ -397,7 +378,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   				    struct acpi_pptt_cache *found_cache,
>   				    struct acpi_pptt_processor *cpu_node)
>   {
> -	struct acpi_pptt_cache_v1_full *found_cache_v1;
> +	struct acpi_pptt_cache_v1 *found_cache_v1;
>   
>   	this_leaf->fw_token = cpu_node;
>   	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> @@ -979,7 +960,7 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>   
>   			empty = true;
>   			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
> -				struct acpi_pptt_cache_v1_full *cache_v1;
> +				struct acpi_pptt_cache_v1 *cache_v1;
>   
>   				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
>   							     level, &cpu_node);
> @@ -1043,7 +1024,7 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>   
>   			empty = true;
>   			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
> -				struct acpi_pptt_cache_v1_full *cache_v1;
> +				struct acpi_pptt_cache_v1 *cache_v1;
>   
>   				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
>   							     level, &cpu_node);

