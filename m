From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [patch] Add /proc/acpi/madt
Date: Mon, 14 Jul 2003 23:38:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307142338.25822.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hDzE/ssqzeRqJqL"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_hDzE/ssqzeRqJqL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, this small patch allows userspace dumping of /proc/acpi/madt, essential 
for my IRQ routing debugging.

Jurriaan, could you send me a binary dump from your machine please? Sorry 
about all the hassle; I hope I actually *fix* your problem sometime as well 
:)

--Boundary-00=_hDzE/ssqzeRqJqL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.75-procfs-madt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.5.75-procfs-madt.patch"

--- linux-2.5.75.orig/drivers/acpi/system.c	2003-07-10 21:11:00.000000000 +0100
+++ linux-2.5.75/drivers/acpi/system.c	2003-07-14 23:17:47.000000000 +0100
@@ -40,6 +40,7 @@
 #define ACPI_SYSTEM_FILE_EVENT		"event"
 #define ACPI_SYSTEM_FILE_DSDT		"dsdt"
 #define ACPI_SYSTEM_FILE_FADT		"fadt"
+#define ACPI_SYSTEM_FILE_MADT		"madt"
 
 extern FADT_DESCRIPTOR		acpi_fadt;
 
@@ -162,6 +163,50 @@
 	return_VALUE(size);
 }
 
+static ssize_t acpi_system_read_madt (struct file*, char*, size_t, loff_t*);
+
+static struct file_operations acpi_system_madt_ops = {
+	.read =			acpi_system_read_madt,
+};
+
+static ssize_t
+acpi_system_read_madt (
+	struct file		*file,
+	char			*buffer,
+	size_t			count,
+	loff_t			*ppos)
+{
+	acpi_status		status = AE_OK;
+	struct acpi_table_madt *madt;
+	void* raw_madt;
+	void			*data = 0;
+	size_t			size = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_system_read_madt");
+
+
+	status = acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,
+		(struct acpi_table_header **) &madt);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-ENODEV);
+	raw_madt = (void *) (unsigned long)madt;
+
+	if (*ppos < madt->header.length) {
+		data = raw_madt + file->f_pos;
+		size = madt->header.length - file->f_pos;
+		if (size > count)
+			size = count;
+		if (copy_to_user(buffer, data, size)) {
+			return_VALUE(-EFAULT);
+		}
+	}
+
+	*ppos += size;
+
+	return_VALUE(size);
+}
+
+
 
 static int __init acpi_system_init (void)
 {
@@ -197,6 +242,14 @@
 	else
 		goto Error;
 
+	/* 'madt' [R] */
+	name = ACPI_SYSTEM_FILE_MADT;
+	entry = create_proc_entry(name, S_IRUSR, acpi_root_dir);
+	if (entry)
+		entry->proc_fops = &acpi_system_madt_ops;
+	else
+		goto Error;
+
  Done:
 	return_VALUE(error);
 
@@ -205,6 +258,7 @@
 			 "Unable to create '%s' proc fs entry\n", name));
 
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
+	remove_proc_entry(ACPI_SYSTEM_FILE_MADT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
 

--Boundary-00=_hDzE/ssqzeRqJqL--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
