From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: Tue, 28 Oct 2003 21:42:45 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84DAF@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi,
Sorry, I made a mistake. should be this one.
Because ECDT unusually has similar info with EC. Changing the context =
should not cause problem.=20

--- ec.c	2003-10-09 03:24:07.000000000 +0800
+++ ec.c.new	2003-10-28 21:29:51.000000000 +0800
@@ -93,7 +93,7 @@
=20
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
-
+static struct acpi_device *ec_context;
 /* =
-------------------------------------------------------------------------=
-
                              Transaction Management
    =
-------------------------------------------------------------------------=
- */
@@ -342,7 +342,7 @@
 acpi_ec_gpe_query (
 	void			*ec_cxt)
 {
-	struct acpi_ec		*ec =3D (struct acpi_ec *) ec_cxt;
+	struct acpi_ec		*ec =3D ec_context;
 	u32			value =3D 0;
 	unsigned long		flags =3D 0;
 	static char		object_name[5] =3D {'_','Q','0','0','\0'};
@@ -581,7 +581,7 @@
 	sprintf(acpi_device_name(device), "%s", ACPI_EC_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_EC_CLASS);
 	acpi_driver_data(device) =3D ec;
-
+	ec_context =3D ec;
 	/* Use the global lock for all EC transactions? */
 	acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
=20
@@ -793,7 +793,7 @@
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock =3D TRUE;
 	ec_ecdt->uid =3D ecdt_ptr->uid;
-
+	ec_context =3D ec_ecdt;
 	status =3D acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
 	if (ACPI_FAILURE(status)) {
 		goto error;


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
