From: Ramon Casellas <casellas-Ps1RxedxAdk/xqpuW5qSgA@public.gmane.org>
Subject: ACPI Patch for 2.6.0-test5-mm3 (post 20030916) needs testing,
 ref.count errors detecting battery/status
Date: Fri, 19 Sep 2003 17:15:00 +0200 (CEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.58.0309191704470.9325@gandalf.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohuha.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

Original patch from Li, Shaohua <shaohua-lUQJ9CVx3tM@public.gmane.org> for 2.4.22/23, ported to 
2.6.0-test5-mm3 (with acpi 20030916), please test.


[1] Bug Report 
----------------------------------------------------------
http://sourceforge.net/mailarchive/forum.php?thread_id=3144527&forum_id=6102

[2] Answer
-----------------------------------------------------------
> From: Li, Shaohua <shaohua-lUQJ9CVx3tM@public.gmane.org> 
> RE: Re: IBM Thinkpad and ACPI 20030916 for 2.4.23-pre4   
2003-09-17 17:28 

>Hi,
> Patch for the battery error is available in OSDL bugzilla #1038. Pl. 
try.
> Thanks,
> Shaohua
-----------------------------------------------------------

Note: Works for me.

Regards,
Ramon
// Ramon Casellas 		GET/ENST/INFRES/RHD/C206  



###############################################
diff -ru linux-2.6.0-test5-mm3/drivers/acpi/utilities/utdelete.c linux-2.6.0-test5-mm3.acpi/drivers/acpi/utilities/utdelete.c
--- linux-2.6.0-test5-mm3/drivers/acpi/utilities/utdelete.c	2003-09-08 21:50:04.000000000 +0200
+++ linux-2.6.0-test5-mm3.acpi/drivers/acpi/utilities/utdelete.c	2003-09-19 16:50:13.656199160 +0200
@@ -417,6 +417,8 @@
 	union acpi_generic_state         *state_list = NULL;
 	union acpi_generic_state         *state;
 
+	union acpi_operand_object        *tmp;
+
 
 	ACPI_FUNCTION_TRACE_PTR ("ut_update_object_reference", object);
 
@@ -447,9 +449,16 @@
 		 */
 		switch (ACPI_GET_OBJECT_TYPE (object)) {
 		case ACPI_TYPE_DEVICE:
-
-			acpi_ut_update_ref_count (object->device.system_notify, action);
-			acpi_ut_update_ref_count (object->device.device_notify, action);
+			
+			tmp = object->device.system_notify;
+			if(tmp && tmp->common.reference_count<=1 && action == REF_DECREMENT)
+				object->device.system_notify = NULL;
+			acpi_ut_update_ref_count (tmp, action);
+
+			tmp = object->device.device_notify;
+			if(tmp && tmp->common.reference_count <=1 && action == REF_DECREMENT)
+				object->device.device_notify = NULL;
+			acpi_ut_update_ref_count (tmp, action);
 			break;
 
 
@@ -467,6 +476,9 @@
 				 */
 				status = acpi_ut_create_update_state_and_push (
 						 object->package.elements[i], action, &state_list);
+				tmp = object->package.elements[i];
+				if(tmp && tmp->common.reference_count<=1  && action == REF_DECREMENT) /*reference count didn't refresh now*/
+					object->package.elements[i] = NULL;
 				if (ACPI_FAILURE (status)) {
 					goto error_exit;
 				}
@@ -478,6 +490,9 @@
 
 			status = acpi_ut_create_update_state_and_push (
 					 object->buffer_field.buffer_obj, action, &state_list);
+			tmp = object->buffer_field.buffer_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->buffer_field.buffer_obj = NULL;
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
@@ -491,6 +506,9 @@
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
+			tmp = object->field.region_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->field.region_obj = NULL;
 		   break;
 
 
@@ -501,12 +519,18 @@
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
+			tmp = object->bank_field.bank_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->bank_field.bank_obj = NULL;
 
 			status = acpi_ut_create_update_state_and_push (
 					 object->bank_field.region_obj, action, &state_list);
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
+			tmp = object->bank_field.region_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->bank_field.region_obj = NULL;
 			break;
 
 
@@ -517,12 +541,18 @@
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
+			tmp = object->index_field.index_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->index_field.index_obj = NULL;
 
 			status = acpi_ut_create_update_state_and_push (
 					 object->index_field.data_obj, action, &state_list);
 			if (ACPI_FAILURE (status)) {
 				goto error_exit;
 			}
+			tmp = object->index_field.data_obj;
+			if( tmp && tmp->common.reference_count <=1  && action == REF_DECREMENT)/*reference count didn't refresh now*/
+				object->index_field.data_obj = NULL;
 			break;
 
