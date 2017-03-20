From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: KVM: add guest SEI support
Date: Mon, 20 Mar 2017 13:44:31 +0000
Message-ID: <58CFDCBF.4060409@arm.com>
References: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
 <1488946181-130774-4-git-send-email-xiexiuqi@huawei.com>
 <58C7BBA2.4080208@arm.com> <0d082cbb-8163-1163-cdd3-3daecd57a823@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0d082cbb-8163-1163-cdd3-3daecd57a823@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com, zjzhang@codeaurora.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, guohanjun@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, fu.wei@linaro.org, shiju.jose@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hi Xie XiuQi,

On 20/03/17 07:48, Xie XiuQi wrote:
> On 2017/3/14 17:45, James Morse wrote:
>> On 08/03/17 04:09, Xie XiuQi wrote:
>>> Add ghes handling for SEI so that the host kernel could parse and
>>> report detailed error information for SEI which occur in the guest
>>> kernel.
>>
>> How does this interact with Synchronous External Abort as a notify method?
>> Both of these take the in_nmi() path through APEI.
>>
>> SError Interrupts are masked during exception processing, so we don't have to
>> worry about them becoming recursive.
> 
> If we use firmware first mode, SEI will be routed to EL3 first, in which mode
> the interrupt cannot be masked by the PSTATE.{A,I,F}.
> 
>> For SEA the firmware has to promise not to invoke another SEA while we are still
>> processing the first, and SEI will be masked if we took it as an exception.
>>
> 
> Yes, for SEI the firmware should also promise not to invoke another SEI while the
> first SEI processing.

Because the OS can mask the exception while it does the work this should be easy.


> But I have a question here, how to handle this case: on the same cpu, another SEA
> is taken while we are processing the first SEA. Should firmware detect this case and
> reset the system directly?

For SEA firmware has to only deliver one at a time. Tyler's comment[0] on this was:
Tyler Baicar wrote:
> Firmware that supports the new specs should only generate one of these at a
> time, it will wait for the ack from kernel before sending a second error
> (patch 1 of this series).

I think this is what the read ack register in GHESv2 is for.

What should happen here is up to firmware. System reset sounds sensible, if
possible it would be good if any such firmware could write both sets of error
records somewhere persistent and hand them to the OS via the BERT on the next boot.


> The same question is also for SEI.

I think SEI is different because it can be masked. For KVM we already have
kvm_inject_vabt() which sets the VSE bit in HCR_EL2. The hardware will deliver
an SError Interrupt to the guest when it next runs with SError unmasked.

If the guest was already running the APEI SEI code it should have SError masked
until its finished.

This should be the same for firmware, I don't know enough about how physical
SError is triggered.


>> What happens if we take an SEA while processing another event notified via SEI?
>> Can this happen on your platform? Can someone else build a platform where this
>> happens? Does the GHES APEI code need to be able to handle this?
> 
> IMO, the system should be panic if we take an SEA while processing another event
> notified via SEI on the same cpu, and it's not necessary to parse the GHES for the
> second SEA. However, if on different cpu, it might be taken simultaneously.

For a different CPU we will spin waiting for the APEI locks, this should all
work properly today.

How can we know that SEA interrupted a CPU that was running the APEI SEI code?

The CPU masks SError when we take an exception so we can't use PSTATE.A to tell.
Judging from the range of PC values or setting some per-cpu variable is likely
to get messy.

I think the cleanest thing is to initially make SEI and SEA mutually exclusive
using Kconfig, then refactor the APEI GHES code to allow interactions like this:

>> If we need to support both at the same time we will need to change Linux's APEI
>> code to reserve a page of virtual address space per GHES entry, instead of one
>> for NMI and one for IRQ.

This way it doesn't matter if SEA interrupts SEI. I will have a go at writing this.


> We cannot assume that firmware could prevent the SEA notify to OS while SEI is
> processing on different cpu. Because firmware use two different GHES for SEA and SEI.

I agree. We should handle any sequence of APEI notify methods that the hardware
allows to happen.



Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg567837.html
