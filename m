From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
Date: Wed, 10 Feb 2016 10:19:06 +0000
Message-ID: <56BB0E9A.6010809@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <56BAFAE8.4070308@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56BAFAE8.4070308@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Thomasz,

On 10/02/16 08:55, Tomasz Nowicki wrote:
> On 19.01.2016 14:11, Tomasz Nowicki wrote:
>> Patches base on Suravee's ACPI GICv2m support:
>> https://lkml.org/lkml/2015/12/10/475
>>
>> The following git branch contains submitted patches along with
>> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
>> https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)
>>
> 
> Hi Marc,
> 
> Can you please have a look at this series. I think your previous 
> concerns have been addressed.

I've just acked the first 3 patches, which I believe are good to go.

The ITS support is a separate thing, mostly because it introduces a
completely new infrastructure (IORT). I'll review that separately (no
need to resend the patches though).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
