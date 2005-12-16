From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] make acpi_path_name() global
Date: Thu, 15 Dec 2005 17:20:09 -0800
Message-ID: <20051215172009.2eb3c3b4.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Make acpi_path_name() usable by everyone.
I need this for adding SATA suspend/resume ACPI support.

Note:
This function is now a memory allocator and callers should kfree()
the memory when done with it.  It doesn't seem safe to me to leave
it as returning a pointer to a static buffer (as it was in multiple
cloned copies) as we add callers to it.


Signed-off-by: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/osl.c      |   29 +++++++++++++++++++++++++++++
 include/acpi/acpiosxf.h |    2 ++
 2 files changed, 31 insertions(+)

--- linux-2615-rc5g5.orig/drivers/acpi/osl.c
+++ linux-2615-rc5g5/drivers/acpi/osl.c
@@ -1078,6 +1078,35 @@ void acpi_os_release_lock(acpi_handle ha
 	spin_unlock_irqrestore((spinlock_t *) handle, flags);
 }
 
+/**
+ * acpi_path_name - get ACPI path_name for the given handle
+ * @handle: ACPI object handle to look up name of
+ *
+ * Allocates memory if successul.  Caller must free the memory.
+ *
+ * Returns: pointer to path_name if successful, NULL if not.
+ */
+u8 *acpi_path_name(acpi_handle handle)
+{
+	acpi_status		status;
+	static u8		*path_name;
+	struct acpi_buffer	ret_buf = {ACPI_PATHNAME_MAX, path_name};
+
+	path_name = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	if (!path_name)
+		return NULL;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
+
+	if (ACPI_FAILURE(status)) {
+		acpi_os_free(path_name);
+		return NULL;
+	}
+
+	return path_name;
+}
+EXPORT_SYMBOL(acpi_path_name);
+
 #ifndef ACPI_USE_LOCAL_CACHE
 
 /*******************************************************************************
--- linux-2615-rc5g5.orig/include/acpi/acpiosxf.h
+++ linux-2615-rc5g5/include/acpi/acpiosxf.h
@@ -112,6 +112,8 @@ unsigned long acpi_os_acquire_lock(acpi_
 
 void acpi_os_release_lock(acpi_handle handle, unsigned long flags);
 
+u8 *acpi_path_name(acpi_handle handle);
+
 /*
  * Memory allocation and mapping
  */


---


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
