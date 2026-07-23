Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A4470434;
	Thu, 23 Jul 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810877; cv=none; b=ttGLShEe/zD2L0eoSuhWtqjKmHhVpIRSw6sOZ6m4JBK0Hyq6J18qpzazZcVZGWwhj/ZIfHOekIJv2q0qSaymg7ZkQsGBXADX16eKEijyJdjeTfBQUpau5p7B8ptliTSHLzXbow86f5GrjfbdHcccIq4yh5FULVXrlGVvaIg7cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810877; c=relaxed/simple;
	bh=g5qL1SN8EZaS1BmuYMD/92dmfciBQJjW7p1tdqQJ49o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W+7/NAswH+A91MN2ozCArFbSrct2G66ZRoUn8QjHZfzhEC8dVWZC4F8kll6s4aucSD/wKpju37kZcuNkAqTK6BSz9frLNQOMSnLGgKV57ZUKRNtkCxE24kgjQMyOapzToMDvt61z/tvW5WYeq0F0MGDDLS8U29AoD85cX6ZQa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxqKB6DWJqIX0GAA--.1378S3;
	Thu, 23 Jul 2026 20:47:54 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxSsR3DWJqM0cWAA--.631S2;
	Thu, 23 Jul 2026 20:47:53 +0800 (CST)
Subject: Re: [PATCH v2 1/4] ACPI: LoongArch: Add acpi_arch_[late]_init()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, lixianglai@loongson.cn
References: <20260717063713.3638059-1-maobibo@loongson.cn>
 <20260717063713.3638059-2-maobibo@loongson.cn>
 <CAJZ5v0j4w01XhqQ1EHKCMXOs=v-cddPu=NtdtX3wL7vAi6Y9Rg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7b74d0c7-23ea-6c84-1dfd-e5e921badbdd@loongson.cn>
Date: Thu, 23 Jul 2026 20:47:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j4w01XhqQ1EHKCMXOs=v-cddPu=NtdtX3wL7vAi6Y9Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxSsR3DWJqM0cWAA--.631S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4xCFWUZFW5ZF45ury7XFc_yoW5tF1xpF
	W0kFs7Cr4xJayxGr92q34YqFy5tw4Skry29FyUK34UZFZ8urnxJrn5Xr98ua4kAr4DGF4S
	v3Z5KFy3KF4UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUU
	UUU



On 2026/7/22 上午3:10, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 17, 2026 at 8:44 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> LoongArch IOMMU scanning flow is similar with virtio-iommu,
>> there is early init and late_init. In early init function, PCI
>> ACS is enabled if there is IOMMU table, and late_init is called
>> after PCI device scanning, where IOVT table scanning function is
>> executed.
>>
>> Here add acpi_arch_init() and acpi_arch_late_init() API on LoongArch,
>> now they are both empty, In the future, IOVT table parsing will be
>> added.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   drivers/acpi/Makefile           |  2 +-
>>   drivers/acpi/bus.c              |  2 ++
>>   drivers/acpi/loongarch/Makefile |  2 ++
>>   drivers/acpi/loongarch/init.c   | 11 +++++++++++
>>   include/linux/acpi.h            |  1 +
>>   5 files changed, 17 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/acpi/loongarch/Makefile
>>   create mode 100644 drivers/acpi/loongarch/init.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index d1b0affb844f..91584a3c1e01 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -131,6 +131,6 @@ obj-y                               += dptf/
>>   obj-$(CONFIG_ARM64)            += arm64/
>>
>>   obj-$(CONFIG_ACPI_VIOT)                += viot.o
>> -
>> +obj-$(CONFIG_LOONGARCH)                += loongarch/
>>   obj-$(CONFIG_RISCV)            += riscv/
>>   obj-$(CONFIG_X86)              += x86/
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index a30a904f6535..5f6924b9e29d 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1571,6 +1571,7 @@ struct kobject *acpi_kobj;
>>   EXPORT_SYMBOL_GPL(acpi_kobj);
>>
>>   void __weak __init acpi_arch_init(void) { }
>> +void __weak __init acpi_arch_late_init(void) { }
>>
>>   static int __init acpi_init(void)
>>   {
>> @@ -1609,6 +1610,7 @@ static int __init acpi_init(void)
>>          acpi_wakeup_device_init();
>>          acpi_debugger_init();
>>          acpi_setup_sb_notify_handler();
>> +       acpi_arch_late_init();
>>          acpi_viot_init();
>>          return 0;
>>   }
>> diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Makefile
>> new file mode 100644
>> index 000000000000..d3764139dfaf
>> --- /dev/null
>> +++ b/drivers/acpi/loongarch/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-y                                  += init.o
>> diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
>> new file mode 100644
>> index 000000000000..b11aa5c7d928
>> --- /dev/null
>> +++ b/drivers/acpi/loongarch/init.c
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/acpi.h>
>> +
>> +void __init acpi_arch_init(void)
>> +{
>> +}
>> +
>> +void __init acpi_arch_late_init(void)
>> +{
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 60ab50cb8930..c6a180341c2d 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1617,6 +1617,7 @@ static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
>>   #endif
>>
>>   void acpi_arch_init(void);
>> +void acpi_arch_late_init(void);
>>
>>   #ifdef CONFIG_ACPI_PCC
>>   void acpi_init_pcc(void);
>> --
> 
> Please fold this one into the patch in which the new function is actually used.
Hi Rafael,

Thanks for reviewing my patch.

yeap, will fold this one into the patch where it is actually used.

Regards
Bibo Mao
> 
> Thanks!
> 

