From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 1/5 v2] ACPI: move struct acpi_prt_entry to actbl1.h
Date: Thu, 2 Dec 2010 10:33:27 -0500
Message-ID: <20101202153353.29125.64067.sendpatchset@localhost6.localdomain6>
References: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48185 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab0LBPev (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Dec 2010 10:34:51 -0500
In-Reply-To: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, JBeulich@novell.com, jbarnes@virtuousgeek.org, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, Olaf.Dabrunz@gmx.net

From: Stefan Assmann <sassmann@redhat.com>

Moving struct acpi_prt_entry from drivers/acpi/pci_irq.c to
include/acpi/actbl1.h to make it available outside of pci_irq.c. This will
allow the boot interrupt reroute code, and others, to operate with
acpi_prt_entrys.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
---
 drivers/acpi/pci_irq.c |    8 --------
 include/acpi/actbl1.h  |   10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index f907cfb..3bc2164 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -45,14 +45,6 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_irq");
 
-struct acpi_prt_entry {
-	struct list_head	list;
-	struct acpi_pci_id	id;
-	u8			pin;
-	acpi_handle		link;
-	u32			index;		/* GSI, or link _CRS index */
-};
-
 static LIST_HEAD(acpi_prt_list);
 static DEFINE_SPINLOCK(acpi_prt_lock);
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c637b75..bbc46ed 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -752,6 +752,16 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];
 };
 
+/* _PRT entry */
+
+struct acpi_prt_entry {
+	struct list_head	list;
+	struct acpi_pci_id	id;
+	u8			pin;
+	acpi_handle		link;
+	u32			index;		/* GSI, or link _CRS index */
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
1.7.3.2
