Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD343E869A
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935180; cv=none; b=QuwyZYpNBLsA02Hd1jMfa6ynW6vuEV2hRi3gywsNdiGbfNaa8dOzIpujvGMszxR/qAkCVvynQmfsZbR9jYqr2YSHoBbqSn3gx9RFQOix3eezZstZwSjTOIvVY3EnBRxLoxL1fGE+q99Zo/Vmz6HwCwwIQtP+1r/HuHHrrkvjmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935180; c=relaxed/simple;
	bh=Vf1R+yppKEzBQbnfv9nkce2qdQA1SU29FndglGF4ckQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5YyN7nFLnd+o2obA18HwyjWraBY4QMspvTaxdPSAGAcGZ4c9NK7zmA9tiyd06rOx1kLMEL/i6yg+yEmDJhuvadoq9Ml+GvwtuBI50R9M/ALNabGibwGk8eJZvdLdlr3u8WlzPOT7ww7KFbyf8WHyhB2Alyn3haf81Jz8HzoNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yld7gZy2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmZB4iML; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yld7gZy2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmZB4iML"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEXNkN3648195
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 15:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DvNqP241qE8dFBqHq5L6qVz4
	ghSD7knOgVJYfSQ1B58=; b=Yld7gZy2Vwg7aTwn9M0NrrFrVWWy2GG/gLK7dKB6
	3Xxqr/TDd+CZGMnsnJPz/K3Qa/xinQn4bBim6e/SIY2lxHC59LsOg3Ir/Bzop+FN
	nXALqgBdEtgGwTx4hrDwAIgi3E++GbgchA/Tb9JqtNNJE0lGCxQFp70ZN7dnnhpb
	gA2H4CjR3pEBLlK1y3IKFMLVtPdf3IqARQSJUG53twBLZifGbwlK4ijMhGb9hsol
	oPtOLe3EiflHII4K6ErRMacybeKHiy5UDD1BRgXKQBSo5+2t7g6sdf7GTIUnXg7/
	1fuSHqndq50QugXJHsDKcZ6CqP2RsEPQJBrTEF2i7yH6vg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0v88wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 15:46:17 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ff9edc2158so1516059137.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773935177; x=1774539977; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvNqP241qE8dFBqHq5L6qVz4ghSD7knOgVJYfSQ1B58=;
        b=hmZB4iMLgb1rCmaGPrYpXX3ziT+z664Nsg/VTPmt9oKrDjAD7BP0UuqU5KA3iUK/hz
         fPo5LeNwCASfr4n9/dvOLfISt5Xo0g+XpCjVr8Dd2HtfBmBkaYL+W4Axpf6f/SZ6cD+q
         pnwETaWQciLPYMyAUSF8EeroDHGDB762r+WIvEuKDEo2faUXvYx9kLxG68vre1Wcbxih
         hW5fKg9Gw0vONL8WCNrVhtONZR6HikszTCwyx+5YWK1tLisF6HueEu6ms2UXowVlJHJh
         urwHcdf5qjXU6n/az0vSG69EhoPMojSHPPpRyuCULJltu53eKghK3Iz5cssST9F6m9of
         KaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935177; x=1774539977;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvNqP241qE8dFBqHq5L6qVz4ghSD7knOgVJYfSQ1B58=;
        b=iYJ49hK1ZwzZqYcXoFeBlx0KBiTu477J9EhwWIyFCFbFbU2PksoiIkke1WmJOpU5XU
         w+QUSExOf4fNWYzZLOjUlXqW6C7RU1qaLD8/euCl2D87fZ99cyNGZiYuyMC/dfiCNx2a
         Ligazt4g5JeKyZqKoemQinmLJTMjOhdjaUw+eJN8iRacLehVAiJZ8TjEKrkNff0dLzy2
         PC1j6qaHHm9EaafP4wk2TZy5/cQ1TLZJiUx2+3LGVVkjR5CC/x0SookquPuEArDtS+nj
         8PeuSQuG5QgFJdbsds+yOhFFAnPgwbE/fppMa2DRX+G/67zZ83RKtL9eHxbNCDNbTcR+
         z+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq8+4lYEZRKSJ0fPqW3kr2YAZPjS+64HlJtANVx1cuFPr43wzRleXJaFu94aWVO4W922Yyv9Gufy0I@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZ2RI6l0Rv9xjcsLx6GcSzIwrC4nfF29hwreS76Xy2873m/BD
	EtkALkGXxxKlLhE7/BsWLjEFggXy6z8ueyqWhEZbtUe+qzdO3HbinVWcp9MX7Ye1wOvhl+SyZ12
	cwOzZWhLDBl5fkiDxDBV/fz6RD7Vor2wCqtTnRJrRNJaYbIBurC+Cx5VHC6VbyFDa
X-Gm-Gg: ATEYQzwhyhgnGt6ROFHE1uRv7HLll5E0qMjAMn0B3pTvHph+WHztZ4UNX7kE8u59A1K
	a4qXfUOrPyT4/uOmmSY2NrmF1lk1+o7Yh8hHFztHuYvSwPo96dNaGQVT77XqH1TVdozoLof7/wO
	JaP6VES5oe3QOzqizn9s5kJgkS9IsgccVZqlbo3Pm0T1FWWty8L7iSpYk3LDuEMwUva3rsECW1v
	US2PYjDiVip1TZsYuqcF57vHKIkqJQ7wTMngdu2CIqn47XGKfaGl744Gr8/S9tA54wF+eBO6Cmf
	PyPoGdZOWLLZHN0nNEQH4kfHW8EYTG5nLe+Y9x996CjzLYRt4+CnFRiBW2tGSQZpxBoqa9Lc9SI
	MZ2diRH8l6NrYK+qPin7v1AX/RInaPvV/TSDuxQ==
X-Received: by 2002:a05:6102:d89:b0:5ff:9d74:967b with SMTP id ada2fe7eead31-6027d330b13mr3043043137.20.1773935177023;
        Thu, 19 Mar 2026 08:46:17 -0700 (PDT)
X-Received: by 2002:a05:6102:d89:b0:5ff:9d74:967b with SMTP id ada2fe7eead31-6027d330b13mr3042963137.20.1773935176396;
        Thu, 19 Mar 2026 08:46:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm129162465e9.9.2026.03.19.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:46:15 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave
 Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter
 Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Len Brown <lenb@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Kees Cook
 <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
        Sean
 Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Tom
 Lendacky <thomas.lendacky@amd.com>,
        Thomas Huth <thuth@redhat.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Kevin Loughlin
 <kevinloughlin@google.com>,
        Zheyun Shen <szy0127@sjtu.edu.cn>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>,
        Xin Li <xin@zytor.com>, "Ahmed S .
 Darwish" <darwi@linutronix.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy
 <robin.murphy@arm.com>,
        James Clark <james.clark@linaro.org>,
        Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
        Wei Huang
 <wei.huang2@amd.com>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        <punit.agrawal@oss.qualcomm.com>, <guohanjun@huawei.com>,
        <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
        <chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
        <wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
        <heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
        <wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
        <liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
        <linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v9 1/7] arm64/acpi: Add acpi_get_cpu_uid() and switch
 arm_cspmu to use it
In-Reply-To: <20260319065735.45954-2-fengchengwen@huawei.com> (Chengwen Feng's
	message of "Thu, 19 Mar 2026 14:57:29 +0800")
References: <20260319065735.45954-1-fengchengwen@huawei.com>
	<20260319065735.45954-2-fengchengwen@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Mar 2026 15:46:14 +0000
Message-ID: <87341vq0u1.fsf@stealth>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lXtARX5BtsGL49xRVWO1PhkAo1koK8aS
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bc1a49 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=Gl9ZV0r3yxOOH3mhj0oA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: lXtARX5BtsGL49xRVWO1PhkAo1koK8aS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNCBTYWx0ZWRfX/szPKKvkSF7z
 W+oiGSkg4avQfTXzg+e0jc1oW3qebLmlUQDlPxugjNru16XW2sKvTzarz6k1cZclsIWC3gExc4T
 QZv3JWn6biBsty1QpbmwCI1twnQT0G0fdNSGxEp8blFHiYJ7+xheIawVpZxcyCTf1uRKF1H1j3b
 TgBI6MBCATiEwzujF/6T6bvt50MeB3f76rj5IFUliEb4uJQbdJToup1v3z4gUM0YjhWMOTn/I70
 q7E/z3WOtdxSL/7CyLvQTzb7JwZXIYKsGmNER9nDAKnY9U3ISMAsUvHv2lMPQmEOpcdms4s41EQ
 WRorKLewSjbrWpjOOuC4vfS4ZqceSo9D+ZkCn2gpta8rzgyNCsi3BOytnCDA1TEj99yjwR0G1Cw
 2xdotWdvhCBJJNwtv2BcJplDYA3T4718pbGYX3EHC5Y6SRAo2YRWnyFjVqXZHPXsD1udXr1Qobn
 145A3dpX2YEfAewEQ0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190124

Chengwen Feng <fengchengwen@huawei.com> writes:

> Add arch-specific acpi_get_cpu_uid() for arm64, and update dependent
> code:
> - Declare acpi_get_cpu_uid() in arch/arm64/include/asm/acpi.h
> - Implement acpi_get_cpu_uid() with input parameter validation
> - Replace get_acpi_id_for_cpu() with acpi_get_cpu_uid() in
>   drivers/perf/arm_cspmu/arm_cspmu.c
> - Reimplement get_cpu_for_acpi_id() based on acpi_get_cpu_uid() (to
>   align with new interface) and move its implementation next to
>   acpi_get_cpu_uid()

There is no benefit in describing the code changes like this in the
commit log. It makes it hard to follow the intent of the patch.

> This is the first step towards unifying ACPI CPU UID retrieval interface
> across architectures, while adding input validation for robustness.

I would simplify the commit log to something along the lines of -

    As a step towards unifying the interface for retrieving ACPI CPU uid
    across architectures, introduce a new function
    acpi_get_cpu_uid(). While at it, also add input validation to make
    the code more robust.

Just my 2c.

The code changes looks fine.

> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  arch/arm64/include/asm/acpi.h      | 14 ++------------
>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++++++++++++++
>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++++--
>  3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index c07a58b96329..2219a3301e72 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -118,18 +118,8 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>  {
>  	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>  }
> -
> -static inline int get_cpu_for_acpi_id(u32 uid)
> -{
> -	int cpu;
> -
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (acpi_cpu_get_madt_gicc(cpu) &&
> -		    uid == get_acpi_id_for_cpu(cpu))
> -			return cpu;
> -
> -	return -EINVAL;
> -}
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
> +int get_cpu_for_acpi_id(u32 uid);
>  
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  void __init acpi_init_cpus(void);
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index af90128cfed5..24b9d934be54 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -458,3 +458,33 @@ int acpi_unmap_cpu(int cpu)
>  }
>  EXPORT_SYMBOL(acpi_unmap_cpu);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_generic_interrupt *gicc;
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (!gicc)
> +		return -ENODEV;
> +
> +	*uid = gicc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> +
> +int get_cpu_for_acpi_id(u32 uid)
> +{
> +	u32 cpu_uid;
> +	int ret;
> +
> +	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
> +		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +		if (ret == 0 && uid == cpu_uid)
> +			return cpu;
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 34430b68f602..ed72c3d1f796 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
>  {
>  	struct acpi_apmt_node *apmt_node;
>  	int affinity_flag;
> +	u32 cpu_uid;
>  	int cpu;
> +	int ret;
>  
>  	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
>  	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>  
>  	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
>  		for_each_possible_cpu(cpu) {
> -			if (apmt_node->proc_affinity ==
> -			    get_acpi_id_for_cpu(cpu)) {
> +			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
>  				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
>  				break;
>  			}

I think cspmu changes go via a separate pull request. You might have to
split this change into a separate commit.
