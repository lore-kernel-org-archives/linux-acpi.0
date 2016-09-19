From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH v2 10/11] irqchip: mbigen: Add ACPI support
Date: Mon, 19 Sep 2016 17:28:33 +0800
Message-ID: <e8611dec-ae29-af78-cfb1-7b44670fa11c@linaro.org>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-11-git-send-email-guohanjun@huawei.com>
 <57DA6097.8060105@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33238 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbcISJ2y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2016 05:28:54 -0400
Received: by mail-pf0-f170.google.com with SMTP id 21so38415010pfy.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2016 02:28:54 -0700 (PDT)
In-Reply-To: <57DA6097.8060105@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, linuxarm@huawei.com

Hi Marc,

On 2016/9/15 16:49, Marc Zyngier wrote:
> On 14/09/16 15:21, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> With the preparation of platform msi support and interrupt producer
>> in DSDT, we can add mbigen ACPI support now.
>>
>> We are using _PRS methd to indicate number of irq pins instead
>> of num_pins in DT.
>>
>> For mbi-gen,
>>     Device(MBI0) {
>>           Name(_HID, "HISI0152")
>>           Name(_UID, Zero)
>>           Name(_CRS, ResourceTemplate() {
>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>>           })
>>
>>           Name (_PRS, ResourceTemplate() {
>> 		  Interrupt(ResourceProducer,...) {12,14,....}
>>           })
>
> Since I know next to nothing about all of this, I'm going to play the
> village idiot. What makes it legal to use _PRS as a way to describe the
> interrupts that are exposed by MBI0? Looking at the 6.0 spec, I do not
> see why the interrupts would be put there instead of _CRS, and why you'd
> have a _PRS at all.

_PRS describes possible resource settings for the device, which returns
a list of a device's possible resource settings such as memory range,
interrupt descriptors, and the format of the data in a _PRS object
follows the same format as _CRS object (ACPI 6.1, section 6.2.12),
so Interrupts can be put in the _PRS.

And in ACPI 6.1, section 6.2, it describes the _PRS usage:

"Some resources, however, may be shared amongst several devices. To
describe this, devices that share a resource (resource consumers) must
use the extended resource descriptors (0x7-0xA) described in Section
6.4.3, “Large Resource Data Type.” These descriptors point to a single
device object (resource producer) that claims the shared resource in
its _PRS."

As mbigen is a interrupt producer which provide interrupt resoures
for devices, which matches the usage of _PRS in the spec.

>
> Also, are you going to exhaustively describe all the possible interrupts
> via this method? Knowing that the mbigen can expose thousands of
> interrupts, I find it slightly mad. Can't you express a range?

Yes, a little bit mad. I can't express a interrupt range in ACPI at
least in current version of spec. But that just adding more lines
of ACPI DSDT code, it's fine to me. or we need to use _DSD to present
similar property "num_pins" in ACPI which I avoid using.

Thanks
Hanjun
