From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] lots of ACPI tables
Date: Tue, 13 Aug 2002 19:26:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020813192619.A5283@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This patch written by Bjorn Helgaas supports more ACPI tables.
Limiting the maximum number of tables to the number of different tables
we recognise is clearly bogus -- some tables can appear more than once.
And if we ignore some tables, the subtraction was backwards.

diff -urpNX ../dontdiff acpi/linux-acpi0726/drivers/acpi/tables.c linux-acpi/drivers/acpi/tables.c
--- acpi/linux-acpi0726/drivers/acpi/tables.c	Mon Aug 12 19:43:52 2002
+++ linux-acpi/drivers/acpi/tables.c	Mon Aug 12 19:49:54 2002
@@ -36,7 +36,7 @@
 
 #define PREFIX			"ACPI: "
 
-#define ACPI_MAX_TABLES		ACPI_TABLE_COUNT
+#define ACPI_MAX_TABLES		256
 
 static char *acpi_table_signatures[ACPI_TABLE_COUNT] = {
 	[ACPI_TABLE_UNKNOWN]	= "????",
@@ -338,7 +338,7 @@ acpi_table_get_sdt (
 		sdt.count = (header->length - sizeof(struct acpi_table_header)) >> 3;
 		if (sdt.count > ACPI_MAX_TABLES) {
 			printk(KERN_WARNING PREFIX "Truncated %lu XSDT entries\n",
-				(ACPI_MAX_TABLES - sdt.count));
+				(sdt.count - ACPI_MAX_TABLES));
 			sdt.count = ACPI_MAX_TABLES;
 		}
 
@@ -383,7 +383,7 @@ acpi_table_get_sdt (
 		sdt.count = (header->length - sizeof(struct acpi_table_header)) >> 2;
 		if (sdt.count > ACPI_MAX_TABLES) {
 			printk(KERN_WARNING PREFIX "Truncated %lu RSDT entries\n",
-				(ACPI_TABLE_COUNT - sdt.count));
+				(sdt.count - ACPI_TABLE_COUNT));
 			sdt.count = ACPI_MAX_TABLES;
 		}
 
-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
