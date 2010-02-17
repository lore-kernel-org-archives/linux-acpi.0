From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH] ACPICA: exfield: minor format change in error message
Date: Wed, 17 Feb 2010 03:13:27 +0000 (UTC)
Message-ID: <20100217031240.31842.17874.sendpatchset@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:14908 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927Ab0BQDN3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 22:13:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Found this while debugging a problem.  Trivial, but useful, format change.

Before:
ACPI Error: SMBus or IPMI write requires Buffer of length 42, found length 20
(20091214/exfield-285)

After:
ACPI Error: SMBus or IPMI write requires Buffer of length 66, found length 32
(20091214/exfield-286)

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1588a2d..be2b03a 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		if (source_desc->buffer.length < length) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus or IPMI write requires Buffer of length %X, found length %X",
+				    "SMBus or IPMI write requires Buffer of "
+				    "length %d, found length %d",
 				    length, source_desc->buffer.length));
 
 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
