From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Date: Tue, 03 Nov 2015 23:19:23 +0800
Message-ID: <5638D07B.2030001@linaro.org>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103141512.GC3574@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: catalin.marinas@arm.com, Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org, will.deacon@arm.com, wangyijing@huawei.com, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, "liudongdong (C)" <liudongdong3@huawei.com>, msalter@redhat.com, arnd@arndb.de, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Narinder.Dhillon@caviumnetworks.com, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On 11/03/2015 10:15 PM, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:
>
> [...]
>
>>> -int raw_pci_write(unsigned int domain, unsigned int bus,
>>> -		unsigned int devfn, int reg, int len, u32 val)
>>> +struct pci_ops pci_root_ops = {
>>> +	.map_bus = pci_mcfg_dev_base,
>>> +	.read = pci_generic_config_read,
>>> +	.write = pci_generic_config_write,
>>
>>
>> Can you change these with pci_generic_config_read32 and
>> pci_generic_config_write32? We have some targets that can only do 32
>> bits PCI config space access.
>
> No.
>
> http://www.spinics.net/lists/linux-pci/msg44869.html
>
> Can you be a bit more specific please ?
>
> Sigh. Looks like we have to start adding platform specific quirks even
> before we merged the generic ACPI PCIe host controller implementation.

Cc Gab, Zhou, and Dondong who upstream the hip05 (designware) PCIe host
support.

I think so, some platform may not support ECAM for root complex,
which needs special handling of access config space, we may need
to consider those cases.

Thanks
Hanjun
