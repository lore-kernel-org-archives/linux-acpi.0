From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: acpidump replaces acpidmp
Date: Fri, 29 Jul 2005 14:37:09 +0200
Message-ID: <42EA22F5.6060502@suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B300428C441@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050904070201060100060306"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300428C441-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050904070201060100060306
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Brown, Len wrote:
>  
>>>../include/acpi/actypes.h:115
>>>Replace s64 with u64 and it at least compiles.
> 
> I published this initial version while at OLS,
> having tested it only on ia32.
> 
> I tested it now on x86_64 and ran into the same problem as you.
> The fix, however, is to use the typedef used in the kernel,
> a signed long long, in this case.
> 
> After this change it works fine for me on x86_64 -- I'll
> push a new version momentarily.
> 
Thanks.

Works with -O2 compile flag, it segfaults with -g.

The bad line is:
memcpy(&rsdt, tbl, tbl->length);  (line 196)

The rsdt has an undefined amount of pointers to other ACPI
tables in the end, therefore tbl->length > sizeof(struct rsdt),
memcpy writes outside &rsdt.

Patch to avoid memcpy attached. Don't know how to integrate it nicer/shorter,
please review.

Thanks,

      Thomas




--------------050904070201060100060306
Content-Type: text/x-patch;
 name="acpidump_memcpy_beyond_rsdt_struct.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpidump_memcpy_beyond_rsdt_struct.diff"

--- x/acpidump/acpidump.c	2005-07-29 14:10:09.000000000 +0200
+++ y/acpidump/acpidump.c	2005-07-29 14:18:30.000000000 +0200
@@ -188,20 +188,20 @@
 
 static acpi_status acpi_dump_RSDT(int fd, struct rsdp_descriptor *rsdp)
 {
-	struct acpi_table_header *tbl =
+	struct acpi_table_header *tbl;
+	struct acpi_table_header *rsdt_header =
 	    acpi_map_table(rsdp->rsdt_physical_address, RSDT_SIG);
-	if (!tbl)
+	RSDT_DESCRIPTOR *rsdt = (RSDT_DESCRIPTOR*) rsdt_header;
+	if (!rsdt_header)
 		return AE_NOT_FOUND;
-	RSDT_DESCRIPTOR rsdt;
-	memcpy(&rsdt, tbl, tbl->length);
+
 	void *addr;
-	acpi_unmap_table(tbl);
-	int num = (rsdt.length - sizeof(RSDT_DESCRIPTOR)) / sizeof(u32) + 1;
+	int num = (rsdt_header->length - sizeof(RSDT_DESCRIPTOR)) / sizeof(u32) + 1;
 	int dsdt_idx = -1, facs_idx = -1, fadt1_idx = -1, fadt2_idx =
 	    -1, fadt2m_idx = -1;
 	int i;
 	for (i = 0; i < num; ++i) {
-		tbl = acpi_map_table(rsdt.table_offset_entry[i], 0);
+		tbl = acpi_map_table(rsdt->table_offset_entry[i], 0);
 		if (!tbl)
 			continue;
 		if (!memcmp(tbl->signature, FADT_SIG, 4)) {
@@ -221,9 +221,9 @@
 			} else if (!memcmp(tbl->signature, FACS_SIG, 4)) {
 				facs_idx = i;
 			}
-			addr = (void *)rsdt.table_offset_entry[i];
+			addr = (void *)rsdt->table_offset_entry[i];
 			if (connect) {
-				rsdt.table_offset_entry[i] =
+				rsdt->table_offset_entry[i] =
 				    lseek(fd, 0, SEEK_CUR);
 			}
 			write_table(fd, tbl, addr);
@@ -232,19 +232,23 @@
 	}
 	if (fadt1_idx != -1) {
 		tbl =
-		    acpi_map_table(rsdt.table_offset_entry[fadt1_idx],
+		    acpi_map_table(rsdt->table_offset_entry[fadt1_idx],
 				   FADT_SIG);
-		if (!tbl)
+		if (!tbl){
+			acpi_unmap_table(rsdt_header);
 			return AE_NOT_FOUND;
+		}
 		struct fadt_descriptor_rev1 x;
 		memcpy(&x, tbl, sizeof(struct fadt_descriptor_rev1));
 		acpi_unmap_table(tbl);
 		if (dsdt_idx != -1) {
-			x.dsdt = rsdt.table_offset_entry[dsdt_idx];
+			x.dsdt = rsdt->table_offset_entry[dsdt_idx];
 		} else {
 			tbl = acpi_map_table(x.dsdt, DSDT_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)x.dsdt;
 			if (connect) {
 				x.dsdt = lseek(fd, 0, SEEK_CUR);
@@ -253,11 +257,13 @@
 			acpi_unmap_table(tbl);
 		}
 		if (facs_idx != -1) {
-			x.firmware_ctrl = rsdt.table_offset_entry[facs_idx];
+			x.firmware_ctrl = rsdt->table_offset_entry[facs_idx];
 		} else {
 			tbl = acpi_map_table(x.firmware_ctrl, FACS_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)x.firmware_ctrl;
 			if (connect) {
 				x.firmware_ctrl = lseek(fd, 0, SEEK_CUR);
@@ -265,28 +271,32 @@
 			write_table(fd, tbl, addr);
 			acpi_unmap_table(tbl);
 		}
-		addr = (void *)rsdt.table_offset_entry[fadt1_idx];
+		addr = (void *)rsdt->table_offset_entry[fadt1_idx];
 		if (connect) {
-			rsdt.table_offset_entry[fadt1_idx] =
+			rsdt->table_offset_entry[fadt1_idx] =
 			    lseek(fd, 0, SEEK_CUR);
 		}
 		write_table(fd, (struct acpi_table_header *)&x, addr);
 	}
 	if (fadt2_idx != -1) {
 		tbl =
-		    acpi_map_table(rsdt.table_offset_entry[fadt2_idx],
+		    acpi_map_table(rsdt->table_offset_entry[fadt2_idx],
 				   FADT_SIG);
-		if (!tbl)
+		if (!tbl){
+			acpi_unmap_table(rsdt_header);
 			return AE_NOT_FOUND;
+		}
 		struct fadt_descriptor_rev2 x;
 		memcpy(&x, tbl, sizeof(struct fadt_descriptor_rev2));
 		acpi_unmap_table(tbl);
 		if (dsdt_idx != -1) {
-			x.Xdsdt = rsdt.table_offset_entry[dsdt_idx];
+			x.Xdsdt = rsdt->table_offset_entry[dsdt_idx];
 		} else {
 			tbl = acpi_map_table(x.Xdsdt, DSDT_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)(unsigned long)x.Xdsdt;
 			if (connect) {
 				x.Xdsdt = lseek(fd, 0, SEEK_CUR);
@@ -295,11 +305,13 @@
 			acpi_unmap_table(tbl);
 		}
 		if (facs_idx != -1) {
-			x.xfirmware_ctrl = rsdt.table_offset_entry[facs_idx];
+			x.xfirmware_ctrl = rsdt->table_offset_entry[facs_idx];
 		} else {
 			tbl = acpi_map_table(x.xfirmware_ctrl, FACS_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)(unsigned long)x.xfirmware_ctrl;
 			if (connect) {
 				x.xfirmware_ctrl = lseek(fd, 0, SEEK_CUR);
@@ -307,28 +319,32 @@
 			write_table(fd, tbl, addr);
 			acpi_unmap_table(tbl);
 		}
-		addr = (void *)rsdt.table_offset_entry[fadt2_idx];
+		addr = (void *)rsdt->table_offset_entry[fadt2_idx];
 		if (connect) {
-			rsdt.table_offset_entry[fadt2_idx] =
+			rsdt->table_offset_entry[fadt2_idx] =
 			    lseek(fd, 0, SEEK_CUR);
 		}
 		write_table(fd, (struct acpi_table_header *)&x, addr);
 	}
 	if (fadt2m_idx != -1) {
 		tbl =
-		    acpi_map_table(rsdt.table_offset_entry[fadt2m_idx],
+		    acpi_map_table(rsdt->table_offset_entry[fadt2m_idx],
 				   FADT_SIG);
-		if (!tbl)
+		if (!tbl){
+			acpi_unmap_table(rsdt_header);
 			return AE_NOT_FOUND;
+		}
 		struct fadt_descriptor_rev2_minus x;
 		memcpy(&x, tbl, sizeof(struct fadt_descriptor_rev2_minus));
 		acpi_unmap_table(tbl);
 		if (dsdt_idx != -1) {
-			x.V1_dsdt = rsdt.table_offset_entry[dsdt_idx];
+			x.V1_dsdt = rsdt->table_offset_entry[dsdt_idx];
 		} else {
 			tbl = acpi_map_table(x.V1_dsdt, DSDT_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)(unsigned long)x.V1_dsdt;
 			if (connect) {
 				x.V1_dsdt = lseek(fd, 0, SEEK_CUR);
@@ -337,11 +353,13 @@
 			acpi_unmap_table(tbl);
 		}
 		if (facs_idx != -1) {
-			x.V1_firmware_ctrl = rsdt.table_offset_entry[facs_idx];
+			x.V1_firmware_ctrl = rsdt->table_offset_entry[facs_idx];
 		} else {
 			tbl = acpi_map_table(x.V1_firmware_ctrl, FACS_SIG);
-			if (!tbl)
+			if (!tbl){
+				acpi_unmap_table(rsdt_header);
 				return AE_NOT_FOUND;
+			}
 			addr = (void *)(unsigned long)x.V1_firmware_ctrl;
 			if (connect) {
 				x.V1_firmware_ctrl = lseek(fd, 0, SEEK_CUR);
@@ -349,9 +367,9 @@
 			write_table(fd, tbl, addr);
 			acpi_unmap_table(tbl);
 		}
-		addr = (void *)rsdt.table_offset_entry[fadt2m_idx];
+		addr = (void *)rsdt->table_offset_entry[fadt2m_idx];
 		if (connect) {
-			rsdt.table_offset_entry[fadt2m_idx] =
+			rsdt->table_offset_entry[fadt2m_idx] =
 			    lseek(fd, 0, SEEK_CUR);
 		}
 		write_table(fd, (struct acpi_table_header *)&x, addr);
@@ -360,7 +378,8 @@
 	if (connect) {
 		rsdp->rsdt_physical_address = lseek(fd, 0, SEEK_CUR);
 	}
-	write_table(fd, (struct acpi_table_header *)&rsdt, addr);
+	write_table(fd, (struct acpi_table_header *)rsdt_header, addr);
+	acpi_unmap_table(rsdt_header);
 	return AE_OK;
 }
 

--------------050904070201060100060306--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
