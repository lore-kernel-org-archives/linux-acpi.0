From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPICA: wrong acpi_parse_state assigned acpi_ps_init_scope()
 ?
Date: Fri, 15 Jan 2010 01:31:34 +0100
Message-ID: <4B4FB766.1020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:42310 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab0AOA1E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2010 19:27:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Assign the package end, not the last AML byte.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this right?

diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 2feca5c..a8dfe16 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -118,7 +118,7 @@ acpi_ps_init_scope(struct acpi_parse_state * parser_state,
 	scope->parse_scope.op = root_op;
 	scope->parse_scope.arg_count = ACPI_VAR_ARGS;
 	scope->parse_scope.arg_end = parser_state->aml_end;
-	scope->parse_scope.pkg_end = parser_state->aml_end;
+	scope->parse_scope.pkg_end = parser_state->pkg_end;
 
 	parser_state->scope = scope;
 	parser_state->start_op = root_op;
