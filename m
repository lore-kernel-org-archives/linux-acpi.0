From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: thinkpad workaround v2.
Date: Mon, 20 Jan 2003 15:09:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030120140926.GA11487@poup.poupinou.org>
References: <200301171947.54174.dom@wahuu.at> <20030118164525.GD12516@poup.poupinou.org> <20030118170844.GE12516@poup.poupinou.org> <200301201442.27358.x545@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301201442.27358.x545-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: x545 <x545-hi6Y0CQ0nG0@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2003 at 02:42:27PM +0100, x545 wrote:
> I get many Errors, all the same in osl.c, line 
> 234,241,243,244,248,250,251,266,290: dereferencing pointer to incomplete 
> type
> Can you please give short instructions what's wrong or send a complete 
> working diff?

in short, 'struct acpi_table_ecdt' is now in include/linux/acpi.h

Then replace
#include "acpi.h"

by
#include <linux/acpi.h>
(which include drivers/acpi/include/acpi.h btw)

in the file drivers/acpi/osl.c

Here goes the complete patch to be make things cleaner.

my big apologies for this mistake by me..

A final note though: I don't have a thinkpad to play with
so that I can not test myself this workaround.  

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="thinkpad_ecdt_workaround-v2.diff"

--- linux-2.4/drivers/acpi/osl.c	2003/01/20 11:26:31	1.1
+++ linux-2.4/drivers/acpi/osl.c	2003/01/20 12:40:54
@@ -25,6 +25,9 @@
  *
  */
 
+/* Define this if you are a Thinkpad owner. */
+/* #define CONFIG_ACPI_IBM_ECDT_WORKAROUND */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -35,7 +38,11 @@
 #include <linux/delay.h>
 #include <asm/io.h>
 #include "acpi_bus.h"
+#ifdef CONFIG_ACPI_IBM_ECDT_WORKAROUND
+#include <linux/acpi.h>
+#else
 #include "acpi.h"
+#endif
 
 #ifdef CONFIG_ACPI_EFI
 #include <linux/efi.h>
@@ -201,6 +208,94 @@
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_IBM_ECDT_WORKAROUND
+static          u8
+compute_checksum(struct acpi_table_header * h)
+{
+	int             i;
+	u8             *p;
+	u8              cs;
+
+	p = (u8 *) h;
+	cs = 0;
+	for (i = 0; i < h->length; i++)
+		cs += *p++;
+	return cs;
+}
+
+static          acpi_status
+try_to_replace_ibm_ecdt(struct acpi_table_ecdt * old,
+			struct acpi_table_ecdt ** new)
+{
+	u32             len;
+	u8             *p;
+	struct acpi_table_ecdt *ecdt;
+
+	*new = NULL;
+
+	len = old->header.length;
+	ecdt = kmalloc(len + 1, GFP_KERNEL);
+	if (!ecdt)
+		return AE_NO_MEMORY;
+
+	memcpy(ecdt, old, len);
+
+	ecdt->header.length = len + 1;
+
+	for (p = (u8 *) ecdt + ecdt->header.length - 1;
+	     p != (u8 *) & ecdt->ec_id;
+	     --p) {
+		*p = *(p - 1);
+	}
+	ecdt->ec_id[1] = '_';
+
+	ecdt->header.checksum = 0;
+	ecdt->header.checksum = -compute_checksum((struct acpi_table_header *) ecdt);
+
+	*new = ecdt;
+
+	printk(KERN_WARNING "acpi: IBM's ECDT TABLE sucessfully replaced by a corrected one.\n");
+
+	return AE_OK;
+}
+
+
+static          acpi_status
+verify_ibm_ecdt(struct acpi_table_ecdt * existing_table,
+		struct acpi_table_ecdt ** new_table)
+{
+	const char     *const ec_id =
+	((struct acpi_table_ecdt *) existing_table)->ec_id;
+
+	if (ec_id[0] == '\\' && ec_id[1] == 'S') {
+		printk(KERN_WARNING "acpi: Found bad ACPI ECDT table from IBM in the firmware\n");
+		return (try_to_replace_ibm_ecdt(existing_table, new_table));
+	}
+	return AE_OK;
+}
+
+
+
+acpi_status
+acpi_os_table_override(struct acpi_table_header * existing_table,
+		       struct acpi_table_header ** new_table)
+{
+	if (!existing_table || !new_table)
+		return AE_BAD_PARAMETER;
+
+	*new_table = NULL;
+
+	if (!memcmp(existing_table->signature, "ECDT", 4)) {
+		struct acpi_table_ecdt *old = (struct acpi_table_ecdt *) existing_table;
+		struct acpi_table_ecdt **new = (struct acpi_table_ecdt **) new_table;
+
+		if (!memcmp(old->header.oem_id, "IBM", 3))
+			return (verify_ibm_ecdt(old, new));
+	}
+	return AE_OK;
+}
+
+#else	/* CONFIG_ACPI_IBM_ECDT_WORKAROUND */
 acpi_status
 acpi_os_table_override (struct acpi_table_header *existing_table,
 			struct acpi_table_header **new_table)
@@ -211,6 +306,7 @@
 	*new_table = NULL;
 	return AE_OK;
 }
+#endif
 
 static void
 acpi_irq(int irq, void *dev_id, struct pt_regs *regs)

--8t9RHnE3ZwKMSgU+--


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
