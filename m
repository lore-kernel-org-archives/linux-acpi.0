From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/11] ACPI suspend: Execute _WAK with the right argument
Date: Thu, 14 Feb 2008 02:02:25 -0500
Message-ID: <314ccd644cc14b9ebc1996afbabfb4d108004fd0.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:35667 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755980AbYBNHKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:44 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The _WAK global ACPI control method has to be called with the
argument representing the sleep state being exited.  Make it happen.

Special thanks to Mirco Tischler <mt-ml@gmx.de> for reporting the
problem and debugging.

Reported-by: Mirco Tischler <mt-ml@gmx.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 058d0be..4290e01 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -616,6 +616,7 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
+	arg.integer.value = sleep_state;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
-- 
1.5.4.1.122.gaa8d

