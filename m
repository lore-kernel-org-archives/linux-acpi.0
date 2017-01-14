From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v7 15/15] irqchip: mbigen: Add ACPI support
Date: Sat, 14 Jan 2017 10:56:54 +0800
Message-ID: <58799376.6040302@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-16-git-send-email-hanjun.guo@linaro.org>
 <20170113102104.GB20837@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113102104.GB20837@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Matthias Brugger <mbrugger@suse.com>, linux-acpi@vger.kernel.org, yimin@huawei.com, Greg KH <gregkh@linuxfoundation.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, huxinwei@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org, Agustin Vega-Frias <agustinv@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Hi Lorenzo,

On 2017/1/13 18:21, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:39PM +0800, Hanjun Guo wrote:
>> With the preparation of platform msi support and interrupt producer
>> in DSDT, we can add mbigen ACPI support now.
>>
>> We are using _PRS methd to indicate number of irq pins instead
>> of num_pins in DT to avoid _DSD usage in this case.
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
> I still do not understand why you are using _PRS for this, I think
> the MBIgen configuration is static and if it is so the Interrupt
> resource should be part of the _CRS unless there is something I am
> missing here.

Sorry for not clear in the commit message. MBIgen is an interrupt producer
which produces irq resource to devices connecting to it, and MBIgen itself
don't consume wired interrupts.

Also devices connecting MBIgen may not consume all the interrupts produced
by MBIgen, for example, MBIgen may produce 128 interrupts but only half of
them are currently used, so _PRS here means "provide interrupt resources
may consumed by devices connecting to it".

Should I add this into the commit message?

Thanks
Hanjun
