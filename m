From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: IBM Thinkpad A31 | News
Date: Sat, 18 Jan 2003 17:45:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030118164525.GD12516@poup.poupinou.org>
References: <200301171947.54174.dom@wahuu.at> <200301172111.15037.dom@wahuu.at> <20030117210321.GC12516@poup.poupinou.org> <200301172204.52963.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cpvLTH7QU4gwfq3S"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301172204.52963.dom-K271P2BsTd0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dom,

me wrote:

> >
> > I will try to make a workaround for tomorrow, if you want to test
> >
> > Cheers,
> 

Here is then.

This patch is against acpi-20030109.  It override the
ECDT table with a generate one that (hopefully) will work
better.  There is one field only of the table that is buggy (the others
are OK, at least as they are consitant with the definition of
the embedded controller in the DSDT portion).

It replace the original ECDT table when the 3 first letter of the OEM_ID part
is 'IBM    ' and when the EC_ID begin as '\S...' only.  Other fields are not
checked.

You need though to define CONFIG_ACPI_IBM_ECDT_WORKAROUND for it to work.
For that, you want to modifie drivers/acpi/osl.c and check for
/* CONFIG_ACPI_IBM_ECDT_WORKAROUND */

Making it as a part of drivers/acpi/Config.in (2.4) or drivers/acpi/Kconfig (2.5)
is left as an exercise.. :) (there is no file dep, so no Makefile to modifie).

Please note also that I have only tested it generate a table is OK (by
feeding the functions with a hand made program that I can send you if
you want), and also that the kernel compile.
Eer, I don't have any thinkpad to test with, you know..

A final note: I don't recommand this patch for mainstream.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_thinkpad_workaround.diff"

--- linux-2.4.20/drivers/acpi/osl.c	2003/01/14 16:22:32	1.1
+++ linux-2.4.20/drivers/acpi/osl.c	2003/01/18 15:46:57
@@ -25,6 +25,9 @@
  *
  */
 
+/* Define this if you are a Thinkpad owner. */
+/* #define CONFIG_ACPI_IBM_ECDT_WORKAROUND */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -201,6 +204,92 @@
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
@@ -211,6 +300,7 @@
 	*new_table = NULL;
 	return AE_OK;
 }
+#endif
 
 static void
 acpi_irq(int irq, void *dev_id, struct pt_regs *regs)

--cpvLTH7QU4gwfq3S--


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
