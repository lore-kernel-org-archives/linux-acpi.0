Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186712;
	b=I16RgHXgrSpkNI/qfYDSyU3tR4CuAMzysquFD3tO8p0lateWPdIlcM1hM8X/DXpskovO
	 l7cDTri3gQtP9COUZF64mvajlqweoVWVU37djqCp8vKM6QrAqBe4sqAXit7kojM9cWe1U
	 M4GYJ/3lXF65+bWcrkRSVMaFnP2x/KXjmT8d6DD4D5russQT6a3qs2c0M6NHmktZ5Olqx
	 O5B6nT3UWWST9Akno7vwcrBBDFcqu8Awg5w7kO4Ageba0/u0MP8xrfie/UIrnyn6vBl25
	 e6ZyedU9do5ArZqfvvvpLOW/MsEgvpZfwEFt2tVbupJzwLjn0d7cL1vBd2kOrymL5XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186712;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=9P3WGVRobvf0VOQno0zPnA6gg2epfGNkklCx41pVOco=;
	b=oGdosESy5TEA5hxe0n8i9TSF6ooLzvqv/8jBrLKX+KB6ftMHrq2MO17g7rJTdC1gADzq
	 tn4+Xv2kw+hg9D3aD3uziZjwwIwi54ZI+xMohBFKkQpH6DIqx56o2EHH2PU+8OTqiGwOd
	 kYRcCOdw/QuPyc17ur2x4Z2m6I5uhsyN1rf3771AEgmZCywFgDnKLbD0HN5i2gcYmmz3l
	 vvbKOrncTpaFGFMZbV4DonR9qls156lutFbS0ooEBvAquk/7MTkG+BS1oFI0ZCd7bo3KC
	 KRPcwkajyKxlIPI4XUnwFBNoCafJihRyi+/j6ZI5lbtKLUQ7Q5KOZfvrMJTo4riUC1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64B606A320;
	Mon,  9 Nov 2026 01:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA64B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxbdLLHfFqbqodAA--.21758S3;
	Mon, 09 Nov 2026 09:11:39 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJAx1czHHfFqdxMzAA--.10573S2;
	Mon, 09 Nov 2026 09:11:35 +0800 (CST)
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
 <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn>
 <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
 <66b9d482-d577-748c-729d-0fba70701d3d@loongson.cn>
 <CAAhV-H6PL6RLM3KA4BLQEt804FnsDE4CtKeB0KaW7Gj8rm2PMw@mail.gmail.com>
 <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn>
 <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
 <e04352c2-f4ce-d415-72d4-21e03b828843@loongson.cn>
 <CAAhV-H7phy=T1MMNpSnZdjjiQXH41S7jnFcgfZd_4b5aqffB6g@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c2694499-c1fa-5365-6572-3688ee6b34aa@loongson.cn>
Date: Mon, 9 Nov 2026 09:12:51 +0800
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
In-Reply-To: <CAAhV-H7phy=T1MMNpSnZdjjiQXH41S7jnFcgfZd_4b5aqffB6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1czHHfFqdxMzAA--.10573S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Cw15KrWfZF1kJr1xZw48KrX_yoWDuFyxpF
	4UJFW5tFWUJr47Kr10qw1DCr1Yyr18KryxWr15KryUGrnrKr1rJF4UJFyYkF95A34DGF1x
	tF1UtrW7WF1UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U



On 2026/11/7 下午8:25, Huacai Chen wrote:
> On Sat, Nov 7, 2026 at 9:43 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/11/6 下午10:58, Huacai Chen wrote:
>>> On Thu, Nov 5, 2026 at 7:22 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/11/5 下午6:31, Huacai Chen wrote:
>>>>> On Thu, Nov 5, 2026 at 5:49 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2026/11/5 下午5:31, Huacai Chen wrote:
>>>>>>> On Thu, Nov 5, 2026 at 5:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2026/10/23 下午3:59, Huacai Chen wrote:
>>>>>>>>> Bibo,
>>>>>>>>>
>>>>>>>>> Now I have applied this series but with some modifications, please
>>>>>>>>> double check and test the code.
>>>>>>>>>
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>>>>>>>> In my v4 submit, it is:
>>>>>>>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>>>>> +                       is_start = true;
>>>>>>>> +                       start_devid = ep->device_id;
>>>>>>>> +                       break;
>>>>>>>> however in rc1, it is modified as:
>>>>>>>>                      case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>>>>>                              is_start = true;
>>>>>>>>                              entry->start_devid = ep->device_id;
>>>>>>>>                              break;
>>>>>>>> Here entry is not allocated and NULL pointer, it is allocated in
>>>>>>>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
>>>>>>>>
>>>>>>>> I really do not know what is aid to modify it and let others to test.
>>>>>>> Sorry, it's my fault.
>>>>>>>
>>>>>>> In theory I should point out the modification (eliminating the local
>>>>>>> variable start_devid) and refresh a new version. But we have no time
>>>>>>> to do this because when the first patch is merged into the ACPI repo
>>>>>>> it is near the merge window.
>>>>>> Maybe our work style is different, I do not care much for the coding style.
>>>>>>>
>>>>>>> If you agree, I will submit such modifications to fix it.
>>>>>> fix is welcome.
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
>>>>>>> index 87cee4f0fc80..4cdac28a1fd0 100644
>>>>>>> --- a/drivers/acpi/loongarch/iovt.c
>>>>>>> +++ b/drivers/acpi/loongarch/iovt.c
>>>>>>> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
>>>>>>> acpi_iovt_iommu *iommu)
>>>>>>>             for (i = 0; i < iommu->device_entry_num; i++) {
>>>>>>>                     switch (ep->type) {
>>>>>>>                     case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>>>> +                       entry = kzalloc_obj(struct iovt_device_entry,
>>>>>>> GFP_ATOMIC);
>>>>>> There will be memory leak problem if there are START/START/END in the table.
>>>>> That means a broken table? I think we don't need to consider broken
>>>>> tables, because there may be kinds of broken pattern rather than just
>>>>> a START/START/END.
>>>> yes, START/END/START, START/START/END, START/SINGLE/END. what is the
>>>> relationship between "don't need to consider" and kinds of broken pattern?
>>>>
>>>> what is the policy from your side with such BIOS table? let memory leak
>>>> and continue?
>>> The driver can only work with a good table or no table, but not with a
>>> broken table.
>> With a broken table, software can discard the whole table, or discard
>> the single table entry.
> Discard a single entry is dangerous because the pairing may be wrong,
> so if we should handle a broken table, we should discard the whole
> table.
> 
> Discarding the whole table need a rework, the is_start variable is not
> enough. You can consider the below solution:
Discarding the whole table is reasonable for me.
> 
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
> index 87cee4f0fc80..8381de278e3a 100644
> --- a/drivers/acpi/loongarch/iovt.c
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -73,10 +73,44 @@ static int __init iovt_get_pci_iommu_fwnode(struct
> iovt_fwnode *np, u16 segment,
>          return 0;
>   }
> 
> +static int __init iovt_validate_entries(struct acpi_iovt_iommu *iommu)
> +{
> +       int i, done = 1;
> +       struct acpi_iovt_device_entry *ep;
> +
> +       ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu,
> iommu->device_entry_offset);
> +       for (i = 0; i < iommu->device_entry_num; i++) {
> +               switch (ep->type) {
> +               case ACPI_IOVT_DEVICE_ENTRY_START:
> +                       if (!done)
> +                               return -EINVAL;
> +
> +                       done = 0;
> +                       break;
> +               case ACPI_IOVT_DEVICE_ENTRY_END:
> +                       if (done)
> +                               return -EINVAL;
> +
> +                       done = 1;
> +                       break;
> +               case ACPI_IOVT_DEVICE_ENTRY_SINGLE:
> +                       if (!done)
> +                               return -EINVAL;
> +
> +                       done = 1;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep,
> ep->length);
> +       }
> +
> +       return done ? 0 : -EINVAL;
> +}
> +
>   static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
>   {
>          int i, ret;
> -       bool is_start = false;
>          struct iovt_fwnode *np;
>          struct iovt_device_entry *entry;
>          struct acpi_iovt_device_entry *ep;
> @@ -110,23 +144,22 @@ static int __init iovt_add_iommu(struct
> acpi_iovt_iommu *iommu)
>          if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
>                  goto skip;
> 
> +       if (iovt_validate_entries(iommu) < 0)
> +               return -EINVAL;
> +
the logic about adding iovt_validate_entries() is OK, here kfree(np); 
should be added to prevent memory leak.

Regards
Bibo Mao
>          INIT_LIST_HEAD(&np->ep_list);
>          ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu,
> iommu->device_entry_offset);
>          for (i = 0; i < iommu->device_entry_num; i++) {
>                  switch (ep->type) {
>                  case ACPI_IOVT_DEVICE_ENTRY_START:
> -                       is_start = true;
> -                       entry->start_devid = ep->device_id;
> -                       break;
> -               case ACPI_IOVT_DEVICE_ENTRY_END:
> -                       if (!is_start)
> -                               break;
> -
>                          entry = kzalloc_obj(struct iovt_device_entry,
> GFP_ATOMIC);
>                          if (!entry)
>                                  return -ENOMEM;
> 
> -                       is_start = false;
> +                       entry->start_devid = ep->device_id;
> +                       break;
> +               case ACPI_IOVT_DEVICE_ENTRY_END:
> +                       /* START & END are paired */
>                          entry->end_devid = ep->device_id;
>                          list_add_tail(&entry->list, &np->ep_list);
>                          break;
> @@ -135,13 +168,12 @@ static int __init iovt_add_iommu(struct
> acpi_iovt_iommu *iommu)
>                          if (!entry)
>                                  return -ENOMEM;
> 
> -                       is_start = false;
>                          entry->start_devid = ep->device_id;
>                          entry->end_devid = ep->device_id;
>                          list_add_tail(&entry->list, &np->ep_list);
>                          break;
>                  default:
> -                       break;
> +                       return -EINVAL;
>                  }
>                  ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep,
> ep->length);
>          }
> 
>>>
>>> Take START1/START2/END as an example of broken table: in your original
>>> code, the END entry will be pairing with START2. But for a broken
>>> table who can ensure they are the correct pair? If the real correct
>>> pair is START1 and END, then (entry->start_devid, entry->end_devid)
>> there is only one policy, software does not know START1/END is right or
>> START2/END is right.
>>> will be a wrong device range. Such mistakes are much worse than a
>>> memery leak.
>>>
>>> If you want to say "I don't care about correct pairing, memory leak is
>>> bad in any case.", OK, we can do it like this:
>>>
>>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
>>> index 87cee4f0fc80..ebd11e22c9be 100644
>>> --- a/drivers/acpi/loongarch/iovt.c
>>> +++ b/drivers/acpi/loongarch/iovt.c
>>> @@ -115,6 +115,13 @@ static int __init iovt_add_iommu(struct
>>> acpi_iovt_iommu *iommu)
>>>           for (i = 0; i < iommu->device_entry_num; i++) {
>>>                   switch (ep->type) {
>>>                   case ACPI_IOVT_DEVICE_ENTRY_START:
>>> +                       if (is_start)
>>> +                               break;
>> there is still memory leak with START/SINGLE/END pairs, is_start set
>> with false with ACPI_IOVT_DEVICE_ENTRY_SINGLE case.
>>
>> Regards
>> Bibo Mao
>>> +
>>> +                       entry = kzalloc_obj(struct iovt_device_entry,
>>> GFP_ATOMIC);
>>> +                       if (!entry)
>>> +                               return -ENOMEM;
>>> +
>>>                           is_start = true;
>>>                           entry->start_devid = ep->device_id;
>>>                           break;
>>> @@ -122,10 +129,6 @@ static int __init iovt_add_iommu(struct
>>> acpi_iovt_iommu *iommu)
>>>                           if (!is_start)
>>>                                   break;
>>>
>>> -                       entry = kzalloc_obj(struct iovt_device_entry,
>>> GFP_ATOMIC);
>>> -                       if (!entry)
>>> -                               return -ENOMEM;
>>> -
>>>                           is_start = false;
>>>                           entry->end_devid = ep->device_id;
>>>                           list_add_tail(&entry->list, &np->ep_list);
>>>
>>> Huacai
>>>
>>>>
>>>>>
>>>>> Huacai
>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Bibo Mao
>>>>>>> +                       if (!entry)
>>>>>>> +                               return -ENOMEM;
>>>>>>> +
>>>>>>>                             is_start = true;
>>>>>>>                             entry->start_devid = ep->device_id;
>>>>>>>                             break;
>>>>>>> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
>>>>>>> acpi_iovt_iommu *iommu)
>>>>>>>                             if (!is_start)
>>>>>>>                                     break;
>>>>>>>
>>>>>>> -                       entry = kzalloc_obj(struct iovt_device_entry,
>>>>>>> GFP_ATOMIC);
>>>>>>> -                       if (!entry)
>>>>>>> -                               return -ENOMEM;
>>>>>>> -
>>>>>>>                             is_start = false;
>>>>>>>                             entry->end_devid = ep->device_id;
>>>>>>>                             list_add_tail(&entry->list, &np->ep_list);
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Huacai
>>>>>>>>>
>>>>>>>>> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>>>>
>>>>>>>>>> This change is already merged in acpica tree.
>>>>>>>>>>
>>>>>>>>>> slightly ping.
>>>>>>>>>>
>>>>>>>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>>>>>>>>>       > According to the IOVT specification, define macros for each bit of the
>>>>>>>>>>       > Flags field in the IOVT IOMMU structure.
>>>>>>>>>>       >
>>>>>>>>>>       > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>>>>>>>>>       > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>>>>>       > ---
>>>>>>>>>>       >  include/acpi/actbl2.h | 7 +++++++
>>>>>>>>>>       >  1 file changed, 7 insertions(+)
>>>>>>>>>>       >
>>>>>>>>>>       > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>>>>>>>>>       > index baef525367b5..76e4a5bc79b4 100644
>>>>>>>>>>       > --- a/include/acpi/actbl2.h
>>>>>>>>>>       > +++ b/include/acpi/actbl2.h
>>>>>>>>>>       > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>>>>>>>>>       >       u32 device_entry_offset;
>>>>>>>>>>       >  };
>>>>>>>>>>       >
>>>>>>>>>>       > +/* Masks for Flags field above */
>>>>>>>>>>       > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>>>>>>>>>       > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>>>>>>>>>       > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>>>>>>>>>       > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>>>>>>>>>       > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>>>>>>>>>       > +
>>>>>>>>>>       >  struct acpi_iovt_device_entry {
>>>>>>>>>>       >       u8 type;
>>>>>>>>>>       >       u8 length;
>>>>>>>>>>       > --
>>>>>>>>>>       > 2.39.3
>>>>>>>>>>       >
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>>>
>>

