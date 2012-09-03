From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 3/5] PCI: hotplug: remove acpi_bus_generate_proc_event
Date: Mon, 03 Sep 2012 02:03:27 +0200
Message-ID: <1346630607.3170.31.camel@offbook>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Rusty Russell <rusty@rustcorp.com.au>, Mauro Carvalho Chehab <mchehab@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Calling this function no longer makes sense as /proc/acpi/event
is being removed.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index c35e8ad..5394fff 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -270,7 +270,6 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
 
 	if (subevent == 0x80) {
 		dbg("%s: generationg bus event\n", __func__);
-		acpi_bus_generate_proc_event(note->device, note->event, detail);
 		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
 						  dev_name(&note->device->dev),
 						  note->event, detail);
-- 
1.7.4.1
