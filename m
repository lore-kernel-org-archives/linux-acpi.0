From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 4/6] cpuidle: introduce HAVE_GENERIC_CPUIDLE_ENTER for
 ARM{32,64} platforms
Date: Thu, 7 Jul 2016 14:34:36 +0100
Message-ID: <577E5A6C.9020007@arm.com>
References: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
 <1467122152-5604-5-git-send-email-sudeep.holla@arm.com>
 <1675585.udvKUofiJK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1675585.udvKUofiJK@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, PrashanthPrakash <pprakash@codeaurora.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Sunil <sunil.vl@hpe.com>
List-Id: linux-acpi@vger.kernel.org



On 07/07/16 14:21, Rafael J. Wysocki wrote:
> On Tuesday, June 28, 2016 02:55:50 PM Sudeep Holla wrote:
>> The function arm_enter_idle_state is exactly the same in both generic
>> ARM{32,64} CPUIdle driver and will be the same even on ARM64 backend
>> for ACPI processor idle driver. So we can unify it and move it as
>> generic_cpuidle_enter by introducing HAVE_GENERIC_CPUIDLE_ENTER and
>> enabling the same on both ARM{32,64}.
>>
>> This is in preparation of reuse of the generic cpuidle entry function
>> for ACPI LPI support on ARM64.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm/Kconfig              |  1 +
>>   arch/arm/kernel/cpuidle.c     |  4 ++--
>>   arch/arm64/Kconfig            |  1 +
>>   arch/arm64/kernel/cpuidle.c   |  6 +++---
>>   drivers/cpuidle/Kconfig       |  3 +++
>>   drivers/cpuidle/cpuidle-arm.c | 21 +--------------------
>>   drivers/cpuidle/cpuidle.c     | 35 +++++++++++++++++++++++++++++++++++
>>   include/linux/cpuidle.h       |  8 ++++++++
>>   8 files changed, 54 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 90542db1220d..52b3dca0381c 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -54,6 +54,7 @@ config ARM
>>   	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>>   	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
>>   	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
>> +	select HAVE_GENERIC_CPUIDLE_ENTER
>
> That "generic" part in the name concerns me a bit, because the thing is not
> really generic.  It is "common on ARM" rather.
>

I agree and that's exactly what I told Daniel. It's rather just
*ARM Generic*. Any preference on the name ? I had it header file under
include/linu/cpuidle-arm.h in the previous version. Do you prefer that ?

[..]

>> @@ -255,6 +256,40 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>   }
>>
>>   /**
>> + * cpuidle_generic_enter_state - enter into the specified idle state using the
>> + *				 generic callback if implemented
>> + *
>> + * @index: the index in the idle state table
>> + *
>> + * Returns the index in the idle state, -1 in case of error.
>> + */
>> +int cpuidle_generic_enter_state(int idx)
>> +{
>> +	int ret;
>> +
>> +	if (!idx) {
>> +		cpu_do_idle();
>> +		return idx;
>> +	}
>> +
>> +	ret = cpu_pm_enter();
>
> If you look at the users of cpu_pm_enter(), they are all ARM.  Nobody else uses
> it, so at least please put cpuidle_generic_enter_state() under a #ifdef to avoid
> building it in vain on non-ARM.
>

Agreed, that should be taken care once I do the changes you are
suggesting below.

[...]

>> @@ -246,6 +248,12 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
>>   {return 0;}
>>   #endif
>>
>> +#ifdef CONFIG_HAVE_GENERIC_CPUIDLE_ENTER
>> +extern int cpuidle_generic_enter(int idx);
>
> And if you put it under the #ifdef here, its definition also should go under
> the same #ifdef.
>

Yes I will do that.

-- 
Regards,
Sudeep
