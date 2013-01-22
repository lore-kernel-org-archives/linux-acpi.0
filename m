From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] ACPI / PM: Use string "D3cold" to represent ACPI_STATE_D3_COLD
Date: Tue, 22 Jan 2013 13:16:06 +0100
Message-ID: <1491985.dA1TUFB41J@vostro.rjw.lan>
References: <4115893.XLRCUukpRD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4115893.XLRCUukpRD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make acpi_power_state_string() return "D3cold" as the string
representation of ACPI power state D3cold instead of "D3" returned
currently, which is confusing.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -115,7 +115,7 @@ const char *acpi_power_state_string(int
 	case ACPI_STATE_D3_HOT:
 		return "D3hot";
 	case ACPI_STATE_D3_COLD:
-		return "D3";
+		return "D3cold";
 	default:
 		return "(unknown)";
 	}
