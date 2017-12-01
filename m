From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPICA: Rename variable to match upstream
Date: Fri, 01 Dec 2017 15:26:06 +0100
Message-ID: <9112448.bJb2V9PbAy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Erik Schmauss <erik.schmauss@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a variable name mismatch in acpi_ut_strtoul_multiply64()
between the ACPICA code in the kernel and the corresponding upstream
code which may be problematic if changes to this particular piece of
code are made upstream and ported to Linux, so rename the variable
in question to match its name in the upstream code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utstrsuppt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/acpica/utstrsuppt.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utstrsuppt.c
+++ linux-pm/drivers/acpi/acpica/utstrsuppt.c
@@ -370,7 +370,7 @@ acpi_ut_insert_digit(u64 *accumulated_va
 static acpi_status
 acpi_ut_strtoul_multiply64(u64 multiplicand, u32 base, u64 *out_product)
 {
-	u64 val;
+	u64 product;
 	u64 quotient;
 
 	/* Exit if either operand is zero */
@@ -393,15 +393,15 @@ acpi_ut_strtoul_multiply64(u64 multiplic
 		return (AE_NUMERIC_OVERFLOW);
 	}
 
-	val = multiplicand * base;
+	product = multiplicand * base;
 
 	/* Check for 32-bit overflow if necessary */
 
-	if ((acpi_gbl_integer_bit_width == 32) && (val > ACPI_UINT32_MAX)) {
+	if ((acpi_gbl_integer_bit_width == 32) && (product > ACPI_UINT32_MAX)) {
 		return (AE_NUMERIC_OVERFLOW);
 	}
 
-	*out_product = val;
+	*out_product = product;
 	return (AE_OK);
 }
 
