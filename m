From: yakui.zhao@intel.com
Subject: [Patch 3/3] Pmtools: Add one option to dump ACPI table by maping /dev/mem
Date: Wed,  5 Jan 2011 09:35:33 +0800
Message-ID: <1294191333-7381-4-git-send-email-yakui.zhao@intel.com>
References: <1294191333-7381-1-git-send-email-yakui.zhao@intel.com>
 <1294191333-7381-2-git-send-email-yakui.zhao@intel.com>
 <1294191333-7381-3-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1AEBel (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jan 2011 20:34:41 -0500
In-Reply-To: <1294191333-7381-3-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Some tables are missing under the directory of /sys/firmware/acpi/tables.
For example: RSDT, RSDP. 
In order to dump the missing table, Add one option to dump ACPI table by maping
/dev/mem directly instead of enumerating /sys/firmware/acpi/tables.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 acpidump/acpidump.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: pmtools/acpidump/acpidump.c
===================================================================
--- pmtools.orig/acpidump/acpidump.c
+++ pmtools/acpidump/acpidump.c
@@ -456,7 +456,7 @@ static void usage(const char *progname)
 {
 	puts("Usage:");
 	printf("%s [--addr 0x1234][--table DSDT][--output filename]"
-		"[--binary][--length 0x456][--help]\n", progname);
+		"[--binary][--memory][--length 0x456][--help]\n", progname);
 	puts("\t--addr 0x1234 or -a 0x1234 -- look for tables at this physical address");
 	puts("\t--table DSDT or -t DSDT -- only dump table with DSDT signature");
 	puts("\t--output filename or -o filename -- redirect output from stdin to filename");
@@ -464,6 +464,7 @@ static void usage(const char *progname)
 	puts("\t--length 0x456 or -l 0x456 -- works only with --addr, dump physical memory"
 		"\n\t\tregion without trying to understand it's contents");
 	puts("\t--skip 2 or -s 2 -- skip 2 tables of the given name and output only 3rd one");
+	puts("\t--memory or -m Use the /dev/mem to dump acpi tables");
 	puts("\t--help or -h -- this help message");
 	exit(0);
 }
@@ -475,12 +476,13 @@ static struct option long_options[] = {
 	{"binary", 0, 0, 0},
 	{"length", 1, 0, 0},
 	{"skip", 1, 0, 0},
+	{"memory", 0, 0, 0},
 	{"help", 0, 0, 0},
 	{0, 0, 0, 0}
 };
 int main(int argc, char **argv)
 {
-	int option_index, c, fd;
+	int option_index, c, fd, skip_table;
 	u8 *raw;
 	struct acpi_rsdp_descriptor rsdpx, *x = 0;
 	char *filename = 0;
@@ -490,9 +492,10 @@ int main(int argc, char **argv)
 	connect = 0;
 	addr = length = 0;
 	skip = 0;
+	skip_table = 0;
 	while (1) {
 		option_index = 0;
-		c = getopt_long(argc, argv, "a:t:o:bl:s:h",
+		c = getopt_long(argc, argv, "a:t:o:bml:s:h",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -519,6 +522,9 @@ int main(int argc, char **argv)
 				skip = strtoul(optarg, (char **)NULL, 10);
 				break;
 			case 6:
+				skip_table = 1;
+				break;
+			case 7:
 				usage(argv[0]);
 				exit(0);
 			}
@@ -541,6 +547,9 @@ int main(int argc, char **argv)
 		case 's':
 			skip = strtoul(optarg, (char **)NULL, 10);
 			break;
+		case 'm':
+			skip_table = 1;
+			break;
 		case 'h':
 			usage(argv[0]);
 			exit(0);
@@ -580,7 +589,7 @@ int main(int argc, char **argv)
 	 * in dumping ACPI table, fall back to the conventional dumping
 	 * mechanism by mapping /dev/mem.
 	 */
-	if (acpi_dump_firmware_table(fd)) {
+	if (!skip_table && acpi_dump_firmware_table(fd)) {
 		acpi_dump_dynamic_SSDT(fd);
 		close(fd);
 		return 0;
