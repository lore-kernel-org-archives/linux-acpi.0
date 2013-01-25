From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/7] ACPICA: Update predefined info table
Date: Fri, 25 Jan 2013 13:38:36 +0800
Message-ID: <09e7367296e064aa1b86ffc6d5fd3cc5e47e06a8.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34481 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3AYFjB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:39:01 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Rafael J Wysocki <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The predefined info table defines return types for specific control
methods. This patch updates predefined table as such enhancement has
already been done in ACPICA. This patch can also reduce source code
differences between Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 55fff56..4fbc4be 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -214,9 +214,8 @@ static const union acpi_predefined_info predefined_names[] = {
 	{{"_BCT", 1, ACPI_RTYPE_INTEGER}},
 	{{"_BDN", 0, ACPI_RTYPE_INTEGER}},
 	{{"_BFS", 1, 0}},
-	{{"_BIF", 0, ACPI_RTYPE_PACKAGE} }, /* Fixed-length (9 Int),(4 Str/Buf) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9,
-			     ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER}, 4, 0} },
+	{{"_BIF", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (9 Int),(4 Str) */
+	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9, ACPI_RTYPE_STRING}, 4, 0}},
 
 	{{"_BIX", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (16 Int),(4 Str) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16, ACPI_RTYPE_STRING}, 4,
@@ -238,7 +237,8 @@ static const union acpi_predefined_info predefined_names[] = {
 	{{"_CBA", 0, ACPI_RTYPE_INTEGER}}, /* See PCI firmware spec 3.0 */
 	{{"_CDM", 0, ACPI_RTYPE_INTEGER}},
 	{{"_CID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_PACKAGE}}, /* Variable-length (Ints/Strs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING, 0,0}, 0,0}},
+	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING, 0, 0}, 0,
+	  0}},
 
 	{{"_CLS", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (3 Int) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0}, 0, 0}},
@@ -253,7 +253,8 @@ static const union acpi_predefined_info predefined_names[] = {
 			  {{{ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0,0}, 0,0}},
 
 	{{"_CST", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (1 Int(n), n Pkg (1 Buf/3 Int) */
-			  {{{ACPI_PTYPE2_PKG_COUNT,ACPI_RTYPE_BUFFER, 1, ACPI_RTYPE_INTEGER}, 3,0}},
+	{{{ACPI_PTYPE2_PKG_COUNT, ACPI_RTYPE_BUFFER, 1, ACPI_RTYPE_INTEGER}, 3,
+	  0}},
 
 	{{"_CWS", 1, ACPI_RTYPE_INTEGER}},
 	{{"_DCK", 1, ACPI_RTYPE_INTEGER}},
-- 
1.7.10

