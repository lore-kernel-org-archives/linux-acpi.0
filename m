From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 00/13] Heterogeneuos memory node attributes
Date: Wed, 16 Jan 2019 10:57:51 -0700
Message-ID: <20190116175804.30196-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

The series seems quite calm now. I've received some approvals of the
on the proposal, and heard no objections on the new core interfaces.

Please let me know if there is anyone or group of people I should request
and wait for a review. And if anyone reading this would like additional
time as well before I post a potentially subsequent version, please let
me know.

I also wanted to inquire on upstream strategy if/when all desired
reviews are received. The series is spanning a few subsystems, so I'm
not sure who's tree is the best candidate. I could see an argument for
driver-core, acpi, or mm as possible paths. Please let me know if there's
a more appropriate option or any other gating concerns.

== Changes from v3 ==

  I've fixed the documentation issues that have been raised for v3 

  Moved the hmat files according to Rafael's recommendation

  Added received Reviewed-by's

Otherwise this v4 is much the same as v3.

== Background ==

Platforms may provide multiple types of cpu attached system memory. The
memory ranges for each type may have different characteristics that
applications may wish to know about when considering what node they want
their memory allocated from. 

It had previously been difficult to describe these setups as memory
rangers were generally lumped into the NUMA node of the CPUs. New
platform attributes have been created and in use today that describe
the more complex memory hierarchies that can be created.

This series' objective is to provide the attributes from such systems
that are useful for applications to know about, and readily usable with
existing tools and libraries.

Keith Busch (13):
  acpi: Create subtable parsing infrastructure
  acpi: Add HMAT to generic parsing tables
  acpi/hmat: Parse and report heterogeneous memory
  node: Link memory nodes to their compute nodes
  Documentation/ABI: Add new node sysfs attributes
  acpi/hmat: Register processor domain to its memory
  node: Add heterogenous memory access attributes
  Documentation/ABI: Add node performance attributes
  acpi/hmat: Register performance attributes
  node: Add memory caching attributes
  Documentation/ABI: Add node cache attributes
  acpi/hmat: Register memory side cache attributes
  doc/mm: New documentation for memory performance

 Documentation/ABI/stable/sysfs-devices-node   |  87 +++++-
 Documentation/admin-guide/mm/numaperf.rst     | 184 +++++++++++++
 arch/arm64/kernel/acpi_numa.c                 |   2 +-
 arch/arm64/kernel/smp.c                       |   4 +-
 arch/ia64/kernel/acpi.c                       |  12 +-
 arch/x86/kernel/acpi/boot.c                   |  36 +--
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/hmat/Kconfig                     |   9 +
 drivers/acpi/hmat/Makefile                    |   1 +
 drivers/acpi/hmat/hmat.c                      | 375 ++++++++++++++++++++++++++
 drivers/acpi/numa.c                           |  16 +-
 drivers/acpi/scan.c                           |   4 +-
 drivers/acpi/tables.c                         |  76 +++++-
 drivers/base/Kconfig                          |   8 +
 drivers/base/node.c                           | 317 +++++++++++++++++++++-
 drivers/irqchip/irq-gic-v2m.c                 |   2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +-
 drivers/irqchip/irq-gic-v3-its.c              |   6 +-
 drivers/irqchip/irq-gic-v3.c                  |  10 +-
 drivers/irqchip/irq-gic.c                     |   4 +-
 drivers/mailbox/pcc.c                         |   2 +-
 include/linux/acpi.h                          |   6 +-
 include/linux/node.h                          |  70 ++++-
 25 files changed, 1172 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/numaperf.rst
 create mode 100644 drivers/acpi/hmat/Kconfig
 create mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/acpi/hmat/hmat.c

-- 
2.14.4
