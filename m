From: Len Brown <len.brown@intel.com>
Subject: [PATCH 38/65] ACPICA: Fix trace output name and whitespace
Date: Fri, 24 Nov 2006 02:18:48 -0500
Message-ID: <11643527992802-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934483AbWKXHQF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:05 -0500
In-Reply-To: <11643527993578-git-send-email-len.brown@intel.com>
Message-Id: <73b9e5384bfbd85f9b28ac667d1f26e6a40bae1d.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exutils.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 72adcf4..e32d489 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -88,7 +88,7 @@ void acpi_ex_enter_interpreter(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
+	ACPI_FUNCTION_TRACE(ex_enter_interpreter);
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
@@ -116,7 +116,6 @@ void acpi_ex_enter_interpreter(void)
 
 void acpi_ex_reacquire_interpreter(void)
 {
-
 	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
 
 	/*
@@ -185,7 +184,6 @@ void acpi_ex_exit_interpreter(void)
 
 void acpi_ex_relinquish_interpreter(void)
 {
-
 	ACPI_FUNCTION_TRACE(ex_relinquish_interpreter);
 
 	/*
-- 
1.4.4.1
