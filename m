From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] ACPI: Fix _PLD definition in predefined names
Date: Wed,  5 Oct 2011 14:06:30 -0400
Message-ID: <1317837991-6917-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab1JESGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Oct 2011 14:06:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, Matthew Garrett <mjg@redhat.com>

The acpica code flags _PLD as returning a package of buffers. The spec
defines it as returning a single buffer, and implementations match that.
Fix it up.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/acpredef.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index c445cca..7328932 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -336,8 +336,7 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_PIF", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (3 Int),(3 Str) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, ACPI_RTYPE_STRING}, 3, 0}},
 
-	{{"_PLD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Bufs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_BUFFER, 0,0}, 0,0}},
+	{{"_PLD", 0, ACPI_RTYPE_BUFFER}},
 
 	{{"_PMC", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (11 Int),(3 Str) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 11, ACPI_RTYPE_STRING}, 3,
-- 
1.7.6.4

