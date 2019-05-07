From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
Date: Tue, 7 May 2019 12:58:25 -0500
Message-ID: <82032e5b-0cb5-e48f-ab51-ba5d5f9dceec@arm.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <guohanjun@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net, linuxarm@huawei.com, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, john.garry@huawei.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 5/4/19 6:06 AM, Hanjun Guo wrote:
> Hi Jeremy, Mark,
> 
> On 2019/5/4 7:24, Jeremy Linton wrote:
>> This patch series enables the Arm Statistical Profiling
>> Extension (SPE) on ACPI platforms.
>>
>> This is possible because ACPI 6.3 uses a previously
>> reserved field in the MADT to store the SPE interrupt
>> number, similarly to how the normal PMU is described.
>> If a consistent valid interrupt exists across all the
>> cores in the system, a platform device is registered.
>> That then triggers the SPE module, which runs as normal.
>>
>> We also add the ability to parse the PPTT for IDENTICAL
>> cores. We then use this to sanity check the single SPE
>> device we create. This creates a bit of a problem with
>> respect to the specification though. The specification
>> says that its legal for multiple tree's to exist in the
>> PPTT. We handle this fine, but what happens in the
>> case of multiple tree's is that the lack of a common
>> node with IDENTICAL set forces us to assume that there
>> are multiple non-IDENTICAL cores in the machine.
> 
> Adding this patch set on top of latest mainline kernel,
> and tested on D06 which has the SPE feature, in boot message
> shows it was probed successfully:
> 
> arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]
> 
> but when I test it with spe events such as
> 
> perf record -c 1024 -e arm_spe_0/branch_filter=0/ -o spe ls
> 
> it fails with:
> failed to mmap with 12 (Cannot allocate memory),
> 
> Confirmed that patch [0] is merged and other perf events are working
> fine.

Its pretty easy to get into the weeds with this driver, does it work 
with examples like:

https://lkml.org/lkml/2018/1/14/122

> I narrowed this issue down that mmap() failed to alloc 4M memory
> in perf tool but seems have no relationship with this SPE patch set,
> then I'm lost, could you take look please?
> 
> Thanks
> Hanjun
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=528871b456026e6127d95b1b2bd8e3a003dc1614
> 
