From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] ACPI / hotplug / PCI: Always return success after adding a function
Date: Mon, 08 Jul 2013 15:28:35 +0200
Message-ID: <1502675.WMZKWG2iox@vostro.rjw.lan>
References: <1468174.eo7i60DZFT@vostro.rjw.lan> <5361579.8un1t1TCfk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5361579.8un1t1TCfk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When a new ACPIPHP function is added by register_slot() and the
notify handler cannot be installed for it, register_slot() returns an
error status without cleaning up, which causes the entire namespace
walk in acpiphp_enumerate_slots() to be aborted, although it still
may be possible to successfully install the function notify handler
for other device objects under the given brigde.

To address this issue make register_slot() return success after
a new function has been added, even if the addition of the notify
handler for it has failed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -335,10 +335,9 @@ register_slot(acpi_handle handle, u32 lv
 
 		if (ACPI_FAILURE(status))
 			err("failed to register interrupt notify handler\n");
-	} else
-		status = AE_OK;
+	}
 
-	return status;
+	return AE_OK;
 
  err_exit:
 	bridge->nr_slots--;
