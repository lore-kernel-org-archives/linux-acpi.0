From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 2/2] ACPI processor: remove superfluous warning message
Date: Mon, 17 Aug 2009 14:45:39 +0200
Message-ID: <200908171445.40785.elendil@planet.nl>
References: <200908171443.35622.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:55393 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750926AbZHQMpk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Aug 2009 08:45:40 -0400
In-Reply-To: <200908171443.35622.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, lenb@intel.com, rui.zhang@intel.com

This failure is very common on many platforms.
Handling it in the ACPI processor driver is enough, and we don't
need a warning message unless CONFIG_ACPI_DEBUG is set.

Based on a patch from Zhang Rui.

http://bugzilla.kernel.org/show_bug.cgi?id=13389

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Zhang Rui <rui.zhang@intel.com>

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 841be4e..ae39797 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -840,8 +840,8 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		if (state == -1) {
-			ACPI_WARNING((AE_INFO,
-				"Invalid throttling state, reset"));
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Invalid throttling state, reset\n"));
 			state = 0;
 			ret = acpi_processor_set_throttling(pr, state, true);
 			if (ret)
