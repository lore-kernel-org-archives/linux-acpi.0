From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [buggy index field handling] [patch]
Date: Tue, 23 Sep 2003 14:26:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3D8B@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>, Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Please send me some ASL code that exhibits the problem so I can analyze
and verify.

Thanks,
Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ducrot
Bruno
Sent: Monday, September 22, 2003 10:36 AM
To: Grover, Andrew
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Robert Vollmert; Mads Paulin
Subject: Re: [ACPI] [buggy index field handling] [patch]

On Mon, Sep 22, 2003 at 07:18:47PM +0200, Ducrot Bruno wrote:
> Hi Andy,
>=20
> There is a funny bug in
acpi/executer/exfldio.c::acpi_ex_field_datum_io
>=20
> When the field come from an indexed one, we read all the time from the
> address obj_desc->index_field.value
> Unfortunately, this is wrong, since the correct address is
> obviously &obj_desc->index_field.value + field_datum_byte_offset

Ok, that one should be OK, now.  My apologize for the first one.


--- linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/22
17:09:20	1.1
+++ linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/22
17:31:55
@@ -413,6 +413,8 @@
=20
=20
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
+		{
+		u32 old_addr =3D 0;
=20
=20
 		/* Ensure that the index_value is not beyond the
capacity of the register */
@@ -424,9 +426,12 @@
=20
 		/* Write the index value to the index_register (itself a
region_field) */
=20
+		old_addr =3D obj_desc->index_field.value;
+		obj_desc->index_field.value +=3D field_datum_byte_offset;
 		status =3D acpi_ex_insert_into_field
(obj_desc->index_field.index_obj,
-				 &obj_desc->index_field.value,
+				 &obj_desc->index_field.value +
field_datum_byte_offset,
 				 sizeof (obj_desc->index_field.value));
+		obj_desc->index_field.value =3D old_address;
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
@@ -443,6 +448,7 @@
 			status =3D acpi_ex_insert_into_field
(obj_desc->index_field.data_obj,
 					  value,
obj_desc->common_field.access_byte_width);
 		}
+		}
 		break;
=20
=20

--=20
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
