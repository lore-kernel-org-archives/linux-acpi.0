From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ACPI / extlog: avoid null pointer dereference
Date: Tue,  7 Jun 2016 22:11:23 +0200
Message-ID: <1465330283-9671-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gong.chen@linux.intel.com
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: linux-acpi@vger.kernel.org

extlog_l1_addr was checked after assigning flags attribute.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/acpi/acpi_extlog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index b3842ff..183b7b2 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -309,9 +309,10 @@ static void __exit extlog_exit(void)
 {
 	set_edac_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
 	if (elog_addr)
 		acpi_os_unmap_iomem(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
-- 
2.1.4
