From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v11 7/7] arm: pmu: Add PMU definitions for cores not
 initially online
Date: Tue, 6 Dec 2016 11:56:56 -0600
Message-ID: <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
 <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
 <20161206152118.GK2498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751762AbcLFR5X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Dec 2016 12:57:23 -0500
In-Reply-To: <20161206152118.GK2498@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, punit.agrawal@arm.com, steve.capper@arm.com, msalter@redhat.com, mlangsdorf@redhat.com, linux@armlinux.org.uk

Hi,

On 12/06/2016 09:21 AM, Will Deacon wrote:
> On Fri, Dec 02, 2016 at 12:56:01PM -0600, Jeremy Linton wrote:
>> ACPI CPUs aren't associated with a PMU until they have been put
>> online. This means that we potentially have to update a PMU
>> definition the first time a CPU is hot added to the machine.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c       | 38 ++++++++++++++++++++++++++++++++++++--
>>  include/linux/perf/arm_pmu.h |  4 ++++
>>  2 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index fa40294..4abb2fe 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -711,6 +711,30 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
>>  	return 0;
>>  }
>>
>> +static DEFINE_SPINLOCK(arm_pmu_resource_lock);
>
> Why do you need this spinlock? The hotplug notifiers are serialised afaik,
> and you don't take it anywhere else.

Well, I assumed they were serialized, but then I went looking for a 
guarantee and couldn't find one specific to the notifiers, even though 
the previous lock was removed. Admittedly, I didn't spend too long 
looking, but there is a piece missing...

Which is the sync between the hotplug notification and perf start/stop. 
By itself that extends this lock into the consumers of the resource 
structure. Which might not be the right choice because even without 
these ACPI specific bits, simply running a few cpus online/offline while 
simultaneously doing something like `perf stat -e cache-misses ls &` in 
a loop causes deadlocks/crashes.

That problem doesn't appear to be specific to the ACPI/PMU so I've 
stayed away from it in this patch set, although potentially a larger fix 
might cover this as well.


