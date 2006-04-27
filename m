From: akpm@osdl.org
Subject: [patch 16/16] acpi: suppress power button event on S3 resume
Date: Thu, 27 Apr 2006 02:25:16 -0700
Message-ID: <200604270926.k3R9QiaN025117@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbWD0J0t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, apatard@mandriva.com, luming.yu@intel.com


From: "Arnaud Patard" <apatard@mandriva.com>

Suppress POWER_BUTTON event on S3 resume.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
Acked-by: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/sleep/main.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN drivers/acpi/sleep/main.c~acpi-suppress-power-button-event-on-s3-resume drivers/acpi/sleep/main.c
--- 25/drivers/acpi/sleep/main.c~acpi-suppress-power-button-event-on-s3-resume	Wed Apr 26 14:15:19 2006
+++ 25-akpm/drivers/acpi/sleep/main.c	Wed Apr 26 14:15:19 2006
@@ -105,6 +105,14 @@ static int acpi_pm_enter(suspend_state_t
 	default:
 		return -EINVAL;
 	}
+
+	/* ACPI 3.0 specs (P62) says that it's the responsabilty
+	 * of the OSPM to clear the status bit [ implying that the
+	 * POWER_BUTTON event should not reach userspace ]
+	 */
+	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
+		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
_
