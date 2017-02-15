From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 15:07:58 +0800
Message-ID: <3c813571-aedb-d91c-0ddc-648ad5ebedb5@cn.fujitsu.com>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <46ea45ad-e2de-27f6-e71a-6908703a48cf@linaro.org>
 <94fde58d-0869-83e3-b095-7ce78690b04c@cn.fujitsu.com>
 <66316e54-f8e5-f657-c6ce-459877a55889@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:21835 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750810AbdBOHIB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2017 02:08:01 -0500
In-Reply-To: <66316e54-f8e5-f657-c6ce-459877a55889@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi, Hanjun

[...]
>> -------MADT---------
>> Apic Id | Enable Flag
>> 0x00        1
>> 0x02        1
>
> Digital order.
>
>> 0x04        0
>> 0x06        0
>> 0x10        0
>> 0x12        0
>> 0x14        0
>> 0x16        0
>
> Same here...
>
>> -------------------------------------
>>
>> 2. I use the local APIC IDs with 0x10 and 0x12. Then, startup the
>> computer. There are 4 online CPUs.
>> The MADT likes:
>> ------MADT-------
>> Apic Id | Enable Flag
>> 0x00        1
>> 0x02        1
>> 0x10        1
>> 0x12        1
>
> And digital order...
>
>> 0x04        0
>> 0x16        0
>
> 0x06?

oops! yes.

>
>> 0x14        0
>> 0x16        0
>>
>> The position of the 0x10 and 0x12 is changed.
>
> So your firmware will list enabled CPUs first and
> them disabled one, both in digital order, and lot of
> firmware (but not all of them) doing the same thing.

It seems reasonable, I understood! :)

Thanks,
Liyang

>
> Thanks
> Hanjun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


