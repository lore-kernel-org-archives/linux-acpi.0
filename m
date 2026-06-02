Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637E392C2A;
	Tue,  2 Jun 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425152; cv=none; b=FHoctIVfMuaAGPr6qqpTRx0NeVwz4dB+d4PiV3pqYXj5/boqiFCZiTcLsriV8FkTCOCBT5e3TbZLxK9FBomSFgsln64EvF3Aw/+fw2AzqHwHRF6zgR3aKr+IluwO4HfliOvcr9o4+EGsZw8heEQIyiFMEfKA6MrWIf1Ius0J8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425152; c=relaxed/simple;
	bh=RQr/qPdKVmxETUyRzvSsqO3FHAy2Ad3LpOHRPMV1zTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTislPRu5Joe4Kyte1o/8UkzB2ZrqRYBu+Z53RwyG8rEK52dHLeOcvX0qUxWvM41O0N//+DOMyyrVQZvGZa2RcubktH+3tPtjsZTZisKVlOxxpQcLImLNtgvtwzqX7xQ6HvfVUWDD+Z7cgNkruaOg1iT1gaHDe9N5/AbXFP2DJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MfK0QrIF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MfK0QrIF"
Received: from [10.6.228.8] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2D5B20B7167;
	Tue,  2 Jun 2026 11:32:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2D5B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780425136;
	bh=Df6G0a7nG1M+1myDP9UGBvJuOH+YEHlr+6ciYyAi6jE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MfK0QrIFHETc4Ndn3nIKQU4r9mWC5uL+0IoGGchwFNPPnuOs0xMjRmrjAYwTKSz2K
	 d7t3uZYabsnMRQ1Jy2Y4sooqRxg2CZwRcRNGNrgu4dTWxckUozsFExnIjEWK7F9XR2
	 zxUXedn1WMDxU7CgF8zm6wxGR8YntJ086xiM5qrM=
Message-ID: <57a1c772-fd6a-4c9c-929f-1e5026a3b7b8@linux.microsoft.com>
Date: Tue, 2 Jun 2026 11:32:23 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: easwar.hariharan@linux.microsoft.com, lenb@kernel.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601235808.1113137-1-jeremy.linton@arm.com>
Content-Language: en-US
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <20260601235808.1113137-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/2026 4:58 PM, Jeremy Linton wrote:
> The definition of reg->access_width changes depending on the
> reg->space_id type.  Type ACPI_ADR_SPACE_PLATFORM_COMM uses
> access_width to indicate the PCC region, which can result in a UBSAN
> if the value is greater than 4.
> 
> For example:
> 
>   UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1090:9
>   shift exponent 32 is too large for 32-bit type 'int'
>   CPU: 61 UID: 0 PID: 1220 Comm: (udev-worker) Not tainted 7.0.10-201.fc44.aarch64 #1 PREEMPT(lazy)
>   Hardware name: To be filled by O.E.M.
>   Call trace:
>    ...(trimming)
>    ubsan_epilogue+0x10/0x48
>    __ubsan_handle_shift_out_of_bounds+0xdc/0x1e0
>    cpc_write+0x4d0/0x670
>    cppc_set_perf+0x18c/0x490
>    cppc_cpufreq_cpu_init+0x1c8/0x380 [cppc_cpufreq]
>    ... (trimming)
> 
> Lets fix this by validating the region type, as well as whether
> access_width has a value. Then since we are returning bit_width
> directly for ACPI_ADR_SPACE_PLATFORM_COMM, drop the code correcting
> the size.
> 
> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 

This change looks good!
Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f370be8715ae..34edec0f2bde 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -185,8 +185,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
>   
>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>   
> -/* Check for valid access_width, otherwise, fallback to using bit_width */
> -#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
> +/*
> + * PCC reuses the access_width field as the subspace id, so only decode access
> + * size for non-PCC registers. Otherwise, use the bit_width.
> + */
> +#define GET_BIT_WIDTH(reg) (((reg)->access_width &&				\
> +			     (reg)->space_id != ACPI_ADR_SPACE_PLATFORM_COMM) ? \
> +			    (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
>   
>   /* Shift and apply the mask for CPC reads/writes */
>   #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
> @@ -1045,7 +1050,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   		 * by the bit width field; the access size is used to indicate
>   		 * the PCC subspace id.
>   		 */
> -		size = reg->bit_width;
>   		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>   	}
>   	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> @@ -1118,7 +1122,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   		 * by the bit width field; the access size is used to indicate
>   		 * the PCC subspace id.
>   		 */
> -		size = reg->bit_width;
>   		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>   	}
>   	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)

