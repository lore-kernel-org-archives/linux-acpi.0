From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: ACPI PCI bus mismatch ?
Date: Tue, 11 Feb 2003 18:55:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211175512.GO25625@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84713802A@orsmsx401.jf.intel.com> <20030210161754.GI25625@poup.poupinou.org> <3E47EBAF.1040103@alvie.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Sr1nOIr3CvdE5hEN"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E47EBAF.1040103-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alvaro,

On Mon, Feb 10, 2003 at 06:13:03PM +0000, Alvaro Lopes wrote:
> Ducrot Bruno wrote:
> 
> >Hi!
> >
> >On Thu, Feb 06, 2003 at 12:39:43PM -0800, Grover, Andrew wrote:
> > 
> >
> >>>From: Alvaro Lopes [mailto:alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org] 
> >>>OK, I tracked the problem down to acpi_os_derive_pci_id(). If 
> >>>I remove 
> >>>the call to acpi_os_derive_pci_id() in 
> >>>acpi_ev_pci_config_region_setup() 
> >>>it works fine.
> >>>
> >>>Will do some tests on 2.5.x now and let you know.
> >>>     
> >>>
> >>Grrreat.
> >>
> >>We stuck that code in because some IA64 systems needed it to work.
> >>
> >>Sounds like we need to re-think all this. A hack for right now might be
> >>to only call derive on IA64 boxes.
> >>   
> >>
> >
> >
> >It is KO for me.
> >
> >I sticked:
> >printk(KERN_DEBUG "BEFORE: 0x%x 0x%x 0x%x 0x%x\n", pci_id->segment, 
> >pci_id->bus,
> >                                                  pci_id->device, 
> >                                                  pci_id->function);
> >acpi_os_derive_pci_id(...);
> >printk(KERN_DEBUG "AFTER: 0x%x 0x%x 0x%x 0x%x\n", pci_id->segment, 
> >pci_id->bus,
> >                                                  pci_id->device, 
> >                                                  pci_id->function);
> >
> >in drivers/acpi/events/evrgnini.c::ev_pci_config_region_setup()
> >
> >and it show me that pci_id->bus is *always* 0 at BEFORE, and will be
> >correct in AFTER (tested by creating 2 OPs, in fact).
> > 
> >
> Perhaps a stupid question, but:
> 
> If we are reading the busID for the brigde itself, shouldn't we use the 
> "Primary bus number" @ 0x18, instead of "Secondary bus number" @ 0x19 ?
> 

Could you please try this patch (for 2.5 series) ?

The first chunk is rejected for 2.4 though, but it is trivial
to do it by hand.

(hem, it is ugly, I know, there is for now no simple solution to
do it)

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi_derive_pci_id_fix-2.5.diff"

--- linux-2.5/drivers/acpi/osl.c	2003/02/10 23:43:24	1.1
+++ linux-2.5/drivers/acpi/osl.c	2003/02/11 17:46:39
@@ -502,11 +504,17 @@
 }
 
 /* TODO: Change code to take advantage of driver model more */
-void
-acpi_os_derive_pci_id (
+/*
+ * Some DSDT try to access OP really early (_STA).
+ * What if PCI subsystem is not initialized by firmware at this stage?
+ */
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
@@ -517,7 +525,7 @@
 
 	acpi_get_parent(chandle, &handle);
 	if (handle != rhandle) {
-		acpi_os_derive_pci_id(rhandle, handle, &pci_id);
+		acpi_os_derive_pci_id_2(rhandle, handle, &pci_id, is_bridge, bus_number);
 
 		status = acpi_get_type(handle, &type);
 		if ( (ACPI_FAILURE(status)) || (type != ACPI_TYPE_DEVICE) )
@@ -528,15 +536,41 @@
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
+					return;
+				}
+				*is_bridge = 1;
+				pci_id->bus = tu8;
 				status = acpi_os_read_pci_configuration(pci_id, 0x19, &tu8, 8);
-				if (ACPI_SUCCESS(status))
-					pci_id->bus = tu8;
+				if (ACPI_SUCCESS(status)) {
+					*bus_number = tu8;
+				}
+			} else {
+				if (!ACPI_SUCCESS(status))
+				*is_bridge = 0;
 			}
 		}
 	}
+}
+
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
 }
 
 #else /*!CONFIG_ACPI_PCI*/

--Sr1nOIr3CvdE5hEN--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
