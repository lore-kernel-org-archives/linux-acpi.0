From: al.stone@linaro.org
Subject: [PATCH v4 5/5] ACPI: do not map/unmap memory regions for FADT entries
 in reduced HW mode
Date: Mon, 16 Dec 2013 17:16:41 -0700
Message-ID: <1387239401-13918-6-git-send-email-al.stone@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Al Stone <al.stone@linaro.org>, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

From: Al Stone <al.stone@linaro.org>

Several of the FADT fields are normally kept in specific memory
regions.  Since these fields are to be ignored in hardware reduced
ACPI mode, do not map those addresses when in that mode, and of
course do not release the mappings that have not been made.

The function acpi_os_initialize() could become a stub in the header
file but is left here in case it can be of further use.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/osl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c946a3a..7822821 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1778,10 +1778,12 @@ __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
 
 acpi_status __init acpi_os_initialize(void)
 {
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+	if (!acpi_gbl_reduced_hardware) {
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+	}
 
 	return AE_OK;
 }
@@ -1806,10 +1808,12 @@ acpi_status acpi_os_terminate(void)
 						 acpi_irq_handler);
 	}
 
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	if (!acpi_gbl_reduced_hardware) {
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	}
 
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
-- 
1.8.3.1
