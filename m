From: yakui.zhao@intel.com
Subject: [Patch 2/3] Pmtools: Prefer dumping ACPI tables through /sys/firmware/acpi/tables/
Date: Wed,  5 Jan 2011 09:35:32 +0800
Message-ID: <1294191333-7381-3-git-send-email-yakui.zhao@intel.com>
References: <1294191333-7381-1-git-send-email-yakui.zhao@intel.com>
 <1294191333-7381-2-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1AEBek (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jan 2011 20:34:40 -0500
In-Reply-To: <1294191333-7381-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the support of dumping ACPI table through /sys/firmware/acpi/tables. If it
succeeds, dump the dynamic SSDT table and then exit. Otherwise it will fall back
to dump the ACPI table by maping /dev/mem.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 acpidump/acpidump.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

Index: pmtools/acpidump/acpidump.c
===================================================================
--- pmtools.orig/acpidump/acpidump.c
+++ pmtools/acpidump/acpidump.c
@@ -374,6 +374,84 @@ static void acpi_dump_dynamic_SSDT(int o
 	return;
 }
 
+#define FIRMWARE_ACPI_TABLE	"/sys/firmware/acpi/tables"
+static int acpi_dump_firmware_table(int out_fd)
+{
+	struct stat file_stat;
+	char filename[256], *ptr;
+	DIR *tabledir;
+	struct dirent *entry;
+	FILE *fp;
+	int count, readcount, length;
+	struct acpi_table_header table_header, *ptable;
+	int table_count = 0;
+
+	if (stat(FIRMWARE_ACPI_TABLE, &file_stat) == -1) {
+		/* The directory doesn't exist */
+		return 0;
+	}
+	tabledir = opendir(FIRMWARE_ACPI_TABLE);
+	if(!tabledir){
+		/*can't open the directory */
+		return 0;
+         }
+
+	while ((entry = readdir(tabledir)) != 0){
+		/* skip the file of . /.. */
+		if (entry->d_name[0] == '.')
+			continue;
+
+		if (entry->d_type == DT_DIR) {
+			/*
+			 * Skip the directory of /sys/firmware/acpi/tables/dynamic.
+			 * It will be handled in another function.
+			 */
+			continue;
+		}
+		sprintf(filename, "%s/%s", FIRMWARE_ACPI_TABLE, entry->d_name);
+		fp = fopen(filename, "r");
+		if (fp == NULL) {
+			fprintf(stderr, "Can't open the file of %s\n",
+						filename);
+			continue;
+		}
+		/* Read the Table header to parse the table length.
+		 * Although the FACS table has no table header definition, it has
+		 * the same definition as table header for the first 8 bytes.
+		 * At the same time according to the spec the table length of FACS
+		 * is >=64, which is greater than the length of table_header.
+		 * So we still use table_header structure to parse the table
+		 * length for FACS.
+		 */
+		count = fread(&table_header, 1, sizeof(struct acpi_table_header), fp);
+		if (count < sizeof(table_header)) {
+			/* the length is lessn than ACPI table header. skip it */
+			fclose(fp);
+			continue;
+		}
+		length = table_header.length;
+		ptr = malloc(table_header.length);
+		fseek(fp, 0, SEEK_SET);
+		readcount = 0;
+		while(!feof(fp) && readcount < length) {
+			count = fread(ptr + readcount, 1, 256, fp);
+			readcount += count;
+		}
+		fclose(fp);
+		ptable = (struct acpi_table_header *) ptr;
+		/* Skip the checksum for FACS table */
+		if (strncmp(ptable->signature, "FACS", 4) &&
+				checksum((u8 *) ptable, ptable->length))
+			fprintf(stderr, "Wrong checksum "
+				"for table %s!\n", entry->d_name);
+		write_table(out_fd, ptable, 0);
+		free(ptr);
+		table_count++;
+	}
+	closedir(tabledir);
+	return table_count;
+}
+
 static void usage(const char *progname)
 {
 	puts("Usage:");
@@ -495,6 +573,19 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	/*
+	 * Prefer dumping ACPI table by enumerating the directory
+	 * of /sys/firmware/acpi/tables.
+	 * If it succeeds, dump dynamic SSDT table and exit. And if it fails
+	 * in dumping ACPI table, fall back to the conventional dumping
+	 * mechanism by mapping /dev/mem.
+	 */
+	if (acpi_dump_firmware_table(fd)) {
+		acpi_dump_dynamic_SSDT(fd);
+		close(fd);
+		return 0;
+	}
+
 	length = sizeof(struct acpi_rsdp_descriptor);
 	if (!addr) {
 		addr = read_efi_systab();
