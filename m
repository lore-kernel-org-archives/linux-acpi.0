From: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: [ACPI-sppt] Re: [ACPI] ACPI on Asus M2N
Date: Mon, 27 Oct 2003 12:03:00 +0300
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F9CDF44.8070308@namesys.com>
References: <1067120458.3313.8.camel@RTop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1067120458.3313.8.camel-RU1JJA7J9tM@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: rmuehlhoff <rmuehlhoff-52dn/g0OV9M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

rmuehlhoff wrote:

>Hello, 
>
>what's the current state concerning ACPI on Asus M2N?
>I have been away from this list for a few weeks. Before I left, there
>were still unsolves problems with the thermal management (cpu fan
>control didn't work properly) which seemed do be due to a malfunctioning
>DSDT. 
>
>Is this problem solved, meanwhile?
>
>Could please any Asus M2N user outline the recent progress on this issue
>to me?
>
>Thank you very much, 
>
>Rainer
>
>
>
>  
>
Hello,

I have ASUS M3700N. As I understand it has the same bios as S1N and M2N. 
And I want to say, that starting from 2.6-test8 everything works out of 
the box. Before 2.6-test8 there was needed to apply a small patch like 
the following:

diff -Naur linux-2.4.21-acpi/drivers/acpi/executer/exfldio.c linux-2.4.21-acpi-asus.centrino/drivers/acpi/executer/exfldio.c
--- linux-2.4.21-acpi/drivers/acpi/executer/exfldio.c	2003-09-25 18:12:28.000000000 +0200
+++ linux-2.4.21-acpi-asus.centrino/drivers/acpi/executer/exfldio.c	2003-09-25 13:14:07.000000000 +0200
@@ -312,6 +312,7 @@
 {
 	acpi_status                     status;
 	acpi_integer                    local_value;
+	acpi_integer                    index_field_value;
 
 
 	ACPI_FUNCTION_TRACE_U32 ("ex_field_datum_io", field_datum_byte_offset);
@@ -414,18 +415,21 @@
 
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
+		/* Compute index value to access the current datum */
+
+		index_field_value = (acpi_integer) obj_desc->index_field.value
+			+ field_datum_byte_offset;
 
 		/* Ensure that the index_value is not beyond the capacity of the register */
 
 		if (acpi_ex_register_overflow (obj_desc->index_field.index_obj,
-				  (acpi_integer) obj_desc->index_field.value)) {
+					       index_field_value)) {
 			return_ACPI_STATUS (AE_AML_REGISTER_LIMIT);
 		}
 
 		/* Write the index value to the index_register (itself a region_field) */
 
 		status = acpi_ex_insert_into_field (obj_desc->index_field.index_obj,
-				 &obj_desc->index_field.value,
+				 &index_field_value,
 				 sizeof (obj_desc->index_field.value));
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);



Now it is fixed in mainstream. After this patch everything works just 
fine. Before there was lots of problems with acpi routing, keventd, etc.

I also have information, that this patch cures problems with acpi on 
ASUS-S200N.

>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: The SF.net Donation Program.
>Do you like what SourceForge.net is doing for the Open
>Source Community?  Make a contribution, and help us add new
>features and functionality. Click here: http://sourceforge.net/donate/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>  
>


-- 
umka




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
