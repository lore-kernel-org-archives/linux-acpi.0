Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE621A6823
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787057; cv=none; b=TRHas372L9P+/zJTQ1vLx85LPU3qcf4rKhMNlXF0qe3wKx7FnA1iRrh9OJSof0XSU5js7D/RmklL7gohoMwQBkgVsCcRhAKLApSSeX+uDqDR5BgYIAlS1QN7ziR/LPnldqaLO21H05Plh7fW9iauQt0MwLE/oqTxJaUhr5vO4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787057; c=relaxed/simple;
	bh=yQD+qTOHxM6Tkpx31cCx9rs4vJQbozGXPz411G/NNMg=;
	h=Cc:Subject:Date:References:To:From:Message-Id:Content-Type:
	 Mime-Version:In-Reply-To; b=T2LQ4UCoh5/7x+4zDgBYXbo3cPmYKrvXsCYBHGOcaCghq0TQikdwNalY5rQBLlnjMy58cXMhM/cE0mnbhTjZ3RWbIb1zmnjZjorUKJ+HU56Bxry+osxcM3LlsuYAfMrClFPpsBdRUlbFtt9WAqWNUQCtN4dk8Q7qNvj9AkrZB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=b7BCS4CY; arc=none smtp.client-ip=209.127.231.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="b7BCS4CY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788787039; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=paxgRnqRRQ5ClGyRNJIpWS/UEGCwA35sFQ+eOrhG0G4=;
 b=b7BCS4CYV32u3+7M3iBxs+XuWxwRyvmuysrZRarM5M+zawUTJLgRPPN64XJTst68bb2DBc
 EvMSaAVal40YwUUorvgl+lK5eF3jp8cV0YEEZjaJe3Fcid7xhJqaTXimnSrncUFx7Ein6v
 snNWyMGxzyA4MoWu0WtikyG29EjL9e0Eu/3n25qdoZiIzvsBpUSQas6yCQZLveOUyMuGX7
 nHDH7Kq86ZFV4g0fY851VbHaXxYCezQ3aRq2AAP/FSGlp/w/8kDXHrQ+XHyHznvy0w56A8
 9wcg9RhEZ6/qQNgk2GyKk1K+ECOJRcAlpFdZGVsAqjgcs8YHzeGd3k0Mcxq81w==
Cc: "Yufan Dou" <douyufan@picoheart.com>, 
	"Sunil V L" <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, 
	"Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <yang.yicong@picoheart.com>, 
	<yuchao.46@picoheart.com>, <geshijian@picoheart.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Implement cpc_read_ffh_fb_ctrs()
Date: Mon, 7 Sep 2026 21:17:14 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
Received: from [172.16.155.39] ([120.234.49.250]) by smtp.feishu.cn with ESMTPS; Mon, 07 Sep 2026 21:17:16 +0800
References: <20260902083450.2348-1-douyufan@picoheart.com> <d48e5c92-f666-44e0-8375-9772d95065b5@hisilicon.com>
Content-Language: en-US
To: "Jie Zhan" <zhanjie9@hisilicon.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <37731989-e1f1-4dc9-944d-2544ce8e9302@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <d48e5c92-f666-44e0-8375-9772d95065b5@hisilicon.com>
X-Lms-Return-Path: <lba+26a9eb95d+fe384e+vger.kernel.org+yang.yicong@picoheart.com>

On 9/7/26 7:29 PM, Jie Zhan wrote:
> 
> 
> On 9/2/2026 4:34 PM, Yufan Dou wrote:
>> On RISC-V, each cpc_read_ffh() for a CSR-type FFH register sends a
>> separate IPI to the target hart via smp_call_function_single().
>> cppc_get_perf_ctrs() therefore samples the delivered and reference
>> counters in two separate IPIs, at two different instants. The skew
>> between the two sampling points distorts the delivered/reference
>> ratio and thus the frequency reported by cpufreq.
>>
>> Implement the cpc_read_ffh_fb_ctrs() hook to read both CSR counters
>> back-to-back in a single IPI, which narrows the sampling window to a
>> few instructions and halves the number of cross-CPU calls. This
>> improves the accuracy of the reported frequency in the same way as
>> the arm64 implementation of the hook, which reads both AMU counters
>> in a single counters_read_on_cpu() call.
>>
>> SBI-type FFH registers still fall back to individual reads, since
>> pairing them would not reduce the number of SBI calls on the target
>> hart.
>>
>> Testing was performed while CPU1 was kept busy with:
>>
>>   # stress-ng --cpu 1 --taskset 1
>>
>> On a CPU with cpuinfo_max_freq of 3000000 kHz:
>>
>> Before:
>>
>>   Maximum observed cpuinfo_cur_freq: 3201369 kHz
>>   Maximum observed error:            +201369 kHz (+6.71%)
>>
>> After:
>>
>>   Maximum observed cpuinfo_cur_freq: 3009646 kHz
>>   Maximum observed error:              +9646 kHz (+0.32%)
>>
>> The maximum observed error is reduced by 95.2%.
> Glad to see that works for RISC-V as well.
>>
>> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
>> ---
>>  drivers/acpi/riscv/cppc.c | 47 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
>> index 42c1a9052470..2ca98fa69e9a 100644
>> --- a/drivers/acpi/riscv/cppc.c
>> +++ b/drivers/acpi/riscv/cppc.c
>> @@ -85,6 +85,20 @@ static void cppc_ffh_csr_write(void *write_data)
>>  	data->ret.error = -EINVAL;
>>  }
>>  
>> +struct sbi_cppc_fb_ctrs_data {
>> +	struct sbi_cppc_data first;
>> +	struct sbi_cppc_data second;
>> +};
>> +
>> +static void cppc_ffh_csr_read_fb_ctrs(void *read_data)
>> +{
>> +	struct sbi_cppc_fb_ctrs_data *data = read_data;
>> +
>> +	cppc_ffh_csr_read(&data->first);
>> +	if (!data->first.ret.error)
>> +		cppc_ffh_csr_read(&data->second);
>> +}
>> +
>>  /*
>>   * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
>>   * below.
>> @@ -125,6 +139,39 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>>  	return -EINVAL;
>>  }
>>  
>> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
>> +			 struct cpc_reg *reg2, u64 *val2)
>> +{
>> +	struct sbi_cppc_fb_ctrs_data data;
>> +	int ret;
>> +
>> +	if (WARN_ON_ONCE(irqs_disabled()))
>> +		return -EPERM;
> AFAICS, this may cause CPPC FIE to constantly fail to read counters because
> FIE runs in hardirq context.

I suppose it's mainly due to the smp_call_function_single() cannot work
with irqs_disabled().

seems we need to do the similar handling like arm64's
counters_read_on_cpu() - read the counters locally when irqs_disabled()
if local cpu is the target cpu.

so is cpc_read_ffh() of riscv. but I suppose this should be a fix of below
commit, as it were in the kthread for FIE...
997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")

> 
> Any test on CPPC FIE?
>> +
>> +	/* Only CSR counters can be paired within a single IPI. */
>> +	if (FFH_CPPC_TYPE(reg1->address) != FFH_CPPC_CSR ||
>> +	    FFH_CPPC_TYPE(reg2->address) != FFH_CPPC_CSR)
>> +		return -EOPNOTSUPP;
>> +
>> +	data.first.reg = FFH_CPPC_CSR_NUM(reg1->address);
>> +	data.second.reg = FFH_CPPC_CSR_NUM(reg2->address);
>> +
>> +	ret = smp_call_function_single(cpu, cppc_ffh_csr_read_fb_ctrs,
>> +				       &data, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (data.first.ret.error)
>> +		return data.first.ret.error;
>> +	if (data.second.ret.error)
>> +		return data.second.ret.error;
>> +
>> +	*val1 = data.first.ret.value;
>> +	*val2 = data.second.ret.value;
>> +
>> +	return 0;
>> +}
>> +
>>  int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>>  {
>>  	struct sbi_cppc_data data;
>>
>> base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
