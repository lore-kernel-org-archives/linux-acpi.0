Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397153;
	b=WpXCKgIjHsnLqOaVBZC0mDxG6xWA7E5KN1yzoXgvNbeXv04zLCTNw72OL2UO4n90Fvyw
	 JR9oeoqs+uA1mHcNARd3uP6b0NnI8s5qlV1NZOQXpjTY4K+nWjKvOEb2TA1xty6bhVmBj
	 L3odpUQEV3Elarg8am0y7TXlAFO0mi7ryDp99dP16Vp0TsIFeTBuTFrXwN3LvHzATr4Fl
	 umgn7RG4j0mKlMCIuNvyoSU6jnSRamZxDpCS1sBJNtwx2gpW3u/qsbSa5AQMERz1OOSZM
	 tQYxWnrFcgwlE9hVr4P5XO4pnoVHBMEuiAWhsdCfEin5PTvl2F5+47rEGFqhTXBcEmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397153;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=6YsYPTuo2VbtL6rAHEG5MgX/FjIFiklyL5vCpof+Lk4=;
	b=ega3VnZGxYyo/c0S9eGEraFfw2Dgv9KwAP5leTZ5YrhCP2BVoy4QvBNYjL8U9ZM++GON
	 ujiSilK0L9mQcgdqDnwj6BoQx73sAqT1ZwPWvH3h3/VlG7jz+qzw4LHIWAZMK72cSZD1K
	 +GYxEVCsulqZhvrfB3AGUABSEiJOrEf9R7yRHtzKD94yrhD0oeGYKIr1JBrC+luaKKUnr
	 6zYbiNzx0XNAQXnWUOv8J4rqGfi5k+FC0EW6pTfA2YPuueNUmNtxuf2EPSlpfiYrjt2Jw
	 GF62Wcp7jNoTTX/R3Opr6ZXme7nUo4zy3YhFLtR3sikfDMrLxfegJ5Nki8l4pU8CF7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FC606A327;
	Mon, 23 Nov 2026 01:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76FC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxytEalgNrqRQiAA--.31297S3;
	Mon, 23 Nov 2026 09:25:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxNs13lANrO782AA--.30056S2;
	Mon, 23 Nov 2026 09:18:49 +0800 (CST)
Subject: Re: [PATCH v2 42/42] ACPICA: acpica: Fix typo in the IOVT_IOMMU table
 definitions
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: linux-acpi@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
 <e20e813ff50db584712f86edd2bb8c672ad755e3.1795194329.git.maciej.wieczor-retman@intel.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <38cd8d64-8e08-4eab-78d3-3775b0eb93cc@loongson.cn>
Date: Mon, 23 Nov 2026 09:20:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <e20e813ff50db584712f86edd2bb8c672ad755e3.1795194329.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxNs13lANrO782AA--.30056S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF18CFW7GrWDKr4xGFWxAFc_yoW8Kw48pr
	sF9F47KF4xJrs7GF18A3sF9F1rZa95KFy2gr43Kr9F9F1qkr15tayayFWYyFn8GFWkuas3
	tFyUtr1rJF4jqwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

Hi Maciej,

Thanks for the fix.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2026/11/21 上午1:19, Maciej Wieczor-Retman wrote:
> Change MAGAGE to MANAGE in ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT.
> 
> Link: https://github.com/acpica/acpica/commit/dee9a9e3c797
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>   drivers/acpi/loongarch/iovt.c | 6 +++---
>   include/acpi/actbl2.h         | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
> index 1e97669eaeea..e891170d9b8b 100644
> --- a/drivers/acpi/loongarch/iovt.c
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -42,7 +42,7 @@ static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
>   
>   	/* IOMMU V1 only supports PCI device management */
>   	if ((iommu->header.type == ACPI_IOVT_IOMMU_V1) ||
> -	    (iommu->flags & (ACPI_IOVT_IOMMU_PCI_DEVICE | ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT))) {
> +	    (iommu->flags & (ACPI_IOVT_IOMMU_PCI_DEVICE | ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT))) {
>   		pci_request_acs();
>   		acs_enabled = true;
>   	}
> @@ -151,7 +151,7 @@ static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
>   	}
>   
>   	/* All devices in the segment are managed by this IOMMU */
> -	if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
> +	if (np->flag & ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT)
>   		goto skip;
>   
>   	if (iovt_validate_entries(iommu) < 0) {
> @@ -280,7 +280,7 @@ static int iovt_pci_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>   		if (dev_id == np->devid)
>   			return -EINVAL;
>   
> -		if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
> +		if (np->flag & ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT)
>   			goto found;
>   
>   		list_for_each_entry(entry, &np->ep_list, list) {
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 1dafb2a71368..fe767fcf5726 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -928,7 +928,7 @@ struct acpi_iovt_iommu {
>   /* Masks for Flags field above */
>   #define ACPI_IOVT_IOMMU_PCI_DEVICE		(1<<0)
>   #define ACPI_IOVT_IOMMU_PXM_VALID		(1<<1)
> -#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT	(1<<2)
> +#define ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT	(1<<2)
>   #define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT		(1<<3)
>   #define ACPI_IOVT_IOMMU_MSI_INT_BYPASS		(1<<4)
>   
> 

