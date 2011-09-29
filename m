From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 1/2] ACPI: Export interfaces for ioremapping/iounmapping ACPI
	registers
Date: Thu, 29 Sep 2011 15:59:14 -0600
Message-ID: <20110929215913.21126.71203.stgit@amt.stowe>
References: <20110929215907.21126.24480.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64743 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab1I2V7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Sep 2011 17:59:39 -0400
In-Reply-To: <20110929215907.21126.24480.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com, bhelgaas@google.com

From: Myron Stowe <mstowe@redhat.com>

Export remapping and unmapping interfaces - acpi_os_map_generic_address()
and acpi_os_unmap_generic_address() - for ACPI generic registers
that are backed by memory mapped I/O (MMIO).

ACPI Generic Address Structure (GAS) reference (ACPI's fixed/generic
hardware registers use the GAS format):
  ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
  Structure"

Signed_off_by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/acpi/osl.c      |    6 ++++--
 include/linux/acpi_io.h |    3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index fa32f58..46c5c18 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -426,7 +426,7 @@ void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		__acpi_unmap_table(virt, size);
 }
 
-static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
+int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
 
@@ -442,8 +442,9 @@ static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_os_map_generic_address);
 
-static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
+void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	struct acpi_ioremap *map;
 
@@ -464,6 +465,7 @@ static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 
 	acpi_os_map_cleanup(map);
 }
+EXPORT_SYMBOL_GPL(acpi_os_unmap_generic_address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
diff --git a/include/linux/acpi_io.h b/include/linux/acpi_io.h
index 4afd710..b0ffa21 100644
--- a/include/linux/acpi_io.h
+++ b/include/linux/acpi_io.h
@@ -12,4 +12,7 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
 
+int acpi_os_map_generic_address(struct acpi_generic_address *addr);
+void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
+
 #endif

