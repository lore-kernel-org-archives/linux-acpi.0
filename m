From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 4/6] ACPI: Fix power resource's device power state when it's off
Date: Tue, 17 Apr 2012 13:47:54 +0800
Message-ID: <1334641676-14566-5-git-send-email-ming.m.lin@intel.com>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.og>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>
List-Id: linux-acpi@vger.kernel.org

Power resource's device power state should be
ACPI_STATE_D3_COLD when it's off.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/power.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 27a2bad..d6065110 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -300,7 +300,7 @@ static int acpi_power_off(acpi_handle handle)
 		result = -ENODEV;
 	} else {
 		/* Update the power resource's _device_ power state */
-		resource->device->power.state = ACPI_STATE_D3;
+		resource->device->power.state = ACPI_STATE_D3_COLD;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Power resource [%s] turned off\n",
@@ -735,7 +735,7 @@ static int acpi_power_add(struct acpi_device *device)
 		device->power.state = ACPI_STATE_D0;
 		break;
 	case ACPI_POWER_RESOURCE_STATE_OFF:
-		device->power.state = ACPI_STATE_D3;
+		device->power.state = ACPI_STATE_D3_COLD;
 		break;
 	default:
 		device->power.state = ACPI_STATE_UNKNOWN;
-- 
1.7.2.5
