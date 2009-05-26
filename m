From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] PCI/ACPI: fix wrong ref count handling in acpi_pci_bind()
Date: Tue, 26 May 2009 09:08:03 +0900
Message-ID: <4A1B32E3.7060801@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41769 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbZEZAIU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2009 20:08:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alex Chiang <achiang@hp.com>, linux acpi <linux-acpi@vger.kernel.org>

Fix wrong struct pci_dev reference counter handling in acpi_pci_bind().

The 'dev' field of struct acpi_pci_data is having a pointer to struct
pci_dev without incrementing the reference counter. Because of this, I
got the following kernel oops when I was doing some pci hotplug
operations. This patch fixes this bug by replacing wrong hand-made
pci_find_slot() with pci_get_slot() in acpi_pci_bind().

[  206.427004] BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
[  206.427076] IP: [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd
[  206.427076] PGD 8225ad067 PUD 82258b067 PMD 0
[  206.427076] Oops: 0000 [#1] SMP
[  206.427076] last sysfs file: /sys/bus/pci/slots/1/power
[  206.427076] CPU 2
[  206.427076] Modules linked in: acpiphp ipv6 autofs4 hidp rfcomm l2cap bluetooth sunrpc dm_mirror dm_region_hash dm_log dm_multipath scsi_dh dm_mod sbs sbshc pci_slot battery ac parport_pc lp parport sg mptspi mptscsih mptbase scsi_transport_spi sr_mod cdrom e1000e serio_raw button i2c_i801 i2c_core shpchp pcspkr ata_piix libata megaraid_sas sd_mod scsi_mod crc_t10dif ext3 jbd uhci_hcd ohci_hcd ehci_hcd [last unloaded: microcode]
[  206.427076] Pid: 10367, comm: bash Not tainted 2.6.30-rc4-kk #10 PRIMERGY
[  206.427076] RIP: 0010:[<ffffffff803f0e9b>]  [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd
[  206.427076] RSP: 0018:ffff8808225a9d68  EFLAGS: 00010206
[  206.427076] RAX: 0000000000000000 RBX: ffff88083c547800 RCX: 0000000000000006
[  206.427076] RDX: ffff88083ce36ca0 RSI: ffff880822508768 RDI: 0000000000000000
[  206.427076] RBP: ffff8808225a9d98 R08: 0000000000000000 R09: 0000000000000000
[  206.427076] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[  206.427076] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8808225a9e28
[  206.427076] FS:  00007f376c4ee6e0(0000) GS:ffff880054636000(0000) knlGS:0000000000000000
[  206.427076] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  206.427076] CR2: 00000000000000e8 CR3: 0000000822590000 CR4: 00000000000006e0
[  206.427076] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  206.427076] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  206.427076] Process bash (pid: 10367, threadinfo ffff8808225a8000, task ffff880822508000)
[  206.427076] Stack:
[  206.427076]  000000000000001f ffff88083addd5a0 ffff8808225a9d98 ffff88083ce36ca0
[  206.427076]  ffff88083c547800 ffff88083c547800 ffff8808225a9db8 ffffffff803ecee4
[  206.427076]  ffff88083c547800 ffff88083c547000 ffff8808225a9e08 ffffffff803ecf6d
[  206.427076] Call Trace:
[  206.427076]  [<ffffffff803ecee4>] acpi_bus_remove+0x54/0x68
[  206.427076]  [<ffffffff803ecf6d>] acpi_bus_trim+0x75/0xe3
[  206.427076]  [<ffffffffa0345ddd>] acpiphp_disable_slot+0x16d/0x1e0 [acpiphp]
[  206.427076]  [<ffffffffa03441f0>] disable_slot+0x20/0x60 [acpiphp]
[  206.427076]  [<ffffffff803cfc18>] power_write_file+0xc8/0x110
[  206.427076]  [<ffffffff803c6a54>] pci_slot_attr_store+0x24/0x30
[  206.427076]  [<ffffffff803469ce>] sysfs_write_file+0xce/0x140
[  206.427076]  [<ffffffff802e94e7>] vfs_write+0xc7/0x170
[  206.427076]  [<ffffffff802e9aa0>] sys_write+0x50/0x90
[  206.427076]  [<ffffffff8020bd6b>] system_call_fastpath+0x16/0x1b
[  206.427076] Code: be 2b 01 00 00 48 c7 c7 d0 c6 5a 80 31 c0 e8 c3 8f 01 00 eb 36 48 8b 55 e8 48 8b 42 10 48 83 78 18 00 74 13 48 8b 42 08 0f b7 3a <0f> b6 b0 e8 00 00 00 e8 ab f8 ff ff 48 8b 7d e8 e8 30 cf ee ff
[  206.427076] RIP  [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd
[  206.427076]  RSP <ffff8808225a9d68>
[  206.427076] CR2: 00000000000000e8
[  206.440158] ---[ end trace 1ca3974fa717e665 ]---

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/acpi/pci_bind.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

Index: 20090521/drivers/acpi/pci_bind.c
===================================================================
--- 20090521.orig/drivers/acpi/pci_bind.c
+++ 20090521/drivers/acpi/pci_bind.c
@@ -116,9 +116,6 @@ int acpi_pci_bind(struct acpi_device *de
 	struct acpi_pci_data *pdata;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	acpi_handle handle;
-	struct pci_dev *dev;
-	struct pci_bus *bus;
-
 
 	if (!device || !device->parent)
 		return -EINVAL;
@@ -180,16 +177,8 @@ int acpi_pci_bind(struct acpi_device *de
 	 * PCI devices are added to the global pci list when the root
 	 * bridge start ops are run, which may not have happened yet.
 	 */
-	bus = pci_find_bus(data->id.segment, data->id.bus);
-	if (bus) {
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->devfn == PCI_DEVFN(data->id.device,
-						    data->id.function)) {
-				data->dev = dev;
-				break;
-			}
-		}
-	}
+	data->dev = pci_get_slot(pdata->bus,
+				PCI_DEVFN(data->id.device, data->id.function));
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",
@@ -259,9 +248,10 @@ int acpi_pci_bind(struct acpi_device *de
 
       end:
 	kfree(buffer.pointer);
-	if (result)
+	if (result) {
+		pci_dev_put(data->dev);
 		kfree(data);
-
+	}
 	return result;
 }
 
@@ -303,6 +293,7 @@ static int acpi_pci_unbind(struct acpi_d
 	if (data->dev->subordinate) {
 		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
 	}
+	pci_dev_put(data->dev);
 	kfree(data);
 
       end:

