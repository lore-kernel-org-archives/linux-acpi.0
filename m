From: Jayachandran C <jchandra@broadcom.com>
Subject: [RFC PATCH 0/4] ACPI based PCI host driver with generic ECAM
Date: Fri, 18 Mar 2016 01:48:29 +0530
Message-ID: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
References: <CAKc_7PVK3VtaR-LDHNXPr5cSjbCcH--hsepFx=jVATNi=+a9Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKc_7PVK3VtaR-LDHNXPr5cSjbCcH--hsepFx=jVATNi=+a9Hw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, David Daney <ddaney@caviumnetworks.com>, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Catalin Marinas <catalin.marinas@arm.com>, Liviu.Dudau@arm.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Jon Masters <jcm@redhat.com>, msalter@redhat.com, Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org, Jayachandran C <jchandra@broadcom.com>, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

Here is a new patchset for the ACPI PCI controller driver based on the
earlier discussion[1].

The first two patches in the patchset implements pci/ecam.c for generic
config space access and uses it in pci-host-generic.c and related files.

The third patch implements the ACPI PCI host driver using the same ecam
access functions. The fourth patch adds the implementation of raw
operations.

I have not used the pci_mmcfg_list or the region definitions from x86,
but have used a much simpler approach here.

This should apply cleanly on top of the current pci next tree, and
can be reviewed as a patchset.  To use it on ARM64, we need to pull
in about 7 patches more from Tomasz patchset that fixes various
issues (like stub code in arm64 pci.c, ACPI companion setup,
domain number assignment, IO resources fixup etc.).

If you are okay with this approach, I will work with Tomasz and
post the full patchset.

This has been tested on qemu with OVMF for the ACPI part and with
device tree for pci-host-generic code.

Thanks,
JC.

[1] https://lkml.org/lkml/2016/3/3/921

Jayachandran C (4):
  PCI: Provide generic ECAM mapping functions
  PCI: generic,thunder: Use generic config functions
  ACPI: PCI: Add generic PCI host controller
  ACPI: PCI: Add raw_pci_read/write operations

 drivers/acpi/Kconfig                |   9 +
 drivers/acpi/Makefile               |   1 +
 drivers/acpi/pci_gen_host.c         | 334 ++++++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig                 |   3 +
 drivers/pci/Makefile                |   2 +
 drivers/pci/ecam.c                  | 127 ++++++++++++++
 drivers/pci/host/Kconfig            |   1 +
 drivers/pci/host/pci-host-common.c  |  68 ++++----
 drivers/pci/host/pci-host-common.h  |  25 +--
 drivers/pci/host/pci-host-generic.c |  51 +-----
 drivers/pci/host/pci-thunder-ecam.c |  33 +---
 drivers/pci/host/pci-thunder-pem.c  |  41 ++---
 include/linux/pci.h                 |  10 ++
 13 files changed, 560 insertions(+), 145 deletions(-)
 create mode 100644 drivers/acpi/pci_gen_host.c
 create mode 100644 drivers/pci/ecam.c

-- 
1.9.1
