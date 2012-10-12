From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 2/3] Do not use acpi_device to find pci root bridge in
 _init code.
Date: Fri, 12 Oct 2012 18:58:02 +0800
Message-ID: <5077F7BA.50905@cn.fujitsu.com>
References: <1350037890-5899-1-git-send-email-tangchen@cn.fujitsu.com> <1350037890-5899-3-git-send-email-tangchen@cn.fujitsu.com> <5077F2C2.1010300@huawei.com> <5077F407.3040205@cn.fujitsu.com> <5077F6E1.7090600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:34334 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab2JLK7M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Oct 2012 06:59:12 -0400
In-Reply-To: <5077F6E1.7090600@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@huawei.com>
Cc: yinghai@kernel.org, lenb@kernel.org, bhelgaas@google.com, izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/12/2012 06:54 PM, Jiang Liu wrote:
>>> I have sent a similar patch to Yinghai before. For simplicity, we could
>>> use acpi_match_object_info_ids() instead of acpi_match_device_ids()
>>> directly.
>>
>> Hum, I must have missed it. :)
>> Using acpi_match_object_info_ids() directly seems good. I'm just worry
>> about if it could cause any other problem. :)
>>
>> So now, is this bug fixed ? And we don't need these patches, right ?
>>
>> Thanks. :)
> I think Yinghai has missed my patch too, so just suggest to use
> acpi_match_object_info_ids() directly.

OK. :)

I will resend a new patch set soon. Thanks for your advice. :)

>
> --Gerry
>
>>
>>> Thanks!
>>> Gerry
>>>
>>>>
>>>>        ret = acpi_match_device_ids(device, root_device_ids);
>>>>        if (ret)
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> .
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

