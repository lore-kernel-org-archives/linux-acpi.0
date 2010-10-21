From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Thu, 21 Oct 2010 14:23:43 -0600
Message-ID: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:43592 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab0JUUXp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2010 16:23:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, ying.huang@intel.com

ACPI's system event related IRQ handing accesses specific fixed
hardware registers; namely PM1a event, PM1b event, GPE0, and GPE1
which are declared in the FADT.  If these registers are backed by
MMIO, as opposed to I/O port space, accessing them within interrupt
context will incur a panic since acpi_read() and acpi_write() end up
calling ioremap(), which may block to allocate memory - BZ 18012.

This patch series creates a list for maintaining ACPI MMIO remappings
and augments the corresponding mapping and unmapping interface
routines (acpi_os_map_memory() and acpi_os_unmap_memory()) to
dynamically add to, and delete from, the list as necessary.  In
addition to the list, interfaces for mapping and unmapping ACPI
registers, that are backed by MMIO, are added.  Together, they enable
accesses of such registers from within interrupt context.

Huang Ying introduced similar functionality specific to ACPI Platform
Error Interfaces in commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262.
Much of this series re-factors Ying's commit - patches 5/7 and
6/7 [*] are practically verbatim copies - providing equivalent
functionality but in a more generalized manner allowing usage in
non-specific contexts.


[*]  The page based coalescing optimization of patch 6/7 is definitely
insightful but I question if the additional complexity, and potential
maintenance, outweigh its value.  I would be interested in others
opinions on this.

There is a behavioral difference that the optimization introduces
although I do not believe it matters in this instance:
  Consider two ioremap() requests occurring that specify the same
  physical address.  Prior to this optimization, two separate ioremap()
  requests would occur and two distinct virtual addresses would be
  returned (multiple calls to ioremap() with the same physical address
  do not return the same virtual address).  With the optimization in
  place, the two ioremap() requests will end up returning the same
  virtual address.


Reference: https://bugzilla.kernel.org/show_bug.cgi?id=18012


---

Myron Stowe (7):
      ACPI: Fix ioremap size for MMIO reads and writes
      ACPI: Maintain a list of ACPI memory mapped I/O remappings
      ACPI: Add interfaces for ioremapping/iounmapping ACPI registers
      ACPI: Pre-map 'system event' related register blocks
      ACPI: Convert simple locking to RCU based locking
      ACPI: Page based coalescing of I/O remappings optimization
      ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]


 drivers/acpi/Makefile         |    1 
 drivers/acpi/apei/apei-base.c |   11 +
 drivers/acpi/apei/ghes.c      |    9 -
 drivers/acpi/atomicio.c       |  361 -----------------------------------------
 drivers/acpi/osl.c            |  276 ++++++++++++++++++++++++++-----
 include/acpi/atomicio.h       |   10 -
 include/linux/acpi.h          |    3 
 7 files changed, 242 insertions(+), 429 deletions(-)
 delete mode 100644 drivers/acpi/atomicio.c
 delete mode 100644 include/acpi/atomicio.h

