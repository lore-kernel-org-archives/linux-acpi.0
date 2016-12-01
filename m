From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Date: Thu, 1 Dec 2016 09:49:51 +0100
Message-ID: <eba92ea8-bdab-9a3a-7b18-caaeac15db5d@semihalf.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, liudongdong3@huawei.com, msalter@redhat.com, arnd@arndb.de, jcm@redhat.com, Christopher Covington <cov@codeaurora.org>, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, ard.biesheuvel@linaro.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

On 01.12.2016 01:28, Bjorn Helgaas wrote:
> Hi Tomasz,
>
> On Tue, Nov 15, 2016 at 10:14:57AM +0100, Tomasz Nowicki wrote:
>> ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
>> compliant with ECAM standard. It uses non-standard configuration space
>> accessors (see pci_thunder_pem_ops) and custom configuration space granulation
>> (see bus_shift = 24). In order to access configuration space and
>> probe PEM as ACPI based PCI host controller we need to add MCFG quirk
>> infrastructure. This involves:
>> 1. thunder_pem_init() ACPI extension so that we can probe PEM-specific
>>    register ranges analogously to DT
>> 2. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
>>    code.
>> 3. New quirk entries for each PEM segment. Each contains platform IDs,
>>    mentioned pci_thunder_pem_ops and CFG resources.
>>
>> Quirk is considered for ThunderX silicon pass2.x only which is identified
>> via MCFG revision 1.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>  drivers/acpi/pci_mcfg.c            |  20 +++++++
>>  drivers/pci/host/pci-thunder-pem.c | 107 ++++++++++++++++++++++++++++++++-----
>>  include/linux/pci-ecam.h           |   4 ++
>>  3 files changed, 117 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index ac21db3..e4e2b9b 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -57,6 +57,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
>>  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
>>  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
>> +#ifdef CONFIG_PCI_HOST_THUNDER_PEM
>> +#define THUNDER_MCFG_RES(addr, node) \
>> +	DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
>> +#define THUNDER_MCFG_QUIRK(rev, node) \
>> +	{ "CAVIUM", "THUNDERX", rev, 4 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88001f000000UL, node) }, \
>> +	{ "CAVIUM", "THUNDERX", rev, 5 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x884057000000UL, node) }, \
>> +	{ "CAVIUM", "THUNDERX", rev, 6 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88808f000000UL, node) }, \
>> +	{ "CAVIUM", "THUNDERX", rev, 7 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89001f000000UL, node) }, \
>> +	{ "CAVIUM", "THUNDERX", rev, 8 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x894057000000UL, node) }, \
>> +	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * node), MCFG_BUS_ANY, \
>> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89808f000000UL, node) }
>> +	/* SoC pass2.x */
>> +	THUNDER_MCFG_QUIRK(1, 0UL),
>> +	THUNDER_MCFG_QUIRK(1, 1UL),
>> +#endif
>
> I want all these quirks to work without having to enable
> device-specific config options like CONFIG_PCI_HOST_THUNDER_PEM.
>
> I tweaked the preceding MCFG quirk support to wrap it in
> CONFIG_PCI_QUIRKS.  I also tweaked the qualcomm and hisi patches to
> move the meat of them to pci/quirks.c.  My work-in-progress is on
> pci/ecam, but I can't easily build for arm64, so there are likely some
> issues to be resolved.

Please see compilation fix patch in [1] for your series.

>
> I'm hoping to end up with something like this:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469
>
> The problem with ThunderX is that the config accessors are much bigger
> and I don't really want to duplicate them in both pci/quirks.c and
> pci-thunder-pem.c.
>
> Actually, that raises a question for qualcomm and hisi: in the DT
> model, we use non-ECAM config accessors in the driver, but in the ACPI
> model, we use ECAM accessors.  It seems like the accessors should be
> the same regardless of whether we discover the bridge via DT or ACPI.
>
> Anyway, it's almost like we want to build pci-thunder-pem.o if
> CONFIG_PCI_HOST_THUNDER_PEM || (CONFIG_PCI_QUIRKS && CONFIG_ARM64).
> I don't know how to express that nicely.
>
> I was trying to avoid adding an ecam-quirks.c, but maybe we need to
> add it and collect all the different accessors there and add #ifdefs
> inside.
>
> Sorry, this is only half-baked, but I just wanted to throw this out in
> case you have any ideas.

I agree that pci-thunder-pem.c and pci-thunder-ecam.c are too big to be 
duplicated. The same for new ecam-quirks.c container. So treating this 
as a necessary evil how about:

  config PCI_HOST_THUNDER_PEM
  	bool "Cavium Thunder PCIe controller to off-chip devices"
-	depends on OF && ARM64
+	depends on ARM64
+	depends on OF || (ACPI && PCI_QUIRKS)
  	select PCI_HOST_COMMON

Moreover, IMO we should select PCI_QUIRKS for ARM64 && ACPI by default. 
Then it becomes:
  config PCI_HOST_THUNDER_PEM
  	bool "Cavium Thunder PCIe controller to off-chip devices"
-	depends on OF && ARM64
+	depends on ARM64
+	depends on OF || ACPI
  	select PCI_HOST_COMMON

I put the picture together here (on top of your pci/ecam branch):
[1] 
https://github.com/semihalf-nowicki-tomasz/linux/commits/pci-quirks-thunderx-v2

Thanks,
Tomasz
