Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB630C63B;
	Tue, 14 Jul 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995818; cv=none; b=OKNrt2WVx7eS1SJtnm2hC/Soq2MBKRGsh0w7bhrhi6jms2Z4UsrNppM3DOK6Z4q4YmDqJXrdEkJpKUlIV9xJB6ceFkOuzl9bn3FNa35r53i3s6dY1emnHpjidoJPc5OstHsHK9YXiWUfKUZEQMowN1sRk3KnpbvzXIW8hR1fxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995818; c=relaxed/simple;
	bh=H6KTJybBPvk9qFrkBiisz7CKeto40sUhI261xWb94jU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CKChlNz+JEc1g8uRyEH6dVl443l8rBSkikKKVa9vgvl6y01EPIKVXUnQIwKlTXpM1/nBSQx6xP0y0EibbkLbj2aLNuRbkKpAc38IxuAHVwqYGMOU52xg18Feo45442WNXwbU2LwdLHroDJB1E7K9CKyRICIvS1wO7/zuL/k/zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxZeqmnVVqtUQDAA--.11792S3;
	Tue, 14 Jul 2026 10:23:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxPcWlnVVqQlYMAA--.57718S2;
	Tue, 14 Jul 2026 10:23:33 +0800 (CST)
Subject: Re: [PATCH 0/8] ACPI: LoongArch: Add IOVT table support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: acpica-devel@lists.linux.dev, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, loongarch@lists.linux.dev, rafael@kernel.org,
 saket.dumbre@intel.com
References: <20260617074829.2396638-1-maobibo@loongson.cn>
 <20260713100633.2102708-1-maobibo@loongson.cn>
 <CAAhV-H5FGWPnJraY9aYLrLKa5B+eo74eScTFzUeGGXT6f=4FZA@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9fa686b4-cc51-3abe-1922-b70769774a98@loongson.cn>
Date: Tue, 14 Jul 2026 10:23:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5FGWPnJraY9aYLrLKa5B+eo74eScTFzUeGGXT6f=4FZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcWlnVVqQlYMAA--.57718S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur1UXw45KF4rJrWftFy3Jrc_yoWDWFg_uF
	92y3WDury8Kr17tanayFs5AasxKw18XF4kKrykCrn2v34fJrZY9FsxuF15W3yS9ryUAFs5
	XrsFqr4UCrn8WosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2BT5DUUUU



On 2026/7/13 下午9:40, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Jul 13, 2026 at 6:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> slightly ping.
> I think the series can be re-organized as 3 patches:
> 
> ACPI: LoongArch: Add acpi_arch_[late]_init()
> includes Patch-1/4 in this series roughly.
> 
> ACPI: LoongArch: Add IOVT device entry table scanning
> includes Patch-3/5/6/7 in this series roughly.
> 
> ACPI: LoongArch: Add ACPI_IOVT config options
> includes Patch-2/8 in this series roughly.
Waiting the response from others, will do this if there is no disagreement.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>>> I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
>>> is merged on ACPI Spec 6.6, and it can be located at
>>>   https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-IO-Virtualization-Table-Specification.pdf
>>>
>>> Here add IOVT table parsing on LoongArch system, it is for use about
>>> LoongArch IOMMU driver in future.
>>

