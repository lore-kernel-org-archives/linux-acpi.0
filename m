From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IBM Thinkpad problem please give INFO
Date: Wed, 13 Aug 2003 11:37:21 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720AD7@pdsmsx403.ccr.corp.intel.com>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Ruben Puettmann <ruben-BMzfhW7wj34cWVvVuXF20w@public.gmane.org>
Cc: usb-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Would you please test below patch.

diff -ur linux-2.4.21-20.1.2024.2.1.nptl/drivers/acpi/ec.c =
linux-2.4.21-20.1.2024.2.1.nptl.patch/drivers/acpi/ec.c
--- linux-2.4.21-20.1.2024.2.1.nptl/drivers/acpi/ec.c	2003-07-11 =
17:55:05.000000000 +0800
+++ linux-2.4.21-20.1.2024.2.1.nptl.patch/drivers/acpi/ec.c	2003-08-01 =
08:25:49.000000000 +0800
@@ -33,7 +33,7 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-
+#include <acpi/actypes.h>
=20
 #define _COMPONENT		ACPI_EC_COMPONENT
 ACPI_MODULE_NAME		("acpi_ec")
@@ -408,7 +408,8 @@
 	 * The EC object is in the handler context and is needed
 	 * when calling the acpi_ec_space_handler.
 	 */
-	*return_context =3D handler_context;
+	if(function =3D=3D ACPI_REGION_DEACTIVATE) *return_context =3D NULL;
+        else *return_context =3D handler_context;
=20
 	return AE_OK;
 }
diff -ur linux-2.4.21-20.1.2024.2.1.nptl/drivers/acpi/events/evregion.c =
linux-2.4.21-20.1.2024.2.1.nptl.patch/drivers/acpi/events/evregion.c
--- linux-2.4.21-20.1.2024.2.1.nptl/drivers/acpi/events/evregion.c	=
2003-07-11 17:55:05.000000000 +0800
+++ linux-2.4.21-20.1.2024.2.1.nptl.patch/drivers/acpi/events/evregion.c	=
2003-08-01 08:26:43.000000000 +0800
@@ -382,7 +382,7 @@
 	union acpi_operand_object       *obj_desc;
 	union acpi_operand_object       **last_obj_ptr;
 	acpi_adr_space_setup            region_setup;
-	void                            *region_context;
+	void                            **region_context;
 	union acpi_operand_object       *region_obj2;
 	acpi_status                     status;
=20
@@ -394,7 +394,7 @@
 	if (!region_obj2) {
 		return_VOID;
 	}
-	region_context =3D region_obj2->extra.region_context;
+	region_context =3D &region_obj2->extra.region_context;
=20
 	/* Get the address handler from the region object */
=20
@@ -450,7 +450,7 @@
=20
 			region_setup =3D handler_obj->address_space.setup;
 			status =3D region_setup (region_obj, ACPI_REGION_DEACTIVATE,
-					  handler_obj->address_space.context, &region_context);
+					  handler_obj->address_space.context, region_context);
=20
 			/* Init routine may fail, Just ignore errors */
=20


-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
Sent: 2003?8?13? 6:45
To: Ruben Puettmann
Cc: usb-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] IBM Thinkpad problem please give INFO


Hi!

> I found here many people with acpi problems on ibm thinkpads:
>=20
> Most /proc/acpi/something is empty.
> And there are many error messages on boot like :
>=20
> ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
>=20
>=20
> Is here no developer who can give any information what is wrong? Is it =
a
> linux bug or something wrong in the bios?

See my message cc-ed to Jan Hubicka; seems embedded controller adress
is very wrong...
								Pavel
--=20
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/=
01
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
