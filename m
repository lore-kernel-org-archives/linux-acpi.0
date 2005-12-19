From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] make acpi_path_name() global (v2)
Date: Mon, 19 Dec 2005 11:54:35 -0800
Message-ID: <20051219115435.13ea7bed.randy_d_dunlap@linux.intel.com>
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
Cc: kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Make acpi_path_name() usable by everyone.
I need this for adding SATA suspend/resume ACPI support.

Signed-off-by: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/osl.c      |   21 +++++++++++++++++++++
 include/acpi/acpiosxf.h |    2 ++
 2 files changed, 23 insertions(+)

--- linux-2615-rc6-acpi.orig/drivers/acpi/osl.c
+++ linux-2615-rc6-acpi/drivers/acpi/osl.c
@@ -1078,6 +1078,27 @@ void acpi_os_release_lock(acpi_handle ha
 	spin_unlock_irqrestore((spinlock_t *) handle, flags);
 }
 
+/**
+ * acpi_path_name - get ACPI path_name for the given handle
+ * @handle: ACPI object handle to look up name of
+ * @namebuf: acpi_buffer with input flags and output name
+ *
+ * Caller can allocate & free the output name buffer or can set
+ * namebuf.length to ACPI_ALLOCATE_BUFFER to have ACPI-CA allocate
+ * the buffer but caller is still responsible for freeing it.
+ *
+ * Returns: status of acpi_get_name()
+ */
+acpi_status acpi_path_name(acpi_handle handle, struct acpi_buffer *namebuf)
+{
+	acpi_status		status;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, namebuf);
+
+	return_ACPI_STATUS(status);
+}
+EXPORT_SYMBOL(acpi_path_name);
+
 #ifndef ACPI_USE_LOCAL_CACHE
 
 /*******************************************************************************
--- linux-2615-rc6-acpi.orig/include/acpi/acpiosxf.h
+++ linux-2615-rc6-acpi/include/acpi/acpiosxf.h
@@ -112,6 +112,8 @@ unsigned long acpi_os_acquire_lock(acpi_
 
 void acpi_os_release_lock(acpi_handle handle, unsigned long flags);
 
+acpi_status acpi_path_name(acpi_handle handle, struct acpi_buffer *namebuf);
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
