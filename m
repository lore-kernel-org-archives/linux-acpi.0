From: =?iso-8859-1?Q?BERNARD_S=E9bastien?= <sebastien.bernard-3IMRC7uD7uXQT0dZR+AlfA@public.gmane.org>
Subject: RE : RE : N800v is fixed by patch-1690
Date: Mon, 5 Apr 2004 10:39:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3220CFEF35C7D61180EC0002A5438BB005B761EC@achille>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C41AE9.8AA86390"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: =?iso-8859-1?Q?BERNARD_S=E9bastien?= <sebastien.bernard-3IMRC7uD7uXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C41AE9.8AA86390
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.cegetel.fr id KAA16344

Ok, here is the infamous patch.
This one helps me a lot but it is not from me. I got it from the acpi how=
to
gentoo site.
So, don't ask me about any technical issues.
-------------------------------------------------------------------------=
---
diff -Bru 2.6/drivers/acpi/ec.c patched/drivers/acpi/ec.c
--- 2.6/drivers/acpi/ec.c	2003-12-17 18:22:49.000000000 +0800
+++ patched/drivers/acpi/ec.c	2003-12-17 18:26:40.000000000 +0800
@@ -94,6 +94,8 @@
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
=20
+extern int acpi_ec_need_reinit;
+
 /*
-------------------------------------------------------------------------=
-
                              Transaction Management
=20
-------------------------------------------------------------------------=
-
*/
@@ -732,6 +736,30 @@
 		return_VALUE(-ENODEV);
 	}
=20
+	if(acpi_ec_need_reinit){
+		/*
+		 * The device is present. Run _INI.
+	 	*/
+		ACPI_DEBUG_EXEC (acpi_ut_display_init_pathname
(ACPI_TYPE_METHOD, ec->handle, "_INI"));
+		status =3D acpi_ns_evaluate_relative (ec->handle, "_INI",
NULL, NULL);
+		if (ACPI_FAILURE (status)) {
+		/* No _INI (AE_NOT_FOUND) means device requires no
initialization */
+
+			if (status !=3D AE_NOT_FOUND) {
+				/* Ignore error and move on to next device
*/
+
+		#ifdef ACPI_DEBUG_OUTPUT
+				char                *scope_name =3D
acpi_ns_get_external_pathname (ec->handle);
+
+				ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "%s._INI
failed: %s\n",
+						scope_name,
acpi_format_exception (status)));
+
+				ACPI_MEM_FREE (scope_name);
+		#endif
+			}
+		}
+	}
+
 	return_VALUE(AE_OK);
 }
=20
diff -Bru 2.6/drivers/acpi/events/evregion.c
patched/drivers/acpi/events/evregion.c
--- 2.6/drivers/acpi/events/evregion.c	2003-12-17 18:22:55.000000000 +080=
0
+++ patched/drivers/acpi/events/evregion.c	2003-12-17
18:24:21.000000000 +0800
@@ -50,13 +50,14 @@
 #define _COMPONENT          ACPI_EVENTS
 	 ACPI_MODULE_NAME    ("evregion")
=20
-#define ACPI_NUM_DEFAULT_SPACES     4
+#define ACPI_NUM_DEFAULT_SPACES     5
=20
 u8
acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
 			 ACPI_ADR_SPACE_SYSTEM_MEMORY,
 			 ACPI_ADR_SPACE_SYSTEM_IO,
 			 ACPI_ADR_SPACE_PCI_CONFIG,
-			 ACPI_ADR_SPACE_DATA_TABLE};
+			 ACPI_ADR_SPACE_DATA_TABLE,
+			 ACPI_ADR_SPACE_EC};
=20
=20
=20
/************************************************************************=
***
****
diff -Bru 2.6/drivers/acpi/events/evxfregn.c
patched/drivers/acpi/events/evxfregn.c
--- 2.6/drivers/acpi/events/evxfregn.c	2003-12-17 18:22:32.000000000 +080=
0
+++ patched/drivers/acpi/events/evxfregn.c	2003-12-17
18:24:21.000000000 +0800
@@ -153,6 +153,11 @@
 			setup   =3D NULL;
 			break;
=20
+		case ACPI_ADR_SPACE_EC:
+			handler =3D acpi_ex_ec_space_handler;
+			setup   =3D NULL;
+			break;
+
 		default:
 			status =3D AE_BAD_PARAMETER;
 			goto unlock_and_exit;
diff -Bru 2.6/drivers/acpi/executer/exregion.c
patched/drivers/acpi/executer/exregion.c
--- 2.6/drivers/acpi/executer/exregion.c	2003-12-17
18:22:31.000000000 +0800
+++ patched/drivers/acpi/executer/exregion.c	2003-12-17
18:24:21.000000000 +0800
@@ -430,6 +430,24 @@
 }
=20
=20
+acpi_status
+acpi_ex_ec_space_handler (
+	u32                             function,
+	acpi_physical_address           address,
+	u32                             bit_width,
+	acpi_integer                    *value,
+	void                            *handler_context,
+	void                            *region_context)
+{
+	acpi_status                     status =3D AE_OK;
+
+
+	ACPI_FUNCTION_TRACE ("ex_ec_space_handler");
+
+	acpi_ec_need_reinit =3D TRUE;
+
+	return_ACPI_STATUS (status);
+}
=20
/************************************************************************=
***
****
  *
  * FUNCTION:    acpi_ex_pci_bar_space_handler
diff -Bru 2.6/drivers/acpi/utilities/utglobal.c
patched/drivers/acpi/utilities/utglobal.c
--- 2.6/drivers/acpi/utilities/utglobal.c	2003-12-17
18:22:29.000000000 +0800
+++ patched/drivers/acpi/utilities/utglobal.c	2003-12-17
18:24:21.000000000 +0800
@@ -877,6 +877,7 @@
 	acpi_gbl_root_node_struct.object    =3D NULL;
 	acpi_gbl_root_node_struct.flags     =3D ANOBJ_END_OF_PEER_LIST;
=20
+	acpi_ec_need_reinit		    =3D FALSE;
=20
 #ifdef ACPI_DEBUG_OUTPUT
 	acpi_gbl_lowest_stack_pointer       =3D ACPI_SIZE_MAX;
diff -Bru 2.6/include/acpi/acglobal.h patched/include/acpi/acglobal.h
--- 2.6/include/acpi/acglobal.h	2003-12-17 18:22:23.000000000 +0800
+++ patched/include/acpi/acglobal.h	2003-12-17 18:24:21.000000000 +0800
@@ -190,6 +190,8 @@
 extern const u8
acpi_gbl_ns_properties[NUM_NS_TYPES];
 extern const struct acpi_predefined_names       acpi_gbl_pre_defined_nam=
es
[NUM_PREDEFINED_NAMES];
=20
+ACPI_EXTERN int	acpi_ec_need_reinit;
+
 #ifdef ACPI_DEBUG_OUTPUT
 ACPI_EXTERN u32
acpi_gbl_current_node_count;
 ACPI_EXTERN u32                                 acpi_gbl_current_node_si=
ze;
diff -Bru 2.6/include/acpi/acinterp.h patched/include/acpi/acinterp.h
--- 2.6/include/acpi/acinterp.h	2003-12-17 18:23:07.000000000 +0800
+++ patched/include/acpi/acinterp.h	2003-12-17 18:24:21.000000000 +0800
@@ -699,6 +699,15 @@
 	void                            *region_context);
=20
 acpi_status
+acpi_ex_ec_space_handler (
+	u32                             function,
+	acpi_physical_address           address,
+	u32                             bit_width,
+	acpi_integer                    *value,
+	void                            *handler_context,
+	void                            *region_context);
+
+acpi_status
 acpi_ex_pci_bar_space_handler (
 	u32                             function,
 	acpi_physical_address           address,
-------------------------------------------------------------------------=
---

-----Message d'origine-----
De=A0: Pavel Machek [mailto:pavel-AlSwsSmVLrQ@public.gmane.org]=20
Envoy=E9=A0: vendredi 2 avril 2004 22:44
=C0=A0: BERNARD S=E9bastien
Objet=A0: Re: RE : [ACPI] N800v is fixed by patch-1690

Hi!

>    I reply to myself since noone answered the underlying question :
>    Is there any reason not to include the patch mentioned in my first
>    mail into the mainline.
>    This patch is helping a lot in my case.

Read Documentation/SubmittingPatches.txt,

6) No MIME, no links, no compression, no attachments.  Just plain
text.

in particular.

							Pavel

--=20
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

------_=_NextPart_001_01C41AE9.8AA86390
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE : RE : [ACPI] N800v is fixed by patch-1690</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Ok, here is the infamous patch.</FONT>
<BR><FONT SIZE=3D2>This one helps me a lot but it is not from me. I got =
it from the acpi howto gentoo site.</FONT>
<BR><FONT SIZE=3D2>So, don't ask me about any technical issues.</FONT>
<BR><FONT =
SIZE=3D2>---------------------------------------------------------------=
-------------</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/drivers/acpi/ec.c =
patched/drivers/acpi/ec.c</FONT>
<BR><FONT SIZE=3D2>--- =
2.6/drivers/acpi/ec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2003-12-17 =
18:22:49.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ patched/drivers/acpi/ec.c&nbsp;&nbsp; 2003-12-17 =
18:26:40.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -94,6 +94,8 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;/* External interfaces use first EC only, so =
remember */</FONT>
<BR><FONT SIZE=3D2>&nbsp;static struct acpi_device *first_ec;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+extern int acpi_ec_need_reinit;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>&nbsp;/* =
------------------------------------------------------------------------=
--</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transaction Management</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; =
------------------------------------------------------------------------=
-- */</FONT>
<BR><FONT SIZE=3D2>@@ -732,6 +736,30 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return_VALUE(-ENODEV);</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(acpi_ec_need_reinit){</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The device is =
present. Run _INI.</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI_DEBUG_EXEC =
(acpi_ut_display_init_pathname (ACPI_TYPE_METHOD, ec-&gt;handle, =
&quot;_INI&quot;));</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
acpi_ns_evaluate_relative (ec-&gt;handle, &quot;_INI&quot;, NULL, =
NULL);</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ACPI_FAILURE (status)) =
{</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No _INI (AE_NOT_FOUND) =
means device requires no initialization */</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D =
AE_NOT_FOUND) {</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ignore error and move on =
to next device */</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #ifdef =
ACPI_DEBUG_OUTPUT</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *scope_name =3D acpi_ns_get_external_pathname =
(ec-&gt;handle);</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI_DEBUG_PRINT =
((ACPI_DB_WARN, &quot;%s._INI failed: %s\n&quot;,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scope_name, =
acpi_format_exception (status)));</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI_MEM_FREE =
(scope_name);</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #endif</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return_VALUE(AE_OK);</FONT>
<BR><FONT SIZE=3D2>&nbsp;}</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/drivers/acpi/events/evregion.c =
patched/drivers/acpi/events/evregion.c</FONT>
<BR><FONT SIZE=3D2>--- 2.6/drivers/acpi/events/evregion.c&nbsp; =
2003-12-17 18:22:55.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/drivers/acpi/events/evregion.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2003-12-17 18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -50,13 +50,14 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;#define =
_COMPONENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_EVENTS</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_MODULE_NAME&nbsp;&nbsp;&nbsp; (&quot;evregion&quot;)</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>-#define =
ACPI_NUM_DEFAULT_SPACES&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>
<BR><FONT SIZE=3D2>+#define =
ACPI_NUM_DEFAULT_SPACES&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_SYSTEM_MEMORY,</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_SYSTEM_IO,</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_PCI_CONFIG,</FONT>
<BR><FONT SIZE=3D2>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_DATA_TABLE};</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_DATA_TABLE,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_ADR_SPACE_EC};</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;/**********************************************=
*********************************</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/drivers/acpi/events/evxfregn.c =
patched/drivers/acpi/events/evxfregn.c</FONT>
<BR><FONT SIZE=3D2>--- 2.6/drivers/acpi/events/evxfregn.c&nbsp; =
2003-12-17 18:22:32.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/drivers/acpi/events/evxfregn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2003-12-17 18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -153,6 +153,11 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup&nbsp;&nbsp; =3D =
NULL;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ACPI_ADR_SPACE_EC:</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler =3D =
acpi_ex_ec_space_handler;</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup&nbsp;&nbsp; =3D =
NULL;</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
AE_BAD_PARAMETER;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_and_exit;</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/drivers/acpi/executer/exregion.c =
patched/drivers/acpi/executer/exregion.c</FONT>
<BR><FONT SIZE=3D2>--- =
2.6/drivers/acpi/executer/exregion.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 2003-12-17 18:22:31.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/drivers/acpi/executer/exregion.c&nbsp;&nbsp;&nbsp; 2003-12-17 =
18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -430,6 +430,24 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;}</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+acpi_status</FONT>
<BR><FONT SIZE=3D2>+acpi_ex_ec_space_handler (</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; function,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_physical_address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; address,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bit_width,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_integer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *handler_context,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *region_context)</FONT>
<BR><FONT SIZE=3D2>+{</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
AE_OK;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ACPI_FUNCTION_TRACE (&quot;ex_ec_space_handler&quot;);</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_ec_need_reinit =3D TRUE;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return_ACPI_STATUS (status);</FONT>
<BR><FONT SIZE=3D2>+}</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;/********************************************************=
***********************</FONT>
<BR><FONT SIZE=3D2>&nbsp; *</FONT>
<BR><FONT SIZE=3D2>&nbsp; * FUNCTION:&nbsp;&nbsp;&nbsp; =
acpi_ex_pci_bar_space_handler</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/drivers/acpi/utilities/utglobal.c =
patched/drivers/acpi/utilities/utglobal.c</FONT>
<BR><FONT SIZE=3D2>--- =
2.6/drivers/acpi/utilities/utglobal.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 2003-12-17 18:22:29.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/drivers/acpi/utilities/utglobal.c&nbsp;&nbsp; 2003-12-17 =
18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -877,6 +877,7 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_root_node_struct.object&nbsp;&nbsp;&nbsp; =3D NULL;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_root_node_struct.flags&nbsp;&nbsp;&nbsp;&nbsp; =3D =
ANOBJ_END_OF_PEER_LIST;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_ec_need_reinit&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D =
FALSE;</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;#ifdef ACPI_DEBUG_OUTPUT</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_lowest_stack_pointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
ACPI_SIZE_MAX;</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/include/acpi/acglobal.h =
patched/include/acpi/acglobal.h</FONT>
<BR><FONT SIZE=3D2>--- 2.6/include/acpi/acglobal.h 2003-12-17 =
18:22:23.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/include/acpi/acglobal.h&nbsp;&nbsp;&nbsp;&nbsp; 2003-12-17 =
18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -190,6 +190,8 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;extern const =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_ns_properties[NUM_NS_TYPES];</FONT>
<BR><FONT SIZE=3D2>&nbsp;extern const struct =
acpi_predefined_names&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_pre_defined_names [NUM_PREDEFINED_NAMES];</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>+ACPI_EXTERN =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_ec_need_reinit;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>&nbsp;#ifdef ACPI_DEBUG_OUTPUT</FONT>
<BR><FONT SIZE=3D2>&nbsp;ACPI_EXTERN =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_current_node_count;</FONT>
<BR><FONT SIZE=3D2>&nbsp;ACPI_EXTERN =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_gbl_current_node_size;</FONT>
<BR><FONT SIZE=3D2>diff -Bru 2.6/include/acpi/acinterp.h =
patched/include/acpi/acinterp.h</FONT>
<BR><FONT SIZE=3D2>--- 2.6/include/acpi/acinterp.h 2003-12-17 =
18:23:07.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>+++ =
patched/include/acpi/acinterp.h&nbsp;&nbsp;&nbsp;&nbsp; 2003-12-17 =
18:24:21.000000000 +0800</FONT>
<BR><FONT SIZE=3D2>@@ -699,6 +699,15 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *region_context);</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;acpi_status</FONT>
<BR><FONT SIZE=3D2>+acpi_ex_ec_space_handler (</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; function,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_physical_address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; address,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bit_width,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_integer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *handler_context,</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *region_context);</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+acpi_status</FONT>
<BR><FONT SIZE=3D2>&nbsp;acpi_ex_pci_bar_space_handler (</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; function,</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
acpi_physical_address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; address,</FONT>
<BR><FONT =
SIZE=3D2>---------------------------------------------------------------=
-------------</FONT>
</P>

<P><FONT SIZE=3D2>-----Message d'origine-----</FONT>
<BR><FONT SIZE=3D2>De=A0: Pavel Machek [<A =
HREF=3D"mailto:pavel-AlSwsSmVLrQ@public.gmane.org">mailto:pavel@suse.cz</A>] </FONT>
<BR><FONT SIZE=3D2>Envoy=E9=A0: vendredi 2 avril 2004 22:44</FONT>
<BR><FONT SIZE=3D2>=C0=A0: BERNARD S=E9bastien</FONT>
<BR><FONT SIZE=3D2>Objet=A0: Re: RE : [ACPI] N800v is fixed by =
patch-1690</FONT>
</P>

<P><FONT SIZE=3D2>Hi!</FONT>
</P>

<P><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; I reply to myself since noone =
answered the underlying question :</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Is there any reason not to =
include the patch mentioned in my first</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; mail into the =
mainline.</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; This patch is helping a lot =
in my case.</FONT>
</P>

<P><FONT SIZE=3D2>Read Documentation/SubmittingPatches.txt,</FONT>
</P>

<P><FONT SIZE=3D2>6) No MIME, no links, no compression, no =
attachments.&nbsp; Just plain</FONT>
<BR><FONT SIZE=3D2>text.</FONT>
</P>

<P><FONT SIZE=3D2>in particular.</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>Pavel</FONT>
</P>

<P><FONT SIZE=3D2>-- </FONT>
<BR><FONT SIZE=3D2>When do you have a heart between your knees?</FONT>
<BR><FONT SIZE=3D2>[Johanka's followup: and *two* hearts?]</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C41AE9.8AA86390--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
