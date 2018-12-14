From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI is
 not set
Date: Fri, 14 Dec 2018 23:33:33 +0000
Message-ID: <c4c4151c-131b-9a97-257a-c4ffb2589b61@arm.com>
References: <20181214163319.27479-1-okaya@kernel.org>
 <20181214163319.27479-7-okaya@kernel.org> <20181214222601.GH20725@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214222601.GH20725@google.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Logan Gunthorpe <logang@deltatee.com>
List-Id: linux-acpi@vger.kernel.org

On 2018-12-14 10:26 pm, Bjorn Helgaas wrote:
> [+cc Lorenzo, Robin, Logan]
> 
> On Fri, Dec 14, 2018 at 04:33:19PM +0000, Sinan Kaya wrote:
>> ACPI IORT table code relies on pci_request_acs() to be present. Define
>> a stub function when CONFI_PCI is not set.
> 
> This doesn't seem like the simplest approach to me, but I probably
> don't understand what's going on in IORT.
> 
> It looks like *all* of iort_enable_acs() (the caller of
> pci_request_acs()) is PCI-specific; at least, the whole thing is
> wrapped in a test for ACPI_IORT_NODE_PCI_ROOT_COMPLEX.  So the whole
> function could be wrapped in #ifdef CONFIG_PCI.
> 
> Here's the caller of iort_enable_acs():
> 
>    iort_init_platform_devices
>      acs_enabled = false
>      for (i = 0; i < iort->node_count; i++) {
>        if (!acs_enabled)
>          acs_enabled = iort_enable_acs(iort_node);
> 
> It seems like the acs_enabled state could be encapsulated inside
> iort_enable_acs().

It could, but with the tiny disadvantage of having to allocate static 
storage for it to maintain the "don't bother checking if we want ACS if 
we've already requested it once" logic for multiple root complexes.

> Today pci_request_acs() is a system-wide thing, but I don't know why
> that's the case.  Isn't it conceivable that different PCI hierarchies
> could have different ACS policies, e.g., because of P2P DMA or
> something?

I can certainly imagine systems using entirely separate PCI domains for, 
say, expansion slots vs. on-board/on-chip devices, where the former may 
be expected to be assigned to VMs or userspace drivers and the latter 
only ever controlled by the host kernel. Not forcing ACS overhead upon 
the "non-virtualisable" (or "trusted" vs. "untrusted") domain could 
perhaps be beneficial in some cases.

> Bottom line, pci_request_acs() is being called from what looks like
> PCI-specific code in IORT, and it would make more sense to me to prune
> out that code in IORT than to make a stub pci_request_acs().

Agreed - without CONFIG_PCI the whole of iort_enable_acs() may as well 
be stubbed out, because it won't achieve anything anyway. The 
implication is that if we have a root complex whose inbound DMA is 
controlled by an SMMU, we should enable ACS to make VFIO useful (or in 
case we want to enforce strict DMA isolation in general), but if Linux 
is never going to touch any PCI devices there's no point even looking at 
the RC node(s). TBH I'm pretty dubious about having IORT at all without 
PCI, but I suppose there could potentially be embedded SoCs which have 
an ITS and platform MSIs, or use an SMMU for their video/display 
subsystem, and for some reason demand ACPI-based firmware.

Robin.

>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   include/linux/pci.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 51a5a5217667..f0f2f55ea93c 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>>   	return NULL;
>>   }
>>   
>> +#ifdef CONFIG_PCI
>>   void pci_request_acs(void);
>> +#else
>> +static inline void pci_request_acs(void) {}
>> +#endif
>>   bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>>   bool pci_acs_path_enabled(struct pci_dev *start,
>>   			  struct pci_dev *end, u16 acs_flags);
>> -- 
>> 2.19.0
>>
