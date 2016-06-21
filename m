From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
Date: Tue, 21 Jun 2016 09:34:11 +0100
Message-ID: <87r3br3pq4.fsf@e105922-lin.cambridge.arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
 <87h9cn6ckw.fsf@e105922-lin.cambridge.arm.com>
 <576863BF.6040800@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <576863BF.6040800@arm.com> (Jeremy Linton's message of "Mon, 20
 Jun 2016 16:44:31 -0500")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, mlangsdorf@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, acme@kernel.org, linux-acpi@vger.kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> Hi Punit,
>
> On 06/20/2016 11:37 AM, Punit Agrawal wrote:
>> Jeremy Linton <jeremy.linton@arm.com> writes:
>>
>>> Its possible that an ACPI system has multiple CPU types in it
>>> with differing PMU counters. Use the newly provided acpi_pmu routines
>>> to detect that case, and instantiate more than one set of counters.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/perf/arm_pmu.c      |  7 +++-
>>>   drivers/perf/arm_pmu_acpi.c | 98 ++++++++++++++++++++-------------------------
>>>   2 files changed, 50 insertions(+), 55 deletions(-)
>>>

[...]

>>> @@ -47,7 +52,7 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>>>   }
>>>
>>>   /* Count number and type of CPU cores in the system. */
>>> -void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>> +static void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>>   {
>>>   	int i, j;
>>>
>>
>> Please move this and the following two hunks to the previous patch where you
>> introduce the functions.
>
>
> Oh, I did this on purpose to avoid:
>
> "warning: 'xxx' defined but not used" messages.
>

In that case, I'd suggest merging the patches. IMO, it's better to have
self-contained patches be they slightly large than to introduce
artifacts like here.

>
>
>>
>>> @@ -74,7 +79,7 @@ void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>>    * Registers the group of PMU interfaces which corrispond to the 'last_cpu_id'.
>>>    * This group utlizes 'count' resources in the 'res'.
>>>    */
>>> -int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>>> +static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
