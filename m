From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] convert acpi_path_name() callers (v2)
Date: Mon, 19 Dec 2005 11:54:22 -0800
Message-ID: <20051219115422.6fc105be.randy_d_dunlap@linux.intel.com>
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
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Convert the callers of local acpi_path_name() functions to use
the exported version of it.

Signed-off-by: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/pci/hotplug/pciehprm_acpi.c |   56 ++++++++++++++++++------------------
 drivers/pci/hotplug/shpchprm_acpi.c |   43 ++++++++++++---------------
 2 files changed, 47 insertions(+), 52 deletions(-)

--- linux-2615-rc6-acpi.orig/drivers/pci/hotplug/pciehprm_acpi.c
+++ linux-2615-rc6-acpi/drivers/pci/hotplug/pciehprm_acpi.c
@@ -38,21 +38,6 @@
 #define	METHOD_NAME__HPP	"_HPP"
 #define	METHOD_NAME_OSHP	"OSHP"
 
-static u8 * acpi_path_name( acpi_handle	handle)
-{
-	acpi_status		status;
-	static u8		path_name[ACPI_PATHNAME_MAX];
-	struct acpi_buffer	ret_buf = { ACPI_PATHNAME_MAX, path_name };
-
-	memset(path_name, 0, sizeof (path_name));
-	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
-
-	if (ACPI_FAILURE(status))
-		return NULL;
-	else
-		return path_name;	
-}
-
 static acpi_status
 acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
 {
@@ -60,8 +45,11 @@ acpi_run_hpp(acpi_handle handle, struct 
 	u8			nui[4];
 	struct acpi_buffer	ret_buf = { 0, NULL};
 	union acpi_object	*ext_obj, *package;
-	u8			*path_name = acpi_path_name(handle);
 	int			i, len = 0;
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname = namebuf.pointer;
+
+	acpi_path_name(handle, &namebuf);
 
 	/* get _hpp */
 	status = acpi_evaluate_object(handle, METHOD_NAME__HPP, NULL, &ret_buf);
@@ -70,7 +58,8 @@ acpi_run_hpp(acpi_handle handle, struct 
 		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
 		if (!ret_buf.pointer) {
 			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
-					path_name);
+					pathname);
+			acpi_os_free(namebuf.pointer);
 			return AE_NO_MEMORY;
 		}
 		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
@@ -80,7 +69,8 @@ acpi_run_hpp(acpi_handle handle, struct 
 	default:
 		if (ACPI_FAILURE(status)) {
 			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
-					path_name, status);
+					pathname, status);
+			acpi_os_free(namebuf.pointer);
 			return status;
 		}
 	}
@@ -88,7 +78,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 	ext_obj = (union acpi_object *) ret_buf.pointer;
 	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
 		err ("%s:%s _HPP obj not a package\n", __FUNCTION__,
-				path_name);
+				pathname);
 		status = AE_ERROR;
 		goto free_and_return;
 	}
@@ -103,7 +93,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 			break;
 		default:
 			err ("%s:%s _HPP obj type incorrect\n", __FUNCTION__,
-					path_name);
+					pathname);
 			status = AE_ERROR;
 			goto free_and_return;
 		}
@@ -120,23 +110,28 @@ acpi_run_hpp(acpi_handle handle, struct 
 	dbg("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
 
 free_and_return:
-	kfree(ret_buf.pointer);
+	acpi_os_free(ret_buf.pointer);
+	acpi_os_free(namebuf.pointer);
 	return status;
 }
 
 static acpi_status acpi_run_oshp(acpi_handle handle)
 {
 	acpi_status		status;
-	u8			*path_name = acpi_path_name(handle);
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname = namebuf.pointer;
+
+	acpi_path_name(handle, &namebuf);
 
 	/* run OSHP */
 	status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		dbg("%s:%s OSHP fails=0x%x\n", __FUNCTION__, path_name,
+		dbg("%s:%s OSHP fails=0x%x\n", __FUNCTION__, pathname,
 				status);
 	} else {
-		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
+		dbg("%s:%s OSHP passes\n", __FUNCTION__, pathname);
 	}
+	acpi_os_free(namebuf.pointer);
 	return status;
 }
 
@@ -174,7 +169,10 @@ int pciehp_get_hp_hw_control_from_firmwa
 	acpi_status status;
 	acpi_handle chandle, handle = DEVICE_ACPI_HANDLE(&(dev->dev));
 	struct pci_dev *pdev = dev;
-	u8 *path_name;
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status		namests;
+	char			*pathname = namebuf.pointer;
+
 	/*
 	 * Per PCI firmware specification, we should run the ACPI _OSC
 	 * method to get control of hotplug hardware before using it.
@@ -204,17 +202,19 @@ int pciehp_get_hp_hw_control_from_firmwa
 	}
 
 	while (handle) {
-		path_name = acpi_path_name(handle);
-		dbg("Trying to get hotplug control for %s \n", path_name);
+		namests = acpi_path_name(handle, &namebuf);
+		dbg("Trying to get hotplug control for %s\n", pathname);
 		status = pci_osc_control_set(handle,
 				OSC_PCI_EXPRESS_NATIVE_HP_CONTROL);
 		if (status == AE_NOT_FOUND)
 			status = acpi_run_oshp(handle);
 		if (ACPI_SUCCESS(status)) {
 			dbg("Gained control for hotplug HW for pci %s (%s)\n",
-				pci_name(dev), path_name);
+				pci_name(dev), pathname);
+			acpi_os_free(namebuf.pointer);
 			return 0;
 		}
+		acpi_os_free(namebuf.pointer);
 		if (is_root_bridge(handle))
 			break;
 		chandle = handle;
--- linux-2615-rc6-acpi.orig/drivers/pci/hotplug/shpchprm_acpi.c
+++ linux-2615-rc6-acpi/drivers/pci/hotplug/shpchprm_acpi.c
@@ -37,21 +37,6 @@
 #define	METHOD_NAME__HPP	"_HPP"
 #define	METHOD_NAME_OSHP	"OSHP"
 
-static u8 * acpi_path_name( acpi_handle	handle)
-{
-	acpi_status		status;
-	static u8	path_name[ACPI_PATHNAME_MAX];
-	struct acpi_buffer		ret_buf = { ACPI_PATHNAME_MAX, path_name };
-
-	memset(path_name, 0, sizeof (path_name));
-	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
-
-	if (ACPI_FAILURE(status))
-		return NULL;
-	else
-		return path_name;	
-}
-
 static acpi_status
 acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
 {
@@ -59,8 +44,11 @@ acpi_run_hpp(acpi_handle handle, struct 
 	u8			nui[4];
 	struct acpi_buffer	ret_buf = { 0, NULL};
 	union acpi_object	*ext_obj, *package;
-	u8			*path_name = acpi_path_name(handle);
 	int			i, len = 0;
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname = namebuf.pointer;
+
+	acpi_path_name(handle, &namebuf);
 
 	/* get _hpp */
 	status = acpi_evaluate_object(handle, METHOD_NAME__HPP, NULL, &ret_buf);
@@ -69,7 +57,8 @@ acpi_run_hpp(acpi_handle handle, struct 
 		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
 		if (!ret_buf.pointer) {
 			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
-					path_name);
+					pathname);
+			acpi_os_free(namebuf.pointer);
 			return AE_NO_MEMORY;
 		}
 		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
@@ -79,7 +68,8 @@ acpi_run_hpp(acpi_handle handle, struct 
 	default:
 		if (ACPI_FAILURE(status)) {
 			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
-					path_name, status);
+					pathname, status);
+			acpi_os_free(namebuf.pointer);
 			return status;
 		}
 	}
@@ -87,7 +77,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 	ext_obj = (union acpi_object *) ret_buf.pointer;
 	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
 		err ("%s:%s _HPP obj not a package\n", __FUNCTION__,
-				path_name);
+				pathname);
 		status = AE_ERROR;
 		goto free_and_return;
 	}
@@ -102,7 +92,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 			break;
 		default:
 			err ("%s:%s _HPP obj type incorrect\n", __FUNCTION__,
-					path_name);
+					pathname);
 			status = AE_ERROR;
 			goto free_and_return;
 		}
@@ -119,23 +109,28 @@ acpi_run_hpp(acpi_handle handle, struct 
 	dbg("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
 
 free_and_return:
-	kfree(ret_buf.pointer);
+	acpi_os_free(ret_buf.pointer);
+	acpi_os_free(namebuf.pointer);
 	return status;
 }
 
 static void acpi_run_oshp(acpi_handle handle)
 {
 	acpi_status		status;
-	u8			*path_name = acpi_path_name(handle);
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname = namebuf.pointer;
+
+	acpi_path_name(handle, &namebuf);
 
 	/* run OSHP */
 	status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		err("%s:%s OSHP fails=0x%x\n", __FUNCTION__, path_name,
+		err("%s:%s OSHP fails=0x%x\n", __FUNCTION__, pathname,
 				status);
 	} else {
-		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
+		dbg("%s:%s OSHP passes\n", __FUNCTION__, pathname);
 	}
+	acpi_os_free(namebuf.pointer);
 }
 
 int shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)


---


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
