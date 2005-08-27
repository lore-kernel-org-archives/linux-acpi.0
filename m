From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Sat, 27 Aug 2005 20:28:08 +0200
Message-ID: <20050827182807.GA3618@inferi.kami.home>
References: <6694B22B6436BC43B429958787E454984289FD@mssmsx402nb>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E454984289FD@mssmsx402nb>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2005 at 07:51:37PM +0400, Starikovskiy, Alexey Y wrote:
>  Looks like I went into wrong direction with previous patch, could you
> please try new one?

with this patch it boots fine (no error executing the _REG method) and
after 3 hours of uptime still no random-time errors.
I'll raise my hand again if I see the dump again :)

(attached the diff with a clean .13-rc6-mm2 for reference)
-- 
mattia
:wq!

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="owner_id-3.patch.rc6-mm2"

diff -rup linux-2.6.13-rc6-mm2/drivers/acpi/dispatcher/dsmethod.c linux-clean/drivers/acpi/dispatcher/dsmethod.c
--- linux-2.6.13-rc6-mm2/drivers/acpi/dispatcher/dsmethod.c	2005-08-25 10:23:18.949991250 +0200
+++ linux-clean/drivers/acpi/dispatcher/dsmethod.c	2005-08-27 15:39:47.029311750 +0200
@@ -235,6 +235,16 @@ acpi_ds_begin_method_execution(struct ac
 		    acpi_ex_system_wait_semaphore(obj_desc->method.semaphore,
 						  ACPI_WAIT_FOREVER);
 	}
+	/*
+	 * allocate owner id for this method
+	 */
+	if (!obj_desc->method.thread_count) {
+		status = acpi_ut_allocate_owner_id (&obj_desc->method.owner_id);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	}
+ 
 
 	/*
 	 * Increment the method parse tree thread count since it has been
@@ -289,11 +299,6 @@ acpi_ds_call_control_method(struct acpi_
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
-	status = acpi_ut_allocate_owner_id(&obj_desc->method.owner_id);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Init for new method, wait on concurrency semaphore */
 
 	status = acpi_ds_begin_method_execution(method_node, obj_desc,
@@ -380,22 +385,18 @@ acpi_ds_call_control_method(struct acpi_
 
 	if (obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
 		status = obj_desc->method.implementation(next_walk_state);
-		return_ACPI_STATUS(status);
 	}
+	goto end;
 
-	return_ACPI_STATUS(AE_OK);
-
-	/* On error, we must delete the new walk state */
-
-      cleanup:
-	acpi_ut_release_owner_id(&obj_desc->method.owner_id);
+cleanup:
+	/* Decrement the thread count on the method parse tree */
 	if (next_walk_state && (next_walk_state->method_desc)) {
-		/* Decrement the thread count on the method parse tree */
-
 		next_walk_state->method_desc->method.thread_count--;
 	}
-	(void)acpi_ds_terminate_control_method(next_walk_state);
-	acpi_ds_delete_walk_state(next_walk_state);
+	/* On error, we must delete the new walk state */
+	acpi_ds_terminate_control_method (next_walk_state);
+	acpi_ds_delete_walk_state (next_walk_state);
+end:
 	return_ACPI_STATUS(status);
 }
 
@@ -479,7 +480,7 @@ acpi_ds_restart_control_method(struct ac
  *
  * PARAMETERS:  walk_state          - State of the method
  *
- * RETURN:      Status
+ * RETURN:      None
  *
  * DESCRIPTION: Terminate a control method.  Delete everything that the method
  *              created, delete all locals and arguments, and delete the parse
@@ -487,7 +488,7 @@ acpi_ds_restart_control_method(struct ac
  *
  ******************************************************************************/
 
-acpi_status acpi_ds_terminate_control_method(struct acpi_walk_state *walk_state)
+void acpi_ds_terminate_control_method(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *obj_desc;
 	struct acpi_namespace_node *method_node;
@@ -496,14 +497,14 @@ acpi_status acpi_ds_terminate_control_me
 	ACPI_FUNCTION_TRACE_PTR("ds_terminate_control_method", walk_state);
 
 	if (!walk_state) {
-		return (AE_BAD_PARAMETER);
+		return_VOID;
 	}
 
 	/* The current method object was saved in the walk state */
 
 	obj_desc = walk_state->method_desc;
 	if (!obj_desc) {
-		return_ACPI_STATUS(AE_OK);
+		return_VOID;
 	}
 
 	/* Delete all arguments and locals */
@@ -517,7 +518,7 @@ acpi_status acpi_ds_terminate_control_me
 	 */
 	status = acpi_ut_acquire_mutex(ACPI_MTX_PARSER);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		return_VOID;
 	}
 
 	/* Signal completion of the execution of this method if necessary */
@@ -574,7 +575,7 @@ acpi_status acpi_ds_terminate_control_me
 		 */
 		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			goto cleanup;
 		}
 
 		if (method_node->child) {
@@ -592,10 +593,9 @@ acpi_status acpi_ds_terminate_control_me
 					 owner_id);
 
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			goto cleanup;
 		}
 	}
-
-	status = acpi_ut_release_mutex(ACPI_MTX_PARSER);
-	return_ACPI_STATUS(status);
+cleanup:
+	acpi_ut_release_mutex (ACPI_MTX_PARSER);
 }

diff -rup linux-2.6.13-rc6-mm2/drivers/acpi/parser/psparse.c linux-clean/drivers/acpi/parser/psparse.c
--- linux-2.6.13-rc6-mm2/drivers/acpi/parser/psparse.c	2005-08-25 10:23:19.970055000 +0200
+++ linux-clean/drivers/acpi/parser/psparse.c	2005-08-27 15:33:51.443089000 +0200
@@ -438,7 +438,6 @@ acpi_ps_next_parse_state(struct acpi_wal
 acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 {
 	acpi_status status;
-	acpi_status terminate_status;
 	struct acpi_thread_state *thread;
 	struct acpi_thread_state *prev_walk_list = acpi_gbl_current_walk_list;
 	struct acpi_walk_state *previous_walk_state;
@@ -508,6 +507,9 @@ acpi_status acpi_ps_parse_aml(struct acp
 						 walk_state->method_node, NULL,
 						 status);
 
+			/* Make sure that failed method will be cleaned as if it was executed */
+			walk_state->parse_flags |= ACPI_PARSE_EXECUTE;
+			
 			/* Check for possible multi-thread reentrancy problem */
 
 			if ((status == AE_ALREADY_EXISTS) &&
@@ -524,14 +526,6 @@ acpi_status acpi_ps_parse_aml(struct acp
 			}
 		}
 
-		if (walk_state->method_desc) {
-			/* Decrement the thread count on the method parse tree */
-
-			if (walk_state->method_desc->method.thread_count) {
-				walk_state->method_desc->method.thread_count--;
-			}
-		}
-
 		/* We are done with this walk, move on to the parent if any */
 
 		walk_state = acpi_ds_pop_walk_state(thread);
@@ -546,13 +540,10 @@ acpi_status acpi_ps_parse_aml(struct acp
 		 */
 		if ((walk_state->parse_flags & ACPI_PARSE_MODE_MASK) ==
 		    ACPI_PARSE_EXECUTE) {
-			terminate_status =
-			    acpi_ds_terminate_control_method(walk_state);
-			if (ACPI_FAILURE(terminate_status)) {
-				ACPI_REPORT_ERROR(("Could not terminate control method properly\n"));
-
-				/* Ignore error and continue */
+			if (walk_state->method_desc) {
+				walk_state->method_desc->method.thread_count--;
 			}
+			acpi_ds_terminate_control_method (walk_state);
 		}
 
 		/* Delete this walk state and all linked control states */

diff -rup linux-2.6.13-rc6-mm2/drivers/acpi/parser/psxface.c linux-clean/drivers/acpi/parser/psxface.c
--- linux-2.6.13-rc6-mm2/drivers/acpi/parser/psxface.c	2005-08-25 10:23:20.014057750 +0200
+++ linux-clean/drivers/acpi/parser/psxface.c	2005-08-27 15:34:57.903242500 +0200
@@ -99,16 +99,6 @@ acpi_status acpi_ps_execute_method(struc
 	}
 
 	/*
-	 * Get a new owner_id for objects created by this method. Namespace
-	 * objects (such as Operation Regions) can be created during the
-	 * first pass parse.
-	 */
-	status = acpi_ut_allocate_owner_id(&info->obj_desc->method.owner_id);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/*
 	 * The caller "owns" the parameters, so give each one an extra
 	 * reference
 	 */
@@ -139,9 +129,6 @@ acpi_status acpi_ps_execute_method(struc
 	status = acpi_ps_execute_pass(info);
 
       cleanup:
-	if (info->obj_desc->method.owner_id) {
-		acpi_ut_release_owner_id(&info->obj_desc->method.owner_id);
-	}
 
 	/* Take away the extra reference that we gave the parameters above */
 
diff -rup linux-2.6.13-rc6-mm2/drivers/acpi/utilities/utmisc.c linux-clean/drivers/acpi/utilities/utmisc.c
--- linux-2.6.13-rc6-mm2/drivers/acpi/utilities/utmisc.c	2005-08-25 10:23:20.550091250 +0200
+++ linux-clean/drivers/acpi/utilities/utmisc.c	2005-08-27 15:35:32.769421500 +0200
@@ -67,6 +67,8 @@ acpi_status acpi_ut_allocate_owner_id(ac
 
 	ACPI_FUNCTION_TRACE("ut_allocate_owner_id");
 
+	WARN_ON(*owner_id);
+
 	/* Mutex for the global ID mask */
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);


--d6Gm4EdcadzBjdND--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
