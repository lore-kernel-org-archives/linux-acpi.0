From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Tue, 11 Sep 2018 16:25:36 -0500
Message-ID: <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 09/11/2018 03:38 PM, Jeffrey Hugo wrote:
> On 9/11/2018 2:16 PM, Jeremy Linton wrote:
>> Hi Jeffrey,
>>
>> (+Sudeep)
>>
>> On 09/11/2018 02:32 PM, Jeffrey Hugo wrote:
>>> The type of a cache might not be specified by architectural 
>>> mechanisms (ie
>>> system registers), but its type might be specified in the PPTT.  In this
>>> case, following the PPTT specification, we should identify the cache as
>>> the type specified by PPTT.
>>>
>>> This fixes the following lscpu issue where only the cache type sysfs 
>>> file
>>> is missing which results in no output providing a poor user 
>>> experience in
>>> the above system configuration-
>>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No 
>>> such
>>> file or directory
>>>
>>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology 
>>> Table parsing)
>>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>> ---
>>>   drivers/acpi/pptt.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>> index d1e26cb..3c6db09 100644
>>> --- a/drivers/acpi/pptt.c
>>> +++ b/drivers/acpi/pptt.c
>>> @@ -401,6 +401,21 @@ static void update_cache_properties(struct 
>>> cacheinfo *this_leaf,
>>>               break;
>>>           }
>>>       }
>>> +    if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
>>> +        (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
>>> +        switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
>>> +        case ACPI_PPTT_CACHE_TYPE_DATA:
>>> +            this_leaf->type = CACHE_TYPE_DATA;
>>> +            break;
>>> +        case ACPI_PPTT_CACHE_TYPE_INSTR:
>>> +            this_leaf->type = CACHE_TYPE_INST;
>>> +            break;
>>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED:
>>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
>>> +            this_leaf->type = CACHE_TYPE_UNIFIED;
>>> +            break;
>>> +        }
>>> +    }
>>>       /*
>>>        * If the above flags are valid, and the cache type is NOCACHE
>>>        * update the cache type as well.
>>>
>>
>> If you look at the next line of code following this comment its going 
>> to update the cache type for fully populated PPTT nodes. Although with 
>> the suggested change its only going to activate if someone completely 
>> fills out the node and fails to set the valid flag on the cache type. 
> 
> Yes, however that case doesn't apply to the scenario we are concerned 
> about, doesn't seem to be fully following the PPTT spec, and seems odd 
> that Linux just assumes that a "fully specified" cache is unified.

Because, the architecturally specified ones won't be type NOCACHE?

> 
>> What I suspect is happening in the reported case is that the nodes in 
>> the PPTT table are missing fields we consider to be important. Since 
>> that data isn't being filled out anywhere else, so we leave the cache 
>> type alone too. This has the effect of hiding sysfs nodes with 
>> incomplete information.
>>
>> Also, the lack of the DATA/INST fields is based on the assumption that 
>> the only nodes which need their type field updated are outside of the 
>> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are 
>> you hitting this case?
>>
> 
> Yes.  Without this change, we hit the lscpu error in the commit message, 
> and get zero output about the system.  We don't even get information 
> about the caches which are architecturally specified or how many cpus 
> are present.  With this change, we get what we expect out of lscpu (and 
> also lstopo) including the cache(s) which are not architecturally 
> specified.

I'm a bit surprised this changes the behavior of the architecturally 
specified ones. As I mentioned above, those shouldn't be NOCACHE. We use 
the level/type as a key for matching a PPTT node to an architecturally 
described cache. If that is mismatched, something more fundamental is 
happening. About the only case I can think of that can cause this is if 
the CLIDR type fields are incorrect.

In which case I might suggest we move your switch() for the INST/DATA 
into the check below that comment.

> 
> I guess I still don't understand why its important for PPTT to list, for 
> example, the sets/ways of a cache in all scenarios.  In the case of a 
> "transparent" cache (implementation defined as not reported per section 
> D3.4.2 of the ARM ARM where the cache cannot be managed by SW), there 
> may not be valid values for sets/ways.  I would argue its better to not 
> report that information, rather than provide bogus information just to 
> make Linux happy, which may break other OSes and provide means for which 
> a user to hang themselves.

This doesn't really have anything to do with the Arm/ARM's definition of 
set/way as it pertains to cache maint. Its more to assist userspace 
software with an understanding of the system cache architecture so it 
can make intelligent decisions about loop tiling and the like.

What we want is a consistent dependable view for software to utilize. An 
unreliable sysfs field is one that tends not to get used.

> 
> However, in the case of a transparent cache, the size/type/level/write 
> policy/etc (whatever the firmware provider deems relevant) might be 
> valuable information for the OS to make scheduling decisions, and is 
> certainly valuable for user space utilities for cross-machine/data ou
> center level job scheduling.
> 
