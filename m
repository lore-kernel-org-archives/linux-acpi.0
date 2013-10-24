From: tianyu.lan@intel.com
Subject: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci" default
Date: Thu, 24 Oct 2013 14:49:37 +0800
Message-ID: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, hpa@zytor.com, x86@kernel.org, holt@sgi.com, davej@fedoraproject.org, lenb@kernel.org, rjw@rjwysocki.net, awilliam@redhat.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

Sony Vaio Z1 series require "reboot=pci" for reboot and power off.
This patch is to add them machines to quirk table and set pci reboot
default.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=61721
Reported-and-tested-by: Adam Williamson <awilliam@redhat.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 arch/x86/kernel/reboot.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 7e920bf..083ade7 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -382,6 +382,14 @@ static struct dmi_system_id __initdata reboot_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "C6100"),
 		},
 	},
+	{	/* Handle problems with rebooting on Sony Vaio Z1 series*/
+		.callback = set_pci_reboot,
+		.ident = "Sony Vaio Z1",
+		.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCZ1"),
+		},
+	},
 	{ }
 };
 
-- 
1.7.9.5
