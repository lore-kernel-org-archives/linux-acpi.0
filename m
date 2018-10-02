From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v3 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
Date: Tue, 2 Oct 2018 09:30:16 -0600
Message-ID: <84bcc957-6833-a7be-21e2-42014a7e0fd1@codeaurora.org>
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-3-git-send-email-jhugo@codeaurora.org>
 <20181002105705.GB1086@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002105705.GB1086@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, jeremy.linton@arm.com, linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On 10/2/2018 4:57 AM, Sudeep Holla wrote:
> On Thu, Sep 27, 2018 at 08:57:57PM -0600, Jeffrey Hugo wrote:
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
>>   drivers/acpi/pptt.c | 30 +++++++++++++-----------------
>>   1 file changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index d1e26cb..38ac30e 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -357,25 +357,15 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   				    struct acpi_pptt_cache *found_cache,
>>   				    struct acpi_pptt_processor *cpu_node)
>>   {
>> -	int valid_flags = 0;
>> -
>>   	this_leaf->fw_token = cpu_node;
>> -	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>>   		this_leaf->size = found_cache->size;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
>>   		this_leaf->coherency_line_size = found_cache->line_size;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
>>   		this_leaf->number_of_sets = found_cache->number_of_sets;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
>>   		this_leaf->ways_of_associativity = found_cache->associativity;
>> -		valid_flags++;
>> -	}
>>   	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
>>   		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>>   		case ACPI_PPTT_CACHE_POLICY_WT:
>> @@ -402,11 +392,17 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   		}
>>   	}
>>   	/*
>> -	 * If the above flags are valid, and the cache type is NOCACHE
>> -	 * update the cache type as well.
>> +	 * If cache type is NOCACHE, then the cache hasn't been specified
>> +	 * via other mechanisms.  Update the type if a cache type has been
>> +	 * provided.
>> +	 *
>> +	 * Note, we assume such caches are unified based on conventional system
>> +	 * design and known examples.  Significant work is required elsewhere to
>> +	 * fully support data/instruction only type caches which are only
>> +	 * specified in PPTT.
>>   	 */
>>   	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
> 
> I don't think we use PPTT_CHECKED_ATTRIBUTES elsewhere.
> If so, can we drop that ?
> 
> Other than that:
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Whoops, you are right.  For some reason I thought that came from the 
standard ACPICA definitions.  Let me drop that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
