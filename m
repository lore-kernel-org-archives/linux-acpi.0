From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v3 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
Date: Wed, 3 Oct 2018 07:47:37 -0600
Message-ID: <6f773f89-326f-1b27-455d-9cb4bf0892e4@codeaurora.org>
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
 <256435083.TFCBfdESsY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <256435083.TFCBfdESsY@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: sudeep.holla@arm.com, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, jeremy.linton@arm.com, linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On 10/3/2018 3:35 AM, Rafael J. Wysocki wrote:
> On Friday, September 28, 2018 4:57:56 AM CEST Jeffrey Hugo wrote:
>> If a cache has an unknown type because neither the hardware nor the
>> firmware told us, an entry in the sysfs tree will be made, but the type
>> file will not be present.  lscpu depends on the type file being present
>> for every entry, and will error out without printing system information
>> if lscpu cannot open the type file.
>>
>> Presenting information about a cache without indicating its type is not
>> useful, therefore if we hit a cache with an unknown type, stop populating
>> sysfs so that userspace has the maximum amount of useful information.
>>
>> This addresses the following lscpu error, which prevents any output.
>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
>> file or directory
>>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/base/cacheinfo.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 5d5b598..cf78fa6 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>>   		this_leaf = this_cpu_ci->info_list + i;
>>   		if (this_leaf->disable_sysfs)
>>   			continue;
>> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
>> +			break;
>>   		cache_groups = cache_get_attribute_groups(this_leaf);
>>   		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>>   					   "index%1u", i);
>>
> 
> Can you please resend this patch with all tags collected so far?

Will do.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
