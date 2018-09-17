From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v2 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
Date: Mon, 17 Sep 2018 16:46:27 -0600
Message-ID: <0a40d4e5-8b5b-dc6c-17e3-d6f02e396b2d@codeaurora.org>
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
 <1536942489-4018-3-git-send-email-jhugo@codeaurora.org>
 <71208e0e-fba9-ad6c-7578-a53fd1aa3f40@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71208e0e-fba9-ad6c-7578-a53fd1aa3f40@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, jeremy.linton@arm.com
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On 9/17/2018 10:17 AM, Sudeep Holla wrote:
> 
> 
> On 14/09/18 17:28, Jeffrey Hugo wrote:
>> The type of a cache might not be specified by architectural mechanisms (ie
>> system registers), but its type might be specified in the PPTT.  In this
>> case, we should populate the type of the cache, rather than leave it
>> undefined.
>>
>> This fixes the issue where the cacheinfo driver will not populate sysfs
>> for such caches, resulting in the information missing from utilities like
>> lstopo and lscpu, thus degrading the user experience.
>>
>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/acpi/pptt.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index d1e26cb..bb00ed9 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -402,11 +402,18 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   		}
>>   	}
>>   	/*
>> -	 * If the above flags are valid, and the cache type is NOCACHE
>> -	 * update the cache type as well.
>> +	 * If cache type is NOCACHE, then the cache hasn't been specified
>> +	 * via other mechanisms.  Update the type if either the cache has
>> +	 * been fully specified in PPTT, or a cache type has been provided.
>> +	 *
>> +	 * Note, we assume such caches are unified based on conventional system
>> +	 * design and known examples.  Significant work is required elsewhere to
>> +	 * fully support data/instruction only type caches which are only
>> +	 * specified in PPTT.
>>   	 */
>> -	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
>> +	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
>> +	    (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
>> +	     found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
>>   		this_leaf->type = CACHE_TYPE_UNIFIED;
> 
> I thought I did mention that we can drop the valid_flags altogether
> unless Jeremy has reasons not to.
> 

You suggested that perhaps that could be the case.  It seemed like an 
open question to me.  I'm at Linaro Connect without access to the device 
this week, so I guess someone has roughly a week to chime in that the 
valid flags should be kept, otherwise I'll try a v3 with them removed.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
