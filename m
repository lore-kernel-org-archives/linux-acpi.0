From: Peter Jones <pjones@redhat.com>
Subject: RE: Output ACPI info via sysfs
Date: Tue, 16 May 2006 11:03:18 -0400
Message-ID: <1147791798.29569.7.camel@localhost.localdomain>
References: <CFF307C98FEABE47A452B27C06B85BB675A9C4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932067AbWEPPDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 May 2006 11:03:24 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB675A9C4@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, "Moore, Robert" <robert.moore@intel.com>

On Mon, 2006-05-15 at 18:21 -0400, Brown, Len wrote:
> I see.
> the /dev/mem reader tickles some hardware wrong in some cases.

Yes.

> sure looks like a wrap-around or a sign bug, being so close to 4GB.

It's just bad data in the table, AFAICS.

> Is this still true for acpidump in the latest pmtools here?:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> 
> Bob,
> the latest, 20051111, is indeed based on the ACPICA headers.

Yeah, still true there.  I've got a workaround in my code.  Here's a
patch against pmtools that makes it work on this box:

--- pmtools-20051111/madt/tables.c.orig	2006-05-16 05:57:03.000000000 -0400
+++ pmtools-20051111/madt/tables.c	2006-05-16 05:57:04.000000000 -0400
@@ -514,6 +514,8 @@
 	acpi_table_print(header, sdt_pa);
 
 	for (i = 0; i < sdt_count; i++) {
+		if (sdt_entry[i].pa == 0 && sdt_entry[i].id == ACPI_TABLE_UNKNOWN)
+			continue;
 
 		/* map in just the header */
 		header = (struct acpi_table_header *)
--- pmtools-20051111/acpidump/acpidump.c.orig	2006-05-16 05:26:43.000000000 -0400
+++ pmtools-20051111/acpidump/acpidump.c	2006-05-16 05:58:02.000000000 -0400
@@ -99,9 +99,18 @@
 
 static struct acpi_table_header *acpi_map_table(unsigned long where, char *sig)
 {
-	struct acpi_table_header *tbl = (struct acpi_table_header *)
+	struct acpi_table_header *tbl;
+
+	if (!where)
+	    return 0;
+	tbl = (struct acpi_table_header *)
 	    acpi_map_memory(where, sizeof(struct acpi_table_header));
-	if (!tbl || (sig && memcmp(sig, tbl->signature, 4))) return 0;
+	if (!tbl)
+	    return 0;
+	if (sig && memcmp(sig, tbl->signature, 4)) {
+	    acpi_unmap_memory((u8 *)tbl, sizeof(struct acpi_table_header));
+	    return 0;
+	}
 	unsigned size = tbl->length;
 	acpi_unmap_memory((u8 *) tbl, sizeof(struct acpi_table_header));
 	return (struct acpi_table_header *)acpi_map_memory(where, size);


Obviously this isn't a real solution, just a workaround.

> >But when the kernel is parsing the tables, it's getting the right data.
> >I really have no idea what's happening on that hardware.  I suspect a
> >bus analyzer is needed to tell for sure what's going on.
> 
> I can't explain why the kernel works and the latest acpidump doesn't,
> but I'm willing to help fix the latest acpidump so it does.

With the patch above it works on the machine with bogus data.  Still
doesn't help the machines that wedge solid :/ .

> >...
> >I still don't think it's the best idea -- poking around
> >in /dev/mem is ugly and bug-prone.  Doing this probe in userland means
> >we've got two sets of code to parse the same thing, which pretty much
> >always leads to bug fixes that fail to be applied to both sets of code.
> >So that means I've essentially got to track changes to what the kernel
> >parsing code (or some library-ized version of pmtools) in order to get
> >bug fixes.  This is a maintenance nightmare!
> 
> On the grand scale of nigthmares, this is not a big one.
> This code nearly never changes.  Also, the user-land utility
> can work even when the kernel is broken.

The problem is that the opposite is also true -- the kernel works
sometimes when userland doesn't.

> I don't really see a case to bloat the kernel here.
> Perhaps all the user-space parser needs it a reliable
> physical address for the MADT?

If you're really set on the parser to be in userland, but you're willing
to have the kernel go so far as to expose an address, why not just
expose the whole MADT as a sysfs or proc file?  (Ignoring that it'll
make gregkh scream at us...)

-- 
  Peter

