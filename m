From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Make LEqual less strict
Date: Fri, 03 Sep 2004 11:13:10 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094231590.11388.14.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Bob,

   We discussed making LEqual less strict about requiring both operands
to be identical types a couple weeks ago.  It sounded like the plan was
to convert the second operand to match the first for the case where
they're not equal.  I haven't seen a code change for this yet, so I'll
toss this out in case it helps someone else.  It works for me, and gets
rid of all the errors my box was spewing with the new CA.  Thanks,

	Alex

-- 
Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/executer/exoparg2.c 1.25 vs edited =====
--- 1.25/drivers/acpi/executer/exoparg2.c	2004-06-21 18:35:22 -06:00
+++ edited/drivers/acpi/executer/exoparg2.c	2004-09-03 10:35:06 -06:00
@@ -573,17 +573,48 @@
 	 * Execute the Opcode
 	 */
 	if (walk_state->op_info->flags & AML_LOGICAL) /* logical_op (Operand0, Operand1) */ {
-		/* Both operands must be of the same type */
+		union acpi_operand_object *temp_desc = NULL;
 
-		if (ACPI_GET_OBJECT_TYPE (operand[0]) !=
-			ACPI_GET_OBJECT_TYPE (operand[1])) {
-			status = AE_AML_OPERAND_TYPE;
-			goto cleanup;
+		/*
+		 * Convert the second operand if necessary.  The first
+		 * operand determines the type of the second operand.
+		 */
+		switch (ACPI_GET_OBJECT_TYPE (operand[0])) {
+		case ACPI_TYPE_INTEGER:
+			status = acpi_ex_convert_to_integer (operand[1],
+			                                     &temp_desc,
+							     walk_state);
+			break;
+
+		case ACPI_TYPE_STRING:
+			status = acpi_ex_convert_to_string (operand[1],
+			                                    &temp_desc, 16,
+							    ACPI_UINT32_MAX,
+							    walk_state);
+			break;
+
+		case ACPI_TYPE_BUFFER:
+			status = acpi_ex_convert_to_buffer (operand[1],
+			                                    &temp_desc,
+							    walk_state);
+			break;
+
+		default:
+			ACPI_REPORT_ERROR (("logical_op - invalid obj type: %X\n",
+					ACPI_GET_OBJECT_TYPE (operand[0])));
+			status = AE_AML_INTERNAL;
 		}
 
+		if (ACPI_FAILURE (status))
+			goto cleanup;
+
 		logical_result = acpi_ex_do_logical_op (walk_state->opcode,
 				 operand[0],
-				 operand[1]);
+				 temp_desc);
+
+		if (temp_desc != operand[1])
+			acpi_ut_remove_reference(temp_desc);
+
 		goto store_logical_result;
 	}
 




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
