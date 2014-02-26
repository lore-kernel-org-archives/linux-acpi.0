From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: [PATCH] ACPI/Sleep: pm_power_off need more sanity check to be installed
Date: Wed, 26 Feb 2014 10:46:37 +0800
Message-ID: <530D558D.6090607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5619 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaBZCqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:46:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len.Brown@intel.com, rjw@rjwysocki.net, "alan@linux.intel.com" <alan@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>

Sleep control and status registers need santity check before ACPI
install acpi_power_off to pm_power_off hook. The checking code in
acpi_enter_sleep_state() is too late, we should not allow a not-working
pm_power_off function hooked.

Signed-off-by: Aubrey Li <aubrey.li@intel.com>
---
 drivers/acpi/sleep.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index b718806..0284d22 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -809,8 +809,11 @@ int __init acpi_sleep_init(void)
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
 		sleep_states[ACPI_STATE_S5] = 1;
-		pm_power_off_prepare = acpi_power_off_prepare;
-		pm_power_off = acpi_power_off;
+		if (acpi_gbl_FADT.sleep_control.address &&
+			acpi_gbl_FADT.sleep_status.address) {
+			pm_power_off_prepare = acpi_power_off_prepare;
+			pm_power_off = acpi_power_off;
+		}
 	}

 	supported[0] = 0;
-- 
1.7.10.4
