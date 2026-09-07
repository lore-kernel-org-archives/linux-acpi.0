Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCD434E42;
	Mon,  7 Sep 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780581; cv=none; b=d1QqMnZFPC89N/qAG+cljP/urD6n0pNZWG2zBDFgNPFu4CMq6lb0wtmfTQMjaMsQjK/dUDLWDnGQ3cv1htAMwN34/wJv/8+i5hmGHWE9KGfQPMYIPwXic7Pb2YEZy0ohVlwelCeEKvsbN0ezVja+UW9G9VYmbAaLeB+bUXM6KEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780581; c=relaxed/simple;
	bh=+iVzbTX39foUN0TNwoi39BROt8LoXx3mWNtDG7eN4cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z3+3a3mRD9NyQ7xwycP3gvsk3HU2hVowYufuicYfdOE9IfS1468GXAe2hU+vT5KzUnqoPfMZsRlrC2z6tcOaLIBp78KI6qGWNcxSa9ob2ykXbFLfliMusKXABjCsNToAHuW9iAtqRk1NkJWrZHN/E+CJxalJ0089ORskc9rNJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hdl1p3DgTz1cyPY;
	Mon,  7 Sep 2026 19:18:38 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id EB0C84057A;
	Mon,  7 Sep 2026 19:29:30 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 7 Sep
 2026 19:29:30 +0800
Message-ID: <d48e5c92-f666-44e0-8375-9772d95065b5@hisilicon.com>
Date: Mon, 7 Sep 2026 19:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Implement cpc_read_ffh_fb_ctrs()
To: Yufan Dou <douyufan@picoheart.com>, Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yuchao.46@picoheart.com>, <yang.yicong@picoheart.com>,
	<geshijian@picoheart.com>
References: <20260902083450.2348-1-douyufan@picoheart.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260902083450.2348-1-douyufan@picoheart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/2/2026 4:34 PM, Yufan Dou wrote:
> On RISC-V, each cpc_read_ffh() for a CSR-type FFH register sends a
> separate IPI to the target hart via smp_call_function_single().
> cppc_get_perf_ctrs() therefore samples the delivered and reference
> counters in two separate IPIs, at two different instants. The skew
> between the two sampling points distorts the delivered/reference
> ratio and thus the frequency reported by cpufreq.
> 
> Implement the cpc_read_ffh_fb_ctrs() hook to read both CSR counters
> back-to-back in a single IPI, which narrows the sampling window to a
> few instructions and halves the number of cross-CPU calls. This
> improves the accuracy of the reported frequency in the same way as
> the arm64 implementation of the hook, which reads both AMU counters
> in a single counters_read_on_cpu() call.
> 
> SBI-type FFH registers still fall back to individual reads, since
> pairing them would not reduce the number of SBI calls on the target
> hart.
> 
> Testing was performed while CPU1 was kept busy with:
> 
>   # stress-ng --cpu 1 --taskset 1
> 
> On a CPU with cpuinfo_max_freq of 3000000 kHz:
> 
> Before:
> 
>   Maximum observed cpuinfo_cur_freq: 3201369 kHz
>   Maximum observed error:            +201369 kHz (+6.71%)
> 
> After:
> 
>   Maximum observed cpuinfo_cur_freq: 3009646 kHz
>   Maximum observed error:              +9646 kHz (+0.32%)
> 
> The maximum observed error is reduced by 95.2%.
Glad to see that works for RISC-V as well.
> 
> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
> ---
>  drivers/acpi/riscv/cppc.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 42c1a9052470..2ca98fa69e9a 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -85,6 +85,20 @@ static void cppc_ffh_csr_write(void *write_data)
>  	data->ret.error = -EINVAL;
>  }
>  
> +struct sbi_cppc_fb_ctrs_data {
> +	struct sbi_cppc_data first;
> +	struct sbi_cppc_data second;
> +};
> +
> +static void cppc_ffh_csr_read_fb_ctrs(void *read_data)
> +{
> +	struct sbi_cppc_fb_ctrs_data *data = read_data;
> +
> +	cppc_ffh_csr_read(&data->first);
> +	if (!data->first.ret.error)
> +		cppc_ffh_csr_read(&data->second);
> +}
> +
>  /*
>   * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
>   * below.
> @@ -125,6 +139,39 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>  	return -EINVAL;
>  }
>  
> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +			 struct cpc_reg *reg2, u64 *val2)
> +{
> +	struct sbi_cppc_fb_ctrs_data data;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(irqs_disabled()))
> +		return -EPERM;
AFAICS, this may cause CPPC FIE to constantly fail to read counters because
FIE runs in hardirq context.

Any test on CPPC FIE?
> +
> +	/* Only CSR counters can be paired within a single IPI. */
> +	if (FFH_CPPC_TYPE(reg1->address) != FFH_CPPC_CSR ||
> +	    FFH_CPPC_TYPE(reg2->address) != FFH_CPPC_CSR)
> +		return -EOPNOTSUPP;
> +
> +	data.first.reg = FFH_CPPC_CSR_NUM(reg1->address);
> +	data.second.reg = FFH_CPPC_CSR_NUM(reg2->address);
> +
> +	ret = smp_call_function_single(cpu, cppc_ffh_csr_read_fb_ctrs,
> +				       &data, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (data.first.ret.error)
> +		return data.first.ret.error;
> +	if (data.second.ret.error)
> +		return data.second.ret.error;
> +
> +	*val1 = data.first.ret.value;
> +	*val2 = data.second.ret.value;
> +
> +	return 0;
> +}
> +
>  int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>  {
>  	struct sbi_cppc_data data;
> 
> base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
