From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: ACPI mode change...
Date: Fri, 26 Jul 2002 20:14:01 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726195500.3429.T-KOUCHI@mvf.biglobe.ne.jp>
References: <59885C5E3098D511AD690002A5072D3C07990D87@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C07990D87-OU+JdkIUtvcLll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: alex_williamson-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org, willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Thu, 25 Jul 2002 17:03:21 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org]=20
> > Okay, I'll change the viewpoint.  Forget about my last argument:)
> >=20
> > From the name of acpi_enable() and acpi_disable() API,
> > one will assume they correspond to ACPI_ENABLE
> > and ACPI_DISABLE of FADT.  But actual behavior is not.
> > It's misleading.
>=20
> [snip]
>=20
> OK I agree.
>=20
> Send me a patch that does what you described and I'll apply it.
>=20
> (What, you thought *I* was going to do it? ;-)

Here it is:)

* bus.c
	- minor fix ("ACPI" -> ACPI_BUS_FILE_ROOT)

* events/evevent.c
	- minor fix (function name for debugging was wrong)

* events/evmisc.c
	acpi_ev_terminate()
	- disables all fixed events and GPEs, removes SCI
	  handler and calls acpi_disable() if necessary

* events/evxfevnt.c
	acpi_enable()
	- check FADT rather than DSDT
	- move acpi_gbl_original_mode out of this function
	acpi_disable()
	- check FADT rather than DSDT
	- transition to LEGACY mode rather than to acpi_gbl_original_mode

* hardware/hwacpi.c
	acpi_hw_set_mode()
	- check FADT's SMI_CMD
	- check FADT's ACPI_ENABLE and ACPI_DISABLE

* utilities/utinit.c
	acpi_ut_subsystem_shutdown
	- changed order between acpi_ns_terminate and acpi_ev_terminate
	  (as acpi_ev_terminate requires FADT is present)

* utilities/utxface.c
	acpi_enable_subsystem
	- records acpi_gbl_original_mode here

=2E.. And noticed as follows:

* acpi_enable() and acpi_disable() behave differently from what's
  described in ACPI CA Programmer Reference, even before my change.

  From description of AcpiEnable (Rev 1.13, page 90):

|This function enables ACPI mode on the host computer system.=20
|It ensures that the system control interrupt (SCI) is properly
|configured, disables SCI event sources, installs the SCI handler,
|and transfers the system hardware into ACPI mode.

  It does only "transfers the system hardware into ACPI mode" and
  SCI stuff is done in other functions.

  Eventually, exporting acpi_enable() and acpi_disable() APIs to
  outer world is somewhat meanless...

* Now acpi_terminate() is rarely called because ACPI Bus Manager
  can't be complied as a module... Ouch.
  But I modified bus.c and made sure acpi_terminate works correctly.

  bus.c and other components are currently mutually-dependent
  (for example, acpi_bus_exit function calls other components'
   exit functions)  and both can't be compiled as modules.
  As many things are now dependent on ACPI Bus manager's
  existence, it seems hard to make it modular, but
  should be resolved in the future (near or far?)...


diff -Nura -x *~ 0725-orig/drivers/acpi/bus.c 0725-enable/drivers/acpi/bus.=
c
--- 0725-orig/drivers/acpi/bus.c	Fri Jul 26 10:54:46 2002
+++ 0725-enable/drivers/acpi/bus.c	Fri Jul 26 19:01:10 2002
@@ -2051,7 +2051,7 @@
=20
 	/* Mimic structured exception handling */
 error4:
-	remove_proc_entry("ACPI", NULL);
+	remove_proc_entry(ACPI_BUS_FILE_ROOT, NULL);
 error3:
 	acpi_bus_remove(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 error2:
diff -Nura -x *~ 0725-orig/drivers/acpi/events/evevent.c 0725-enable/driver=
s/acpi/events/evevent.c
--- 0725-orig/drivers/acpi/events/evevent.c	Fri Jul 26 10:54:46 2002
+++ 0725-enable/drivers/acpi/events/evevent.c	Fri Jul 26 13:54:12 2002
@@ -104,7 +104,7 @@
 	acpi_status             status;
=20
=20
-	ACPI_FUNCTION_TRACE ("Ev_initialize");
+	ACPI_FUNCTION_TRACE ("Ev_handler_initialize");
=20
=20
 	/* Install the SCI handler */
diff -Nura -x *~ 0725-orig/drivers/acpi/events/evmisc.c 0725-enable/drivers=
/acpi/events/evmisc.c
--- 0725-orig/drivers/acpi/events/evmisc.c	Fri Jul 26 10:54:46 2002
+++ 0725-enable/drivers/acpi/events/evmisc.c	Fri Jul 26 18:48:54 2002
@@ -552,9 +552,56 @@
 void
 acpi_ev_terminate (void)
 {
+	NATIVE_UINT_MAX32	i;
+	acpi_status		status;
=20
 	ACPI_FUNCTION_TRACE ("Ev_terminate");
=20
+
+	/*
+	 * Disable all fixed events
+	 */
+	for (i =3D 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+		status =3D acpi_disable_event (i, ACPI_EVENT_FIXED, 0);
+		if (ACPI_FAILURE (status)) {
+			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to disable fixed event %d.\n"=
, i));
+			/* just continue */
+		}
+	}
+
+	/*
+	 * Disable all GPEs
+	 */
+	for (i =3D 0; i < acpi_gbl_gpe_number_max; i++) {
+		if (acpi_ev_get_gpe_number_index (i) !=3D ACPI_GPE_INVALID) {
+			status =3D acpi_hw_disable_gpe (i);
+
+			if (ACPI_FAILURE (status)) {
+				ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to disable GPE %d.\n", i));
+				/* just continue */
+			}
+		}
+	}
+
+	/*
+	 * Remove SCI handler
+	 */
+	status =3D acpi_ev_remove_sci_handler ();
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Unable to remove SCI handler.\n"));
+		/* just continue */
+	}
+
+	/*
+	 * Return to original mode if necessary
+	 */
+	if (acpi_gbl_original_mode =3D=3D ACPI_SYS_MODE_LEGACY) {
+		status =3D acpi_disable ();
+		if (ACPI_FAILURE (status)) {
+			ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "Acpi_disable failed.\n"));
+			/* just continue */
+		}
+	}
=20
 	/*
 	 * Free global tables, etc.
diff -Nura -x *~ 0725-orig/drivers/acpi/events/evxfevnt.c 0725-enable/drive=
rs/acpi/events/evxfevnt.c
--- 0725-orig/drivers/acpi/events/evxfevnt.c	Fri Jul 26 10:54:46 2002
+++ 0725-enable/drivers/acpi/events/evxfevnt.c	Fri Jul 26 19:32:43 2002
@@ -52,16 +52,14 @@
 	ACPI_FUNCTION_TRACE ("Acpi_enable");
=20
=20
-	/* Make sure we have ACPI tables */
+	/* Make sure we have FADT */
=20
-	if (!acpi_gbl_DSDT) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "No ACPI tables present!\n"));
+	if (!acpi_gbl_FADT) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "No FADT information present!\n"));
 		return_ACPI_STATUS (AE_NO_ACPI_TABLES);
 	}
=20
-	acpi_gbl_original_mode =3D acpi_hw_get_mode ();
-
-	if (acpi_gbl_original_mode =3D=3D ACPI_SYS_MODE_ACPI) {
+	if (acpi_hw_get_mode () =3D=3D ACPI_SYS_MODE_ACPI) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_OK, "Already in ACPI mode.\n"));
 	}
 	else {
@@ -88,8 +86,7 @@
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Returns the system to original ACPI/legacy mode, and
- *              uninstalls the SCI interrupt handler.
+ * DESCRIPTION: Transfers the system into LEGACY mode.
  *
  *************************************************************************=
*****/
=20
@@ -102,19 +99,28 @@
 	ACPI_FUNCTION_TRACE ("Acpi_disable");
=20
=20
-	if (acpi_hw_get_mode () !=3D acpi_gbl_original_mode) {
-		/* Restore original mode  */
+	/* Make sure we have FADT */
=20
-		status =3D acpi_hw_set_mode (acpi_gbl_original_mode);
+	if (!acpi_gbl_FADT) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "No FADT information present!\n"));
+		return_ACPI_STATUS (AE_NO_ACPI_TABLES);
+	}
+
+	if (acpi_hw_get_mode () =3D=3D ACPI_SYS_MODE_LEGACY) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_OK, "Already in LEGACY mode.\n"));
+	}
+	else {
+		/* Transition to LEGACY mode */
+
+		status =3D acpi_hw_set_mode (ACPI_SYS_MODE_LEGACY);
 		if (ACPI_FAILURE (status)) {
-			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Unable to transition to original mod=
e"));
+			ACPI_DEBUG_PRINT ((ACPI_DB_FATAL, "Could not transition to LEGACY mode.=
\n"));
 			return_ACPI_STATUS (status);
 		}
-	}
=20
-	/* Unload the SCI interrupt handler  */
+		ACPI_DEBUG_PRINT ((ACPI_DB_OK, "Transition to LEGACY mode successful\n")=
);
+	}
=20
-	status =3D acpi_ev_remove_sci_handler ();
 	return_ACPI_STATUS (status);
 }
=20
diff -Nura -x *~ 0725-orig/drivers/acpi/hardware/hwacpi.c 0725-enable/drive=
rs/acpi/hardware/hwacpi.c
--- 0725-orig/drivers/acpi/hardware/hwacpi.c	Fri Jul 26 10:54:46 2002
+++ 0725-enable/drivers/acpi/hardware/hwacpi.c	Fri Jul 26 19:32:25 2002
@@ -96,6 +96,28 @@
=20
 	ACPI_FUNCTION_TRACE ("Hw_set_mode");
=20
+	/*
+	 * ACPI 2.0 clarified that if SMI_CMD in FADT is zero,
+	 * system does not support mode transition.
+	 */
+	if (!acpi_gbl_FADT->smi_cmd) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "No SMI_CMD in FADT, mode transition f=
ailed.\n"));=20
+		return_ACPI_STATUS (AE_NO_HARDWARE_RESPONSE);
+	}
+
+	/*
+	 * ACPI 2.0 clarified the meaning of ACPI_ENABLE and ACPI_DISABLE
+	 * in FADT: If it is zero, enabling or disabling is not supported.
+	 * As old systems may have used zero for mode transition,
+	 * we make sure both the numbers are zero to determine these
+	 * transitions are not supported.
+	 */
+
+	if (!acpi_gbl_FADT->acpi_enable && !acpi_gbl_FADT->acpi_disable) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "No mode transition supported in this s=
ystem.\n"));
+		return_ACPI_STATUS (AE_OK);
+	}
+
 	switch (mode) {
 	case ACPI_SYS_MODE_ACPI:
=20
diff -Nura -x *~ 0725-orig/drivers/acpi/utilities/utinit.c 0725-enable/driv=
ers/acpi/utilities/utinit.c
--- 0725-orig/drivers/acpi/utilities/utinit.c	Fri Jul 26 10:54:47 2002
+++ 0725-enable/drivers/acpi/utilities/utinit.c	Fri Jul 26 18:09:56 2002
@@ -198,13 +198,13 @@
 	acpi_gbl_shutdown =3D TRUE;
 	ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "Shutting down ACPI Subsystem...\n"));
=20
-	/* Close the Namespace */
-
-	acpi_ns_terminate ();
-
 	/* Close the Acpi_event Handling */
=20
 	acpi_ev_terminate ();
+
+	/* Close the Namespace */
+
+	acpi_ns_terminate ();
=20
 	/* Close the globals */
=20
diff -Nura -x *~ 0725-orig/drivers/acpi/utilities/utxface.c 0725-enable/dri=
vers/acpi/utilities/utxface.c
--- 0725-orig/drivers/acpi/utilities/utxface.c	Fri Jul 26 10:54:47 2002
+++ 0725-enable/drivers/acpi/utilities/utxface.c	Fri Jul 26 13:54:23 2002
@@ -159,6 +159,8 @@
 	if (!(flags & ACPI_NO_ACPI_ENABLE)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "[Init] Going into ACPI mode\n"));
=20
+		acpi_gbl_original_mode =3D acpi_hw_get_mode();
+
 		status =3D acpi_enable ();
 		if (ACPI_FAILURE (status)) {
 			ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "Acpi_enable failed.\n"));


Thanks,
--=20
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
