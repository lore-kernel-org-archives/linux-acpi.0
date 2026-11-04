Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780977;
	b=zIsAmNN1zvb1SDjLMUgQnJH9q9CRV6EnFoQNY2VhMWyJ8jEc5YrixxHVxT/v+sw6K1bu
	 BJdrjPIxsQoFeBv/2+UT4GxujbdzypFF7Hwfxqnhm6hnM9HPORRwLdAfEyLfjpes3f0lw
	 GEyQUvSbhoyTInpzieAaDAOL67b30jWnwsdhmyRI/Gdt0LOrtjlG0NCiH7WumF/w6MtVR
	 j4TDytTg+oHr+VLwDhne4PKLo9gjUEvJX/yq7r32yJj+Ao31V5oJ8kSufpuMavJ6n4ZbR
	 deVCVXOtQw/YlpiWI/P1hUyyVbtHY+GryuFpgHkCmcXL5MEIsX/QV3C/FXFyAVbsSOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780977;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=BdRyfiAiBhdEip/a7W+YtBi0UikVbecSudJU78nJFMQ=;
	b=ItcKJjh3TBIuc1xcVdIVoyapudAZyfL2LpSbXGpN/S03VP4ftmUQxcaRJTAgVL1c4vvt
	 5394z22TiEDMYx5cvPuUxHVyvpDh+9XYexbdoUTeUDdlPIFYk2qD1aD/NZH/cljeOmvGG
	 L9O9JnpQ2TZZhQdCL8kptCfyBdsJsVuX0zZOnbjlgBXGANZOF1iHS0pd/J/gH9tOAcfEr
	 BM8EQaghUcMhzTc6vzHURlYo6fVKn+J+ifI1zKDqaosOD6FCmRRFxBgKYXKZhcqAZ/mb1
	 5VV6WY2F2uw7udN+ViEdn/ehe7oRMT2NXz68tJ4AAOZfHJ+BqG/EqxlCXmTEo4lrLng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA4606A329;
	Wed,  4 Nov 2026 08:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9AA4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxfdLp7OpqkD0cAA--.16292S3;
	Wed, 04 Nov 2026 16:29:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJBxpMzj7Opq10cyAA--.11207S2;
	Wed, 04 Nov 2026 16:29:25 +0800 (CST)
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Huacai Chen <chenhuacai@kernel.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, loongarch@lists.linux.dev,
 maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
References: <20260922121058.972734-2-maobibo@loongson.cn>
 <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7e7a61a3-eda7-8b22-0df1-648426492e30@loongson.cn>
Date: Wed, 4 Nov 2026 16:30:40 +0800
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
In-Reply-To: <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpMzj7Opq10cyAA--.11207S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1ftr48JFWxCryxurW5twc_yoW8WryxpF
	s2ka18KFyDXr47Cw1vgw13GF1rt3yrCr1I9w1Igr42yr9Ikw1rtF4Uua1Y9F97urs5CF4I
	yFy2qrWfWFyjvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUU
	UU=



On 2026/10/23 下午3:59, Huacai Chen wrote:
> Bibo,
> 
> Now I have applied this series but with some modifications, please
> double check and test the code.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

Thanks, it works well on 7.4.0-rc1 version.

Regards
Bibo Mao
> 
> Huacai
> 
> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> This change is already merged in acpica tree.
>>
>> slightly ping.
>>
>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>   > According to the IOVT specification, define macros for each bit of the
>>   > Flags field in the IOVT IOMMU structure.
>>   >
>>   > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>   > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>   > ---
>>   >  include/acpi/actbl2.h | 7 +++++++
>>   >  1 file changed, 7 insertions(+)
>>   >
>>   > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>   > index baef525367b5..76e4a5bc79b4 100644
>>   > --- a/include/acpi/actbl2.h
>>   > +++ b/include/acpi/actbl2.h
>>   > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>   >       u32 device_entry_offset;
>>   >  };
>>   >
>>   > +/* Masks for Flags field above */
>>   > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>   > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>   > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>   > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>   > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>   > +
>>   >  struct acpi_iovt_device_entry {
>>   >       u8 type;
>>   >       u8 length;
>>   > --
>>   > 2.39.3
>>   >
>>

