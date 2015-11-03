From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Date: Tue, 3 Nov 2015 15:39:36 +0100
Message-ID: <5638C728.2020503@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20151103141512.GC3574@red-moon>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com, Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com, Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 03.11.2015 15:15, Lorenzo Pieralisi wrote:
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
>

The sad reality... But my next version will be still generic. Once that 
one appear to be in good shape then we can add quirks.

Regards,
Tomasz
