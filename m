From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [buggy index field handling] [patch]
Date: Tue, 23 Sep 2003 20:13:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030923181352.GS11391@poupinou.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3D88@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3D88-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>, Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 23, 2003 at 10:27:52AM -0700, Moore, Robert wrote:
> Is this the final patch?  If so, we will integrate it into the ACPI CA
> core
> Bob
> 
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ducrot
> Bruno
> Sent: Monday, September 22, 2003 10:19 AM
> To: Grover, Andrew
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Robert Vollmert; Mads Paulin
> Subject: [ACPI] [buggy index field handling] [patch]
> 
> Hi Andy,
> 
> There is a funny bug in acpi/executer/exfldio.c::acpi_ex_field_datum_io
> 
> When the field come from an indexed one, we read all the time from the
> address obj_desc->index_field.value
> Unfortunately, this is wrong, since the correct address is
> obviously &obj_desc->index_field.value + field_datum_byte_offset

I would like much you integrate Robert Vollmert version: it does overflow
checking.

Patch is from Robert Vollmert, but rediffed against 2.6.0-test5:


--- linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/22 17:09:20	1.1
+++ linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/23 18:05:37
@@ -312,6 +312,7 @@
 {
 	acpi_status                     status;
 	acpi_integer                    local_value;
+	acpi_integer                    index_field_value;
 
 
 	ACPI_FUNCTION_TRACE_U32 ("ex_field_datum_io", field_datum_byte_offset);
@@ -415,18 +416,22 @@
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
 
+		/* Compute index value to access the current datum */
+		index_field_value = obj_desc->index_field.value
+			+ field_datum_byte_offset;
+
 		/* Ensure that the index_value is not beyond the capacity of the register */
 
 		if (acpi_ex_register_overflow (obj_desc->index_field.index_obj,
-				  (acpi_integer) obj_desc->index_field.value)) {
+				  index_field_value)) {
 			return_ACPI_STATUS (AE_AML_REGISTER_LIMIT);
 		}
 
 		/* Write the index value to the index_register (itself a region_field) */
 
 		status = acpi_ex_insert_into_field (obj_desc->index_field.index_obj,
-				 &obj_desc->index_field.value,
-				 sizeof (obj_desc->index_field.value));
+				 &index_field_value,
+				 sizeof (index_field_value));
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
