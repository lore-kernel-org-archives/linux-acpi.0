From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: Tue, 28 Oct 2003 20:33:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FDC1@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
Cc: =?GB2312?B?U6imcmdpbyBNb250ZWlybyBCYXN0bw==?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
> Sent: 2003=C4=EA10=D4=C228=C8=D5 18:04
> To: Li, Shaohua
> Cc: S=A8=A6rgio Monteiro Basto; Karol Kozimor; acpi-devel
> Subject: Re: [ACPI] 2.6.0-test9 regression: panic on Fn+F7 hotkey
>=20
> On Tue, Oct 28, 2003 at 04:14:56PM +0800, Li, Shaohua wrote:
> > Hi,
> >
> > I missed non-ECDT situation. Try this one.
> >
>=20
> Please don't apply.  This is not OK.  You missed the
> point that an interrupt handler can not sleep.  Anyway,
> from my point-of-view, ec.c is not buggy, but
> events/exviface.c::acpi_remove_.*().
>=20
> IMHO, we should have our own acpi workqueue, at first, and
> then wait for completion when removing any events handlers.
> Those, the correct fix should be in osl.c, and in events/evxface.c
> calling this wait for completition implemented in osl.c.

   yes, I know it's a bad idea to execute GPE query in interrupt =
handler. I do such thing is because this situation is rare. The =
interrupts seldom occur before EC device is initialized.=20

   But even though acpi has own workqueue, When replace ECDT with EC, we =
still have a wrong context.=20

   I think a better solution is when replace ECDT with EC, we can change =
the context in the event queue. Or we can use indirectly accessed =
context. Like this:

--- ec.c	2003-10-09 03:24:07.000000000 +0800
+++ ec.c.new	2003-10-28 20:17:05.643232728 +0800
@@ -93,7 +93,7 @@
=20
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
-
+static struct acpi_device *ec_context =3D NULL;
 /* =
-------------------------------------------------------------------------=
-
                              Transaction Management
    =
-------------------------------------------------------------------------=
- */
@@ -386,7 +386,7 @@
 	void			*data)
 {
 	acpi_status		status =3D AE_OK;
-	struct acpi_ec		*ec =3D (struct acpi_ec *) data;
+	struct acpi_ec		*ec =3D ec_context;
=20
 	if (!ec)
 		return;
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


In general, ECDT includes similar info as EC device. does this one make =
sense?

Thanks,
shaohua


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
