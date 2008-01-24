From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/13] ACPI: EC: fix dmesg spam regression
Date: Thu, 24 Jan 2008 00:06:52 -0500
Message-ID: <03d1d99c55649ca641b86d2e3489b167ede1671a.1201150939.git.len.brown@intel.com>
References: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:7773 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751124AbYAXFHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 00:07:00 -0500
In-Reply-To: <1201151215-11203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
References: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Return OBF_1 optimization workaround

http://bugzilla.kernel.org/show_bug.cgi?id=8459

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 97dc161..8917d75 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -82,6 +82,7 @@ enum {
 	EC_FLAGS_ADDRESS,		/* Address is being written */
 	EC_FLAGS_NO_WDATA_GPE,		/* Don't expect WDATA GPE event */
 	EC_FLAGS_WDATA,			/* Data is being written */
+	EC_FLAGS_NO_OBF1_GPE,		/* Don't expect GPE before read */
 };
 
 static int acpi_ec_remove(struct acpi_device *device, int type);
@@ -179,6 +180,10 @@ static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
 	int ret = 0;
+
+	if (unlikely(event == ACPI_EC_EVENT_OBF_1 &&
+		     test_bit(EC_FLAGS_NO_OBF1_GPE, &ec->flags)))
+		force_poll = 1;
 	if (unlikely(test_bit(EC_FLAGS_ADDRESS, &ec->flags) &&
 		     test_bit(EC_FLAGS_NO_ADDRESS_GPE, &ec->flags)))
 		force_poll = 1;
@@ -192,7 +197,12 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 			goto end;
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		if (acpi_ec_check_status(ec, event)) {
-			if (test_bit(EC_FLAGS_ADDRESS, &ec->flags)) {
+			if (event == ACPI_EC_EVENT_OBF_1) {
+				/* miss OBF_1 GPE, don't expect it */
+				pr_info(PREFIX "missing OBF confirmation, "
+					"don't expect it any longer.\n");
+				set_bit(EC_FLAGS_NO_OBF1_GPE, &ec->flags);
+			} else if (test_bit(EC_FLAGS_ADDRESS, &ec->flags)) {
 				/* miss address GPE, don't expect it anymore */
 				pr_info(PREFIX "missing address confirmation, "
 					"don't expect it any longer.\n");
-- 
1.5.4.rc4.14.g6fc74

