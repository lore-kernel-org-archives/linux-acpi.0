From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: disabling "rfkill hotplug" on newer eeepc-laptop models
Date: Sat, 20 Feb 2010 12:50:53 +0000
Message-ID: <4B7FDAAD.1040704@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Matthew,

We've just had the third report of a newer eeepc-laptop model which 
needs to have the wireless hotplug code disabled.  So I expect there 
are/will be more such models, and many more puzzled users :).

I seem to remember you mentioning two possibilities

1. checking PCI config space, to see whether the device is really absent 
before we mark it as unplugged.
2. a generic mechanism which would replace the current eeepc-specific code.


I think we should try to implement the former (or equivalent) asap.  Is 
there a generic mechanism yet?  If not, I have some eeepc-specific code 
ready for testing on afflicted models -

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 6a47bb7..9a844ca 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -578,6 +578,8 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc)
 	struct pci_dev *dev;
 	struct pci_bus *bus;
 	bool blocked = eeepc_wlan_rfkill_blocked(eeepc);
+	bool absent;
+	u32 l;
 
 	if (eeepc->wlan_rfkill)
 		rfkill_set_sw_state(eeepc->wlan_rfkill, blocked);
@@ -591,6 +593,22 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc)
 			goto out_unlock;
 		}
 
+		if (pci_bus_read_config_dword(bus, 0, PCI_VENDOR_ID, &l)) {
+			pr_err("Unable to read PCI config space?\n");
+			goto out_unlock;
+		}
+		absent = (l == 0xffffffff);
+
+		if (blocked != absent) {
+			pr_warning("BIOS says wireless lan is %s, "
+					"but the pci device is %s\n",
+				blocked ? "blocked" : "unblocked",
+				absent ? "absent" : "present");
+			pr_warning("skipped wireless hotplug as probably "
+					"inappropriate for this model\n");
+			goto out_unlock;
+		}
+
 		if (!blocked) {
 			dev = pci_get_slot(bus, 0);
 			if (dev) {
