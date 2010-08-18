From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 2/8] ideapad: check VPC bit before sync rfkill hw status
Date: Wed, 18 Aug 2010 16:37:17 +0800
Message-ID: <1282120637-11398-1-git-send-email-ike.pan@canonical.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Check VPC bit to make sure the HW rfkill is touched.

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/ideapad_acpi.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/ideapad_acpi.c b/drivers/platform/x86/ideapad_acpi.c
index af630e2..6176597 100644
--- a/drivers/platform/x86/ideapad_acpi.c
+++ b/drivers/platform/x86/ideapad_acpi.c
@@ -381,7 +381,21 @@ static int ideapad_acpi_remove(struct acpi_device *adevice, int type)
 
 static void ideapad_acpi_notify(struct acpi_device *adevice, u32 event)
 {
-	ideapad_sync_rfk_state(adevice);
+	acpi_handle handle = adevice->handle;
+	unsigned long vpc1, vpc2, vpc_bit;
+
+	if (read_ec_data(handle, 0x10, &vpc1))
+		return;
+	if (read_ec_data(handle, 0x1A, &vpc2))
+		return;
+
+	vpc1 = (vpc2 << 8) | vpc1;
+	for (vpc_bit = 0; vpc_bit < 16; vpc_bit++) {
+		if (test_bit(vpc_bit, &vpc1)) {
+			if (vpc_bit == 9)
+				ideapad_sync_rfk_state(adevice);
+		}
+	}
 }
 
 static struct acpi_driver ideapad_acpi_driver = {
-- 
1.7.0.4
