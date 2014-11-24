From: Huang Rui <ray.huang@amd.com>
Subject: [PATCH] ACPI: Fixed a typo comment
Date: Mon, 24 Nov 2014 19:56:38 +0800
Message-ID: <1416830198-2414-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/device_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 7db1931..076af81 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -201,7 +201,7 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 	 * Transition Power
 	 * ----------------
 	 * In accordance with the ACPI specification first apply power (via
-	 * power resources) and then evalute _PSx.
+	 * power resources) and then evaluate _PSx.
 	 */
 	if (device->power.flags.power_resources) {
 		result = acpi_power_transition(device, state);
-- 
1.7.9.6
