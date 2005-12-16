From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] convert acpi_path_name() callers
Date: Thu, 15 Dec 2005 17:20:18 -0800
Message-ID: <20051215172018.620988ae.randy_d_dunlap@linux.intel.com>
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

Convert the callers of local acpi_path_name() functions to use
the exported version of it.

Signed-off-by: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/pci/hotplug/pciehprm_acpi.c |   21 ++++++---------------
 drivers/pci/hotplug/shpchprm_acpi.c |   19 ++++---------------
 2 files changed, 10 insertions(+), 30 deletions(-)

--- linux-2615-rc5g5.orig/drivers/pci/hotplug/pciehprm_acpi.c
+++ linux-2615-rc5g5/drivers/pci/hotplug/pciehprm_acpi.c
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
@@ -71,6 +56,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (!ret_buf.pointer) {
 			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
 					path_name);
+			kfree(path_name);
 			return AE_NO_MEMORY;
 		}
 		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
@@ -81,6 +67,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (ACPI_FAILURE(status)) {
 			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
 					path_name, status);
+			kfree(path_name);
 			return status;
 		}
 	}
@@ -121,6 +108,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 
 free_and_return:
 	kfree(ret_buf.pointer);
+	kfree(path_name);
 	return status;
 }
 
@@ -137,6 +125,7 @@ static acpi_status acpi_run_oshp(acpi_ha
 	} else {
 		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
 	}
+	kfree(path_name);
 	return status;
 }
 
@@ -213,8 +202,10 @@ int pciehp_get_hp_hw_control_from_firmwa
 		if (ACPI_SUCCESS(status)) {
 			dbg("Gained control for hotplug HW for pci %s (%s)\n",
 				pci_name(dev), path_name);
+			kfree(path_name);
 			return 0;
 		}
+		kfree(path_name);
 		if (is_root_bridge(handle))
 			break;
 		chandle = handle;
--- linux-2615-rc5g5.orig/drivers/pci/hotplug/shpchprm_acpi.c
+++ linux-2615-rc5g5/drivers/pci/hotplug/shpchprm_acpi.c
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
@@ -70,6 +55,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (!ret_buf.pointer) {
 			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
 					path_name);
+			kfree(path_name);
 			return AE_NO_MEMORY;
 		}
 		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
@@ -80,6 +66,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (ACPI_FAILURE(status)) {
 			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
 					path_name, status);
+			kfree(path_name);
 			return status;
 		}
 	}
@@ -120,6 +107,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 
 free_and_return:
 	kfree(ret_buf.pointer);
+	kfree(path_name);
 	return status;
 }
 
@@ -136,6 +124,7 @@ static void acpi_run_oshp(acpi_handle ha
 	} else {
 		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
 	}
+	kfree(path_name);
 }
 
 int shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)


---


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
