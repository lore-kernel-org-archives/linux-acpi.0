From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: acpi_os_derive_pci_id() still broken.
Date: Tue, 25 Feb 2003 14:08:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030225130835.GF13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

osl::acpi_os_derive_pci_id() is still broken.


I recall that it close a lot of bugs related
to PCI_config regions, as for example a keventd stuck
at 100% (thanks go to Alvaro Lopez), and some _STA and
_INI failed (I do not remember the actual problem, though,
but was related to PCI_Config OPs already found, and/or
not found, etc.)

If there is a trouble with this patch (design, etc.),
then let me know, thanks.



--- linux-2.4/drivers/acpi/osl.c	Tue Feb 25 13:33:54 2003
+++ linux-2.4/drivers/acpi/osl.c	Thu Feb 13 02:03:44 2003
@@ -504,11 +493,13 @@
 	return (result ? AE_ERROR : AE_OK);
 }
 
-void
-acpi_os_derive_pci_id (
+static void
+acpi_os_derive_pci_id_2 (
 	acpi_handle		rhandle,        /* upper bound  */
 	acpi_handle		chandle,        /* current node */
-	struct acpi_pci_id	**id)
+	struct acpi_pci_id	**id,
+	int			*is_bridge,
+	u8			*bus_number)
 {
 	acpi_handle		handle;
 	struct acpi_pci_id	*pci_id = *id;
@@ -519,7 +510,7 @@
 
 	acpi_get_parent(chandle, &handle);
 	if (handle != rhandle) {
-		acpi_os_derive_pci_id(rhandle, handle, &pci_id);
+		acpi_os_derive_pci_id_2(rhandle, handle, &pci_id, is_bridge, bus_number);
 
 		status = acpi_get_type(handle, &type);
 		if ( (ACPI_FAILURE(status)) || (type != ACPI_TYPE_DEVICE) )
@@ -530,17 +521,42 @@
 			pci_id->device  = ACPI_HIWORD (ACPI_LODWORD (temp));
 			pci_id->function = ACPI_LOWORD (ACPI_LODWORD (temp));
 
+			if (*is_bridge)
+				pci_id->bus = *bus_number;
+
 			/* any nicer way to get bus number of bridge ? */
 			status = acpi_os_read_pci_configuration(pci_id, 0x0e, &tu8, 8);
-			if (ACPI_SUCCESS(status) && (tu8 & 0x7f) == 1) {
+			if (ACPI_SUCCESS(status) &&
+			    ((tu8 & 0x7f) == 1 || (tu8 & 0x7f) == 2)) {
+				status = acpi_os_read_pci_configuration(pci_id, 0x18, &tu8, 8);
+				if (!ACPI_SUCCESS(status)) {
+					/* Certainly broken...  FIX ME */
+					return;
+				}
+				*is_bridge = 1;
+				pci_id->bus = tu8;
 				status = acpi_os_read_pci_configuration(pci_id, 0x19, &tu8, 8);
-				if (ACPI_SUCCESS(status))
-					pci_id->bus = tu8;
-			}
+				if (ACPI_SUCCESS(status)) {
+					*bus_number = tu8;
+				}
+			} else
+				*is_bridge = 0;
 		}
 	}
 }
 
+void
+acpi_os_derive_pci_id (
+	acpi_handle		rhandle,        /* upper bound  */
+	acpi_handle		chandle,        /* current node */
+	struct acpi_pci_id	**id)
+{
+	int is_bridge = 1;
+	u8 bus_number = (*id)->bus;
+
+	acpi_os_derive_pci_id_2(rhandle, chandle, id, &is_bridge, &bus_number);
+}
+
 #else /*!CONFIG_ACPI_PCI*/
 
 acpi_status



Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
