From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v7 12/15] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
Date: Sat, 14 Jan 2017 11:00:29 +0800
Message-ID: <5879944D.9020005@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-13-git-send-email-hanjun.guo@linaro.org>
 <20170113104524.GC20837@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113104524.GC20837@red-moon>
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

On 2017/1/13 18:45, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:36PM +0800, Hanjun Guo wrote:
>> platform_msi_create_device_domain() is used to ctreate
>> irqdomain for the device such as irqchip mbigen generating
>> the MSIs, it's almost ready for ACPI use except
>> of_node_to_fwnode() is for dt only, make it ACPI aware then
>> things will work in both DTS and ACPI.
> "The irqdomain creation carried out in:
>
> platform_msi_create_device_domain()
>
> relies on the fwnode_handle interrupt controller token to associate the
> interrupt controller with a specific irqdomain. Current code relies on
> the OF layer to retrieve a fwnode_handle for the device representing the
> interrupt controller from its device->of_node pointer.  This makes
> platform_msi_create_device_domain() DT specific whilst it really is not
> because after the merge of commit f94277af03ea ("of/platform: Initialise
> dev->fwnode appropriately") the fwnode_handle can easily be retrieved
> from the dev->fwnode pointer in a firmware agnostic way.
>
> Update platform_msi_create_device_domain() to retrieve the interrupt
> controller fwnode_handle from the dev->fwnode pointer so that it can
> be used seamlessly in ACPI and DT systems".

Much better, I will update the patch.

>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks
Hanjun
