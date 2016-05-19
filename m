From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Thu, 19 May 2016 14:26:29 +0100
Message-ID: <573DBF05.1090701@arm.com>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
 <1462981062-24909-3-git-send-email-sudeep.holla@arm.com>
 <573B58E5.2020005@codeaurora.org> <573CA866.2050804@arm.com>
 <573CBEC3.4040506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35072 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932260AbcESN0j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 May 2016 09:26:39 -0400
In-Reply-To: <573CBEC3.4040506@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>



On 18/05/16 20:13, Prakash, Prashanth wrote:
>
>
> On 5/18/2016 11:37 AM, Sudeep Holla wrote:
>>
>>
>> On 17/05/16 18:46, Prakash, Prashanth wrote:
>>> Hi Sudeep,
>>>
>>> On 5/11/2016 9:37 AM, Sudeep Holla wrote:
>>>> +
>>>> +static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>>>> +{
>>>> +    int ret, i;
>>>> +    struct acpi_lpi_states_array *info;
>>>> +    struct acpi_device *d = NULL;
>>>> +    acpi_handle handle = pr->handle, pr_ahandle;
>>>> +    acpi_status status;
>>>> +
>>>> +    if (!osc_pc_lpi_support_confirmed)
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    max_leaf_depth = 0;
>>>> +    if (!acpi_has_method(handle, "_LPI"))
>>>> +        return -EINVAL;
>>>> +    flat_state_cnt = 0;
>>>> +
>>>> +    while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
>>>> +        if (!acpi_has_method(handle, "_LPI"))
>>>> +            continue;
>>>> +
>>>> +        acpi_bus_get_device(handle, &d);
>>>> +        if (!strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
>>>> +            break;
>>>> +
>>>> +        max_leaf_depth++;
>>>> +        handle = pr_ahandle;
>>>> +    }
>>>> +
>>> In the above loop, we break when we find a device with HID ==
>>> ACPI_PROCESSOR_CONTAINER_HID. Shouldn't we continue to parse as long as the
>>> parent HID == ACPI_PROCESSOR_CONTAINER_HID? This is required to make sure we
>>> parse states in levels higher than cluster level in processor hierarchy.
>>>
>>
>> Yes, thanks for pointing that out. With just clusters in _LPI on my dev
>> board, I missed it.
>>
> Same reason, I failed to notice it all this time :)

No worries.

>>> Also, I think it might be safe to break out of the loop if we didn't find
>>> _LPI package, instead of continuing. Given  the presence of LPI entry:
>>> "Enabled Parent State", I can't think of a non-ambiguous scenario where we
>>> might find LPI packages in state N and N+2, but not in N+1, as we will not
>>> be able to figure out which state in N enables which states in N+2.
>>> Thoughts?
>>
>> Though I admit I haven't thought in detail on how to deal with the
>> asymmetric topology, but that was the reason why I continue instead of
>> breaking.
>>
>> Excerpts from the spec: "... This example is symmetric but that is not a
>> requirement. For example, a system may contain a different number of
>> processors in different containers or an asymmetric hierarchy where one
>> side of the topology tree is deeper than another...."
>>
> If it addresses asymmetric topology, sure we can keep as it doesn't impact other
> scenarios. Also, we need to set handle=pr_ahandle prior to the continue statement.
>

Yes I noticed it yesterday, the more I think, I feel we can break out of
the loop. At any level, we need to have container nodes and that must
contain _LPI irrespective of asymmetricity. So you were right. I have
fixed accordingly and have pushed out on my branch.

-- 
Regards,
Sudeep
