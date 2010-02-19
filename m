From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPICA: exfield: minor format change in error message (fwd)
Date: Fri, 19 Feb 2010 01:42:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190141280.24628@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:46452 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0BSGmo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 01:42:44 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200ISITB5IL70@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 00:42:41 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Bob,
one for you.

thanks,
Len Brown, Intel Open Source Technology Center

---------- Forwarded message ----------
Date: Wed, 17 Feb 2010 03:13:27 +0000 (UTC)
From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH] ACPICA: exfield: minor format change in error message

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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
