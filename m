From: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date: Wed, 14 Nov 2018 15:49:02 -0700
Message-ID: <20181114224902.12082-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

This series provides a new sysfs representation for heterogeneous
system memory.

The previous series that was specific to HMAT that this series was based
on was last posted here: https://lkml.org/lkml/2017/12/13/968

Platforms may provide multiple types of cpu attached system memory. The
memory ranges for each type may have different characteristics that
applications may wish to know about when considering what node they want
their memory allocated from. 

It had previously been difficult to describe these setups as memory
rangers were generally lumped into the NUMA node of the CPUs. New
platform attributes have been created and in use today that describe
the more complex memory hierarchies that can be created.

This series first creates new generic APIs under the kernel's node
representation. These new APIs can be used to create links among local
memory and compute nodes and export characteristics about the memory
nodes. Documentation desribing the new representation are provided.

Finally the series adds a kernel user for these new APIs from parsing
the ACPI HMAT.

Keith Busch (7):
  node: Link memory nodes to their compute nodes
  node: Add heterogenous memory performance
  doc/vm: New documentation for memory performance
  node: Add memory caching attributes
  doc/vm: New documentation for memory cache
  acpi: Create subtable parsing infrastructure
  acpi/hmat: Parse and report heterogeneous memory

 Documentation/vm/numacache.rst |  76 ++++++++
 Documentation/vm/numaperf.rst  |  71 ++++++++
 drivers/acpi/Kconfig           |   9 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/hmat.c            | 384 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c          |  85 +++++++--
 drivers/base/Kconfig           |   8 +
 drivers/base/node.c            | 193 +++++++++++++++++++++
 include/linux/node.h           |  47 +++++
 9 files changed, 864 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/vm/numacache.rst
 create mode 100644 Documentation/vm/numaperf.rst
 create mode 100644 drivers/acpi/hmat.c

-- 
2.14.4
