From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Wed, 12 Sep 2018 08:48:21 -0600
Message-ID: <337ef641-e645-137a-3d7f-d457264d94d5@codeaurora.org>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On 9/12/2018 4:49 AM, Sudeep Holla wrote:
> 
> 
> On 11/09/18 21:38, Jeffrey Hugo wrote:
>> On 9/11/2018 2:16 PM, Jeremy Linton wrote:
>>> Hi Jeffrey,
>>>
>>> (+Sudeep)
>>>
> 
> [..]
> 
>>>
>>> If you look at the next line of code following this comment its going
>>> to update the cache type for fully populated PPTT nodes. Although with
>>> the suggested change its only going to activate if someone completely
>>> fills out the node and fails to set the valid flag on the cache type.
>>
>> Yes, however that case doesn't apply to the scenario we are concerned
>> about, doesn't seem to be fully following the PPTT spec, and seems odd
>> that Linux just assumes that a "fully specified" cache is unified.
>>
> 
> Agreed, but adding code that will never get used is also not so good.
> Do you have systems where this is needed ?

Yes.

> 
>>> What I suspect is happening in the reported case is that the nodes in
>>> the PPTT table are missing fields we consider to be important. Since
>>> that data isn't being filled out anywhere else, so we leave the cache
>>> type alone too. This has the effect of hiding sysfs nodes with
>>> incomplete information.
>>>
>>> Also, the lack of the DATA/INST fields is based on the assumption that
>>> the only nodes which need their type field updated are outside of the
>>> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are
>>> you hitting this case?
>>>
>>
>> Yes.  Without this change, we hit the lscpu error in the commit message,
>> and get zero output about the system.  We don't even get information
>> about the caches which are architecturally specified or how many cpus
>> are present.  With this change, we get what we expect out of lscpu (and
>> also lstopo) including the cache(s) which are not architecturally
>> specified.
>>
> 
> lscpu and lstopo are so broken. They just assume everything on CPU0.
> If you hotplug them out, you start seeing issues. So reading and file
> that doesn't exist and then bail out on other essential info though they
> are present, hmmm ...

lscpu/lstopo being broken seems orthogonal to me.
The kernel is not providing the type file because the kernel thinks the 
type is NOCACHE, despite PPTT providing a type.  In an ideal world, I 
think the kernel should be fixed (this change), and any deficiencies or 
bad assumptions in lscpu/lstopo should also be fixed.

> 
>> I guess I still don't understand why its important for PPTT to list, for
>> example, the sets/ways of a cache in all scenarios.  In the case of a
>> "transparent" cache (implementation defined as not reported per section
>> D3.4.2 of the ARM ARM where the cache cannot be managed by SW), there
>> may not be valid values for sets/ways.  I would argue its better to not
>> report that information, rather than provide bogus information just to
>> make Linux happy, which may break other OSes and provide means for which
>> a user to hang themselves.
>>
> 
> While I agree presenting wrong info is not good, but one of the reasons
> the cache info is present is to provide those info for some applications
> to do optimization based on that(I am told so and not sure if just type
> and size will be good enough) and you seem to agree with that below.

Yes, but if its not entirely clear, on my system, we have the 
information but its not being presented.  This change fixes that.  I'm 
willing to discuss an alternative fix, but to ignore the issue is not 
viable in my opinion.

What do we need to move forward here?

> 
>> However, in the case of a transparent cache, the size/type/level/write
>> policy/etc (whatever the firmware provider deems relevant) might be
>> valuable information for the OS to make scheduling decisions, and is
>> certainly valuable for user space utilities for cross-machine/data
>> center level job scheduling.
>>
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
