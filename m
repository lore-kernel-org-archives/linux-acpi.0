From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 1/7] ACPI: Fix ioremap size for MMIO reads and writes
Date: Thu, 21 Oct 2010 14:23:48 -0600
Message-ID: <20101021202348.9220.57786.stgit@bob.kio>
References: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:43625 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab0JUUXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2010 16:23:49 -0400
In-Reply-To: <20101021201916.9220.5711.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, ying.huang@intel.com

The size used for I/O remapping MMIO read and write accesses has not
accounted for the basis of ACPI's Generic Address Structure (GAS)
'Register Bit Width' field which is bits, not bytes.  This patch
adjusts the ioremap() 'size' argument accordingly.

ACPI "Generic Register" reference:
  ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
  Structure".


Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/acpi/osl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 65b25a3..58842fb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -496,7 +496,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 	u32 dummy;
 	void __iomem *virt_addr;
 
-	virt_addr = ioremap(phys_addr, width);
+	virt_addr = ioremap(phys_addr, width / 8);
 	if (!value)
 		value = &dummy;
 
@@ -524,7 +524,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
 
-	virt_addr = ioremap(phys_addr, width);
+	virt_addr = ioremap(phys_addr, width / 8);
 
 	switch (width) {
 	case 8:

