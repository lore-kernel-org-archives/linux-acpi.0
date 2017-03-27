From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v9 15/15] irqchip: mbigen: Add ACPI support
Date: Mon, 27 Mar 2017 09:46:43 +0100
Message-ID: <c07135ba-f14f-fa2f-bd1b-e00cc758b3e7@arm.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-16-git-send-email-guohanjun@huawei.com>
 <20170321144521.GA4392@red-moon>
 <12635f14-8cbd-61ba-74fa-495a81f94038@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <12635f14-8cbd-61ba-74fa-495a81f94038@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Garry <john.garry@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, yimin@huawei.com, Greg KH <gregkh@linuxfoundation.org>, linuxarm@huawei.com, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hanjun, John,

On 22/03/17 14:12, John Garry wrote:
> On 21/03/2017 14:45, Lorenzo Pieralisi wrote:
>> On Tue, Mar 07, 2017 at 08:40:10PM +0800, Hanjun Guo wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>
>>> With the preparation of platform msi support and interrupt producer
>>> in DSDT, we can add mbigen ACPI support now.
>>>
>>> We are using Interrupt resource type in _CRS methd to indicate number
>>> of irq pins instead of num_pins in DT to avoid _DSD usage in this case.
>>>
>>> For mbigen,
>>>     Device(MBI0) {
>>>           Name(_HID, "HISI0152")
>>>           Name(_UID, Zero)
>>>           Name(_CRS, ResourceTemplate() {
>>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>>> 		  Interrupt(ResourceProducer,...) {12,14,....}
>>
>> What do these interrupt numbers represent ? This looks wrong to me.
>> An interrupt descriptor is there to describe the interrupts a device
>> can generate; you are using it just to add a "standard" (that is
>> not standard at all) way of counting the number of vectors allocated
>> to this specific chip and that's just wrong.
>>
> 
> As I understand, the count of interrupts we are declaring for the mbigen 
> is the same as the sum of interrupts for that mbigen's children.
> 
> So at the point we probe the mbigen, can we just deference the children 
> to count their interrupts, and use this as the #msis?
> 
>> Can't you use something like Agustin did in the QCOM combiner:
>>
>> drivers/irqchip/qcom-irq-combiner.c
>>
>> to detect the MSI vector length (ie by describing the MBIgen through
>> generic registers and use the bit width to compute the vector
>> lenght) ? I am not sure how feasible it is given that my knowledge
>> of MBIgen is pretty poor.
>>
>> I understand we want to avoid _DSD properties but we should not
>> work around standard bindings to achieve that goal.
>>
> 
> We use "num-pins" for dt solution, but it is not so welcome here.

Well, this device is already completely out of any standard description
on the ACPI side. And given that it bloats both the ACPI tables and the
kernel data structures, I can only suggest that you take advantage of
_DSD here, as misusing the standard properties is not something that we
should condone. It will also make the driver more manageable, as it will
use similar properties on both firmware implementations.

I feel like I need to stress the urgency here. We're at -rc4, and still
with unsolved issues. None of us want to miss the next merge window.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
