From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
Date: Sat, 23 Jan 2016 00:06:02 +0100
Message-ID: <20160122230602.GB24726@rric.localdomain>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1453209083-3358-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: lorenzo.pieralisi@arm.com, ddaney.cavm@gmail.com, jason@lakedaemon.net, graeme.gregory@linaro.org, marc.zyngier@arm.com, Catalin.Marinas@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, guohanjun@huawei.com, shijie.huang@arm.com, tglx@linutronix.de, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 19.01.16 14:11:13, Tomasz Nowicki wrote:
> Patches base on Suravee's ACPI GICv2m support:
> https://lkml.org/lkml/2015/12/10/475
> 
> The following git branch contains submitted patches along with
> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
> https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)
> 
> Series has been tested on Cavium ThunderX server.
> 
> v2 -> v3
> - rebased on top of 4.4
> - fixes and improvements for redistributor init via GICC structures
> - fixes as per kbuild reports
> 
> v1 -> v2
> - rebased on top of 4.4-rc4
> - use pci_msi_domain_get_msi_rid for requester ID to device ID translation
> 
> Hanjun Guo (1):
>   irqchip / GICv3: remove gic root node in ITS
> 
> Tomasz Nowicki (9):
>   irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
>   irqchip / GICv3: Add ACPI support for GICv3+ initialization
>   irqchip,GICv3,ACPI: Add redistributor support via GICC structures.
>   irqchip, gicv3, its: Mark its_init() and its children as __init
>   irqchip, GICv3, ITS: Refator ITS dt init code to prepare for ACPI.
>   ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
>   irqchip, gicv3, its: Probe ITS in the ACPI way.
>   acpi, gicv3, msi: Factor out code that might be reused for ACPI
>     equivalent.
>   acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
>     initialization.
> 
>  drivers/acpi/Kconfig                     |   3 +
>  drivers/acpi/Makefile                    |   1 +
>  drivers/acpi/iort.c                      | 326 +++++++++++++++++++++++++++++
>  drivers/irqchip/Kconfig                  |   1 +
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c |  85 ++++++--
>  drivers/irqchip/irq-gic-v3-its.c         | 143 +++++++++----
>  drivers/irqchip/irq-gic-v3.c             | 344 ++++++++++++++++++++++++++-----
>  drivers/pci/msi.c                        |   3 +
>  include/linux/iort.h                     |  38 ++++
>  include/linux/irqchip/arm-gic-v3.h       |   2 +-
>  10 files changed, 845 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/acpi/iort.c
>  create mode 100644 include/linux/iort.h

Tested on various ThunderX single and dual node systems.

Tested-by: Robert Richter <rrichter@cavium.com>

Thanks Tomasz,

-Robert
