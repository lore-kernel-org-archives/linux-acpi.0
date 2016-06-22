From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/2] acpi: pmic: intel: initialize result to 0
Date: Wed, 22 Jun 2016 17:55:40 +0300
Message-ID: <1466607340-88687-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Bin Gao <bin.gao@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Felipe Balbi <felipe.balbi@linux.intel.com>

Fixes compiler warning.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 3a3d416..1742718 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -215,7 +215,7 @@ static acpi_status intel_pmic_regs_handler(u32 function,
 		void *handler_context, void *region_context)
 {
 	struct intel_pmic_opregion *opregion = region_context;
-	int result;
+	int result = 0;
 
 	switch (address) {
 	case 0:
-- 
2.8.1
