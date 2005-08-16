From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: RE: acpidump replaces acpidmp
Date: Tue, 16 Aug 2005 15:32:34 -0600
Message-ID: <200508161532.34578.bjorn.helgaas@hp.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300456A26A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300456A26A-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 August 2005 12:23 pm, Brown, Len wrote:
> Mats,
> Does the latest acpidump work for you now?
> can we obsolete /proc/acpi/fadt,dsdt?

pmtools-20050804 doesn't work at all on ia64, because
the RSDP doesn't live where you expect it.  We export
/sys/firmware/efi/systab with the addresses you want.

The attached patch adds this, fixes a bunch of
documentation errors, and fixes some broken if/else
blocking.  There are still a number of warnings when
building on ia64; I didn't bother to fix those, sorry.

diff -u -ur pmtools-20050804/README pmtools/README
--- pmtools-20050804/README	2005-07-21 23:19:03.000000000 -0600
+++ pmtools/README	2005-08-16 15:02:25.000000000 -0600
@@ -8,37 +8,38 @@
 -----------------
 This utility dumps a system's ACPI tables to an ASCII file.
 
-Typically it is used to grab all the ACPI tables
-to attach to a bug report for later examination.
+Typically it is used to dump all the ACPI tables
+to attach to a bug report for later examination:
 
-# acpidump > acpidump.out
+    # ./acpidump > acpidump.out
 
-It can also grab a specific binary table
+It can also dump a specific table:
 
-# acpidump DSDT > DSDT
+    # ./acpidump -t DSDT > DSDT
+
+./acpidump/acpixtract
+--------------------
+Convert ASCII acpidump output to raw binary table:
+
+    # ./acpidump -t DSDT | ./acpixtract > DSDT
+    $ cat email | ./acpixtract DSDT > DSDT
 
 ./acpidump/acpitbl
 -----------------
-Perl script to dump the table header or contents
-of a binary ACPI table.  eg.
+Dump the table header or contents of a raw ACPI table:
 
-# acpidump FACP | acpitbl
-
-./acpidump/acpixtract
---------------------
-Perl script to extract raw table from ASCII acpidump output eg. 
-$ cat acpidump.out | acpixtract DSDT > DSDT
-or
+    # ./acpidump -t FACP | ./acpixtract | ./acpitbl
+    $ cat email | ./acpixtract FACP | ./acpitbl
 
 Disassembler
 ------------
-Note that the acpidisasm has been deleted, in favor of iasl:
+Note that acpidisasm has been deleted, in favor of iasl:
 http://www.intel.com/technology/IAPC/acpi/downloads.htm
 
 Which creates DSDT.dsl this way:
 
-$ acpixtract DSDT acpidump.out
-$ iasl -d DSDT
+    # ./acpidump -t DSDT | ./acpixtract > DSDT
+    $ iasl -d DSDT
 
 
 pmtest -- does not work
diff -u -ur pmtools-20050804/acpidump/acpidump.c pmtools/acpidump/acpidump.c
--- pmtools-20050804/acpidump/acpidump.c	2005-08-04 11:03:32.000000000 -0600
+++ pmtools/acpidump/acpidump.c	2005-08-16 15:51:29.000000000 -0600
@@ -65,6 +65,18 @@
 static int connect;
 static u8 select_sig[4];
 
+static void read_efi_systab(unsigned long *base)
+{
+	FILE *f = fopen("/sys/firmware/efi/systab", "r");
+	if (!f)
+		return;
+	unsigned long addr;
+	int n = fscanf(f, "ACPI20=0x%lx", &addr);
+	if (n == 1)
+		*base = addr;
+	fclose(f);
+}
+
 static u8 *acpi_map_memory(unsigned long where, unsigned length)
 {
 	int fd = open("/dev/mem", O_RDONLY);
@@ -552,18 +564,17 @@
 	printf
 	    ("%s [--addr 0x1234][--table DSDT][--output filename][--binary][--length 0x456][--help]\n",
 	     progname);
-	puts("\t--addr 0x1234 or -a 0x1234 -- look for tables at this phisical address");
+	puts("\t--addr 0x1234 or -a 0x1234 -- look for tables at this physical address");
 	puts("\t--table DSDT or -t DSDT -- only dump table with DSDT signature");
 	puts("\t--output filename or -o filename -- redirect output from stdin to filename");
 	puts("\t--binary or -b -- dump data in binary form rather than in hex-dump format");
-	puts("\t--length 0x456 or -l 0x456 -- works only with --addr, dump phisical memory\n\t\tregion without trying to understand it's contents");
+	puts("\t--length 0x456 or -l 0x456 -- works only with --addr, dump physical memory\n\t\tregion without trying to understand its contents");
 	puts("\t--help or -h -- this help message");
 	exit(0);
 }
 struct rsdp_descriptor rsdpx;
 int main(int argc, char **argv)
 {
-
 	memset(select_sig, 0, 4);
 	unsigned long addr = 0;
 	unsigned long length = 0;
@@ -637,9 +648,16 @@
 		connect = 1;
 	}
 	psz = sysconf(_SC_PAGESIZE);
-	unsigned long base = (addr) ? addr : ACPI_HI_RSDP_WINDOW_BASE;
+	unsigned long base = 0;
+	if (addr)
+		base = addr;
+	else {
+		read_efi_systab(&base);
+		if (!base)
+			base = ACPI_HI_RSDP_WINDOW_BASE;
+	}
 	unsigned long size =
-	    (addr) ? sizeof(struct rsdp_descriptor) : ACPI_HI_RSDP_WINDOW_SIZE;
+		    (addr) ? sizeof(struct rsdp_descriptor) : ACPI_HI_RSDP_WINDOW_SIZE;
 	size = (length) ? length : size;
 	u8 *raw = acpi_map_memory(base, size);
 	if (!raw)
@@ -670,7 +688,8 @@
 		if (rsdpx.rsdt_physical_address) {
 			if (acpi_dump_RSDT(fd, &rsdpx) == AE_OK)
 				success = 1;
-		if (!success && rsdpx.revision > 1)
+		}
+		if (!success && rsdpx.revision > 1) {
 			if (acpi_dump_XSDT(fd, &rsdpx) == AE_OK)
 				success = 1;
 		}
diff -u -ur pmtools-20050804/acpidump/acpitbl pmtools/acpidump/acpitbl
--- pmtools-20050804/acpidump/acpitbl	2001-07-30 19:04:59.000000000 -0600
+++ pmtools/acpidump/acpitbl	2005-08-16 14:55:26.000000000 -0600
@@ -2,7 +2,7 @@
 #
 # acpitbl - ACPI table dumper
 #
-# Example: ./acpidmp FACP | ./acpitbl
+# Example: ./acpidump -t FACP | ./acpixtract | ./acpitbl
 #
 
 ($ME = $0) =~ s|.*/||;
diff -u -ur pmtools-20050804/acpidump/acpixtract pmtools/acpidump/acpixtract
--- pmtools-20050804/acpidump/acpixtract	2003-12-10 09:50:40.000000000 -0700
+++ pmtools/acpidump/acpixtract	2005-08-16 14:31:09.000000000 -0600
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 #
-# acpixtract - extract raw table from acpidmp output
+# acpixtract - extract raw table from acpidump output
 #
 # Example: cat mail.txt | ./acpixtract DSDT > DSDT
 # iasl -d DSDT


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
