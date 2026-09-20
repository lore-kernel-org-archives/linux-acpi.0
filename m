Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB943451CE;
	Sun, 20 Sep 2026 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867719; cv=none; b=OQ1nvJ3mVD1dwIpaIruvJNy06vQghTCk5xXrptMkdYSyn1ZYcYb5sS5tdELc1QH3KSynFsiIRj5VtDHhUrAvCSDZ6heg9byzM+cJ9BKdCYBJquCbp2I7LY7a58yChN06j0W5/WIeqBIoqcMCc7PUJ7NaHLLif7QqiEfXi7wb+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867719; c=relaxed/simple;
	bh=3YY9k9tZphc+4Vot4HrDaoMwDPDJAbRf5WKFEsVnD3I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eh/BRJ66h2ZBOAM9jGfD0WCCaXo/ufSzUs88n9pBMfLSavmrVOBwTLIY47qjaCAPADEHBzO5YGcJqx1rOvE9IslY1i77xFC1EEtSvGtDFauK3rcV4WekE90ztYLBq4eb8bWokVpJ0UI38V3Dd4B8O93uIHFsSb7CU3QGjmck0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Ax39LENq9qKs8NAA--.39876S3;
	Sun, 20 Sep 2026 09:28:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAx3c7ANq9qzs0iAA--.9027S2;
	Sun, 20 Sep 2026 09:28:33 +0800 (CST)
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for drivers/acpi/loongarch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown
 <lenb@kernel.org>, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 lixianglai@loongson.cn
References: <20260915032627.2796747-1-maobibo@loongson.cn>
 <20260915032627.2796747-5-maobibo@loongson.cn>
 <CAAhV-H5TEPKXjZNDzObDJmpa=GHeeVZv+1ry0=uZHiWCXCqL5Q@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a474018c-74f8-39fc-bafa-19dfdc5577a0@loongson.cn>
Date: Sun, 20 Sep 2026 09:28:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5TEPKXjZNDzObDJmpa=GHeeVZv+1ry0=uZHiWCXCqL5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c7ANq9qzs0iAA--.9027S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJryxJry5Zr4xCFW5WFyxtFc_yoW8Zw17pr
	n7AFs7CFW7Gr17A3Z3K345uFn8Xrn7CryI9rs7K34UCF98ur1UWF10g3sFgas8Xw4rXFW0
	gF9akw1YvayjqFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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



On 2026/9/19 下午10:19, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Sep 15, 2026 at 11:34 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> ACPI defines few LoongArch specific tables which need parsing code
>> added in drivers/acpi/loongarch. Add maintainer entries for this newly
>> created folder.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   MAINTAINERS            | 9 +++++++++
>>   arch/loongarch/Kconfig | 1 +
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c2414447892c..e19be0c1654e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -347,6 +347,15 @@ S: Maintained
>>   F:     drivers/acpi/riscv/
>>   F:     include/linux/acpi_rimt.h
>>
>> +ACPI FOR LoongArch (ACPI/LoongArch)
> Similar to others, I think this should be: ACPI FOR LOONGARCH (ACPI/LoongArch).
Will do in next version.

> 
>> +M:     Bibo Mao <maobibo@loongson.cn>
>> +R:     Huacai Chen <chenhuacai@kernel.org>
> If this series can be merged to the loongarch tree, then it is better
> to mark me as M.
Yes, will do so.

I am only maintainer of IOVT not the whole ACPI LoongArch.
> 
>> +L:     linux-acpi@vger.kernel.org
>> +L:     loongarch@lists.linux.dev
>> +S:     Maintained
>> +F:     drivers/acpi/loongarch/
>> +F:     include/linux/acpi_iovt.h
>> +
>>   ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>>   M:     Sudeep Holla <sudeep.holla@kernel.org>
>>   L:     linux-acpi@vger.kernel.org
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 2067d1f2ad7a..d7f8e4fec952 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -6,6 +6,7 @@ config LOONGARCH
>>          select ACPI_GENERIC_GSI if ACPI
>>          select ACPI_MCFG if ACPI
>>          select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>> +       select ACPI_IOVT if ACPI
>>          select ACPI_PPTT if ACPI
>>          select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>>          select ARCH_BINFMT_ELF_STATE
> I think this part should be in Patch#2.
Will do in next version.

Regards
Bibo Mao
> 
> 
> Huacai
>> --
>> 2.39.3
>>

