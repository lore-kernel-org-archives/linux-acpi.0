From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v4 3/5] ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by
 switching to new TermList grammar for table loading
Date: Mon, 4 Jul 2016 23:42:41 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBFFF69@SHSMSX101.ccr.corp.intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
 <cover.1466479787.git.lv.zheng@intel.com>
 <e481a3b182657e907fb1db6f6f71144c36228ddc.1466479787.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23353 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbcGDXmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 19:42:51 -0400
In-Reply-To: <e481a3b182657e907fb1db6f6f71144c36228ddc.1466479787.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

> From: Zheng, Lv
> Subject: [PATCH v4 3/5] ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by
> switching to new TermList grammar for table loading
> 
> The MLC (Module Level Code) is an ACPICA terminology describing the
> AML
> code out of any control method, its support is the main contention of the
> interpreter behavior during the table loading.
> 
> The original implementation of MLC in ACPICA had several issues:
> 1. Out of any control method, besides of the object creating opcodes, only
>    the code blocks wrapped by "If/Else/While" opcodes were supported.
> 2. The supported MLC code blocks were executed after loading the table
>    rather than being executed right in place.
> 
> ==========================================================
> ==
>    The demo of this order issue is as follows:
>      Name (OBJ1, 1)
>      If (CND1 == 1)
>      {
>        Name (OBJ2, 2)
>      }
>      Name (OBJ3, 3)
>    The original MLC support created OBJ2 after OBJ3's creation.
> 
> ==========================================================
> ==
> Other than these limitations, MLC support in ACPICA looks correct. And
> supporting this should be easy/natural for ACPICA, but enabling of this
> was
> blocked by some ACPICA internal and OSPM specific initialization order
> issues we've fixed recently. The wrong support started from the following
> false bug fixing commit:
>   Commit: 80d7951177315f70b5ffd8663985fbf725d07799
>   Subject: Add support for module-level executable AML code.
> 
> We can confirm Windows interpreter behavior via reverse engineering
> means.
> It can be proven that not only If/Else/While wrapped code blocks, all
> opcodes can be executed at the module level, including operation region
> accesses. And it can be proven that the MLC should be executed right in
> place, not in such a deferred way executed after loading the table.
> 
> And the above facts indeed reflect the spec words around ACPI definition
> block tables (DSDT/SSDT/...), the entire table and the Scope object is
> defined by the AML specification in BNF style as:
>   AMLCode := DefBlockHeader TermList
>   DefScope := ScopeOp PkgLength NameString TermList
> The bodies of the scope opening terms (AMLCode/Scope) are all TermList,
> thus the table loading should be no difference than the control method
> evaluations as the body of the Method is also defined by the AML
> specification as TermList:
>   DefMethod := MethodOp PkgLength NameString MethodFlags TermList
> The only difference is: after evaluating control method, created named
> objects may be freed due to no reference, while named objects created by
> the table loading should only be freed after unloading the table.
> 
> So this patch follows the spec and the de-facto standard behavior, enables
> the new grammar (TermList) for the table loading.
> 
> By doing so, beyond the fixes to the above issues, we can see additional
> differences comparing to the old grammar based table loading:
> 1. Originally, beyond the scope opening terms (AMLCode/Scope),
>    If/Else/While wrapped code blocks under the scope creating terms
>    (Device/PowerResource/Processor/ThermalZone) are also supported as
>    deferred MLC, which violates the spec defined grammar where ObjectList
>    is enforced. With MLC support improved as non-deferred, the interpreter
>    parses such scope creating terms as TermList rather ObjectList like the
>    scope opening terms.
>    After probing the Windows behavior and proving that it also parses
> these
>    terms as TermList, we submitted an ECR (Engineering Change Request) to
>    the ASWG (ACPI Specification Working Group) to clarify this. The ECR is
>    titled as "ASL Grammar Clarification for Executable AML Opcodes" and
> has
>    been accepted by the ASWG. The new grammar will appear in ACPI
>    specification 6.2.
> 2. Originally, Buffer/Package/OperationRegion/CreateXXXField/BankField
>    arguments are evaluated in a deferred way after loading the table. With
>    MLC support improved, they are also parsed right in place during the
>    table loading.
>    This is also Windows compliant and the only difference is the removal
>    of the debugging messages implemented before
> acpi_ds_execute_arguments(),
>    see Link 1 for the details. A previous commit should have ensured that
>    acpi_check_address_range() won't regress.
> 
> Note that enabling this feature may cause regressions due to long term
> Linux ACPI support on top of the wrong grammar. So this patch also
> prepares
> a global option to be used to roll back to the old grammar during the
> period between a regression is reported and the regression is
> root-cause-fixed. ACPICA BZ 963, fixed by Lv Zheng.
> 
> Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=112911
> Link 2: https://bugs.acpica.org/show_bug.cgi?id=963
> Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/acnamesp.h |    3 +
>  drivers/acpi/acpica/acparser.h |    2 +
>  drivers/acpi/acpica/evrgnini.c |    3 +-
>  drivers/acpi/acpica/exconfig.c |    3 +-
>  drivers/acpi/acpica/nsload.c   |    3 +-
>  drivers/acpi/acpica/nsparse.c  |  166
> ++++++++++++++++++++++++++++++++--------
>  drivers/acpi/acpica/psparse.c  |    4 +-
>  drivers/acpi/acpica/psxface.c  |   71 +++++++++++++++++
>  drivers/acpi/acpica/tbxfload.c |    3 +-
>  drivers/acpi/acpica/utxfinit.c |    3 +-
>  include/acpi/acpixf.h          |    6 ++
>  11 files changed, 229 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acnamesp.h
> b/drivers/acpi/acpica/acnamesp.h
> index f33a4ba..829672a 100644
> --- a/drivers/acpi/acpica/acnamesp.h
> +++ b/drivers/acpi/acpica/acnamesp.h
> @@ -130,6 +130,9 @@ acpi_status
>  acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node
> *start_node);
> 
>  acpi_status
> +acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node
> *start_node);
> +
> +acpi_status
>  acpi_ns_one_complete_parse(u32 pass_number,
>  			   u32 table_index,
>  			   struct acpi_namespace_node *start_node);
> diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
> index fc30577..939d411 100644
> --- a/drivers/acpi/acpica/acparser.h
> +++ b/drivers/acpi/acpica/acparser.h
> @@ -78,6 +78,8 @@ extern const u8 acpi_gbl_long_op_index[];
>   */
>  acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info);
> 
> +acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info);
> +
>  /*
>   * psargs - Parse AML opcode arguments
>   */
> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> index b6ea9c0..3843f1f 100644
> --- a/drivers/acpi/acpica/evrgnini.c
> +++ b/drivers/acpi/acpica/evrgnini.c
> @@ -553,7 +553,8 @@ acpi_ev_initialize_region(union
> acpi_operand_object *region_obj,
>  				 *
>  				 * See acpi_ns_exec_module_code
>  				 */
> -				if (obj_desc->method.
> +				if (!acpi_gbl_parse_table_as_term_list &&
> +				    obj_desc->method.
>  				    info_flags &
> ACPI_METHOD_MODULE_LEVEL) {
>  					handler_obj =
>  					    obj_desc-
> >method.dispatch.handler;
> diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
> index 21932d6..75679bc 100644
> --- a/drivers/acpi/acpica/exconfig.c
> +++ b/drivers/acpi/acpica/exconfig.c
> @@ -120,7 +120,8 @@ acpi_ex_add_table(u32 table_index,
>  	/* Execute any module-level code that was found in the table */
> 
>  	acpi_ex_exit_interpreter();
> -	if (acpi_gbl_group_module_level_code) {
> +	if (!acpi_gbl_parse_table_as_term_list
> +	    && acpi_gbl_group_module_level_code) {
>  		acpi_ns_exec_module_code_list();
>  	}
>  	acpi_ex_enter_interpreter();
> diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
> index b5e2b0a..2daa9a09 100644
> --- a/drivers/acpi/acpica/nsload.c
> +++ b/drivers/acpi/acpica/nsload.c
> @@ -162,7 +162,8 @@ unlock:
>  	 * other ACPI implementations. Optionally, the execution can be
> deferred
>  	 * until later, see acpi_initialize_objects.
>  	 */
> -	if (!acpi_gbl_group_module_level_code) {
> +	if (!acpi_gbl_parse_table_as_term_list
> +	    && !acpi_gbl_group_module_level_code) {
>  		acpi_ns_exec_module_code_list();
>  	}
> 
> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
> index 1783cd7..f475889 100644
> --- a/drivers/acpi/acpica/nsparse.c
> +++ b/drivers/acpi/acpica/nsparse.c
> @@ -54,6 +54,98 @@ ACPI_MODULE_NAME("nsparse")
> 
> 
> /*********************************************************
> **********************
>   *
> + * FUNCTION:    ns_execute_table
> + *
> + * PARAMETERS:  table_desc      - An ACPI table descriptor for table to
> parse
> + *              start_node      - Where to enter the table into the namespace
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Load ACPI/AML table by executing the entire table as a
> + *              term_list.
> + *
> +
> **********************************************************
> ********************/
> +acpi_status
> +acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node
> *start_node)
> +{
> +	acpi_status status;
> +	struct acpi_table_header *table;
> +	acpi_owner_id owner_id;
> +	struct acpi_evaluate_info *info = NULL;
> +	u32 aml_length;
> +	u8 *aml_start;
> +	union acpi_operand_object *method_obj = NULL;
> +
> +	ACPI_FUNCTION_TRACE(ns_execute_table);
> +
> +	status = acpi_get_table_by_index(table_index, &table);
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +
> +	/* Table must consist of at least a complete header */
> +
> +	if (table->length < sizeof(struct acpi_table_header)) {
> +		return_ACPI_STATUS(AE_BAD_HEADER);
> +	}
> +
> +	aml_start = (u8 *)table + sizeof(struct acpi_table_header);
> +	aml_length = table->length - sizeof(struct acpi_table_header);
> +
> +	status = acpi_tb_get_owner_id(table_index, &owner_id);
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +
> +	/* Create, initialize, and link a new temporary method object */
> +
> +	method_obj =
> acpi_ut_create_internal_object(ACPI_TYPE_METHOD);
> +	if (!method_obj) {
> +		return_ACPI_STATUS(AE_NO_MEMORY);
> +	}
> +
> +	/* Allocate the evaluation information block */
> +
> +	info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
> +	if (!info) {
> +		status = AE_NO_MEMORY;
> +		goto cleanup;
> +	}
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
> +			  "Create table code block: %p\n", method_obj));
> +
> +	method_obj->method.aml_start = aml_start;
> +	method_obj->method.aml_length = aml_length;
> +	method_obj->method.owner_id = owner_id;
> +	method_obj->method.info_flags |=
> ACPI_METHOD_MODULE_LEVEL;
> +
> +	info->pass_number = ACPI_IMODE_EXECUTE;
> +	info->node = start_node;
> +	info->obj_desc = method_obj;
> +	info->node_flags = info->node->flags;
> +	info->full_pathname = acpi_ns_get_normalized_pathname(info-
> >node, TRUE);
> +	if (!info->full_pathname) {
> +		status = AE_NO_MEMORY;
> +		goto cleanup;
> +	}
> +
> +	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +	status = acpi_ps_execute_table(info);
> +	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
[Lv Zheng] 
I got a report that we have lock order issue in the previous bug fix:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2f38b1b1
And I'll send a quick fix for that later today.

After investigation, we found that ACPICA namespace lock design actually requires a big change in order to support this grammar change.
This means that this patch still need to be improved.
And the above 3 lines are currently known to be not compliant to the current ACPICA namespace lock design.

So please drop this series, and I'll re-send this series after improving the ACPICA namespace lock design.

Sorry for the issues.

Thanks and best regards
-Lv


> +
> +cleanup:
> +	if (info) {
> +		ACPI_FREE(info->full_pathname);
> +		info->full_pathname = NULL;
> +	}
> +	ACPI_FREE(info);
> +	acpi_ut_remove_reference(method_obj);
> +	return_ACPI_STATUS(status);
> +}
> +
> +/********************************************************
> ***********************
> + *
>   * FUNCTION:    ns_one_complete_parse
>   *
>   * PARAMETERS:  pass_number             - 1 or 2
> @@ -64,6 +156,7 @@ ACPI_MODULE_NAME("nsparse")
>   * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
>   *
> 
> **********************************************************
> ********************/
> +
>  acpi_status
>  acpi_ns_one_complete_parse(u32 pass_number,
>  			   u32 table_index,
> @@ -173,38 +266,47 @@ acpi_ns_parse_table(u32 table_index, struct
> acpi_namespace_node *start_node)
> 
>  	acpi_ex_enter_interpreter();
> 
> -	/*
> -	 * AML Parse, pass 1
> -	 *
> -	 * In this pass, we load most of the namespace. Control methods
> -	 * are not parsed until later. A parse tree is not created. Instead,
> -	 * each Parser Op subtree is deleted when it is finished. This saves
> -	 * a great deal of memory, and allows a small cache of parse
> objects
> -	 * to service the entire parse. The second pass of the parse then
> -	 * performs another complete parse of the AML.
> -	 */
> -	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
> -
> -	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
> -					    table_index, start_node);
> -	if (ACPI_FAILURE(status)) {
> -		goto error_exit;
> -	}
> -
> -	/*
> -	 * AML Parse, pass 2
> -	 *
> -	 * In this pass, we resolve forward references and other things
> -	 * that could not be completed during the first pass.
> -	 * Another complete parse of the AML is performed, but the
> -	 * overhead of this is compensated for by the fact that the
> -	 * parse objects are all cached.
> -	 */
> -	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
> -	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
> -					    table_index, start_node);
> -	if (ACPI_FAILURE(status)) {
> -		goto error_exit;
> +	if (acpi_gbl_parse_table_as_term_list) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start load
> pass\n"));
> +
> +		status = acpi_ns_execute_table(table_index, start_node);
> +		if (ACPI_FAILURE(status)) {
> +			goto error_exit;
> +		}
> +	} else {
> +		/*
> +		 * AML Parse, pass 1
> +		 *
> +		 * In this pass, we load most of the namespace. Control
> methods
> +		 * are not parsed until later. A parse tree is not created.
> +		 * Instead, each Parser Op subtree is deleted when it is
> finished.
> +		 * This saves a great deal of memory, and allows a small
> cache of
> +		 * parse objects to service the entire parse. The second
> pass of
> +		 * the parse then performs another complete parse of the
> AML.
> +		 */
> +		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass
> 1\n"));
> +
> +		status =
> acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
> +						    table_index, start_node);
> +		if (ACPI_FAILURE(status)) {
> +			goto error_exit;
> +		}
> +
> +		/*
> +		 * AML Parse, pass 2
> +		 *
> +		 * In this pass, we resolve forward references and other
> things
> +		 * that could not be completed during the first pass.
> +		 * Another complete parse of the AML is performed, but
> the
> +		 * overhead of this is compensated for by the fact that the
> +		 * parse objects are all cached.
> +		 */
> +		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass
> 2\n"));
> +		status =
> acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
> +						    table_index, start_node);
> +		if (ACPI_FAILURE(status)) {
> +			goto error_exit;
> +		}
>  	}
> 
>  error_exit:
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
> index 0a23897..3aa9162 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -571,7 +571,9 @@ acpi_status acpi_ps_parse_aml(struct
> acpi_walk_state *walk_state)
>  		 * cleanup to do
>  		 */
>  		if (((walk_state->parse_flags & ACPI_PARSE_MODE_MASK)
> ==
> -		     ACPI_PARSE_EXECUTE) || (ACPI_FAILURE(status))) {
> +		     ACPI_PARSE_EXECUTE &&
> +		     !(walk_state->parse_flags &
> ACPI_PARSE_MODULE_LEVEL)) ||
> +		    (ACPI_FAILURE(status))) {
>  			acpi_ds_terminate_control_method(walk_state->
>  							 method_desc,
>  							 walk_state);
> diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
> index cf30cd82..fccc0e5 100644
> --- a/drivers/acpi/acpica/psxface.c
> +++ b/drivers/acpi/acpica/psxface.c
> @@ -252,6 +252,77 @@ cleanup:
> 
> 
> /*********************************************************
> **********************
>   *
> + * FUNCTION:    acpi_ps_execute_table
> + *
> + * PARAMETERS:  info            - Method info block, contains:
> + *                  node            - Node to where the is entered into the
> + *                                    namespace
> + *                  obj_desc        - Pseudo method object describing the AML
> + *                                    code of the entire table
> + *                  pass_number     - Parse or execute pass
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Execute a table
> + *
> +
> **********************************************************
> ********************/
> +
> +acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info)
> +{
> +	acpi_status status;
> +	union acpi_parse_object *op = NULL;
> +	struct acpi_walk_state *walk_state = NULL;
> +
> +	ACPI_FUNCTION_TRACE(ps_execute_table);
> +
> +	/* Create and init a Root Node */
> +
> +	op = acpi_ps_create_scope_op(info->obj_desc-
> >method.aml_start);
> +	if (!op) {
> +		status = AE_NO_MEMORY;
> +		goto cleanup;
> +	}
> +
> +	/* Create and initialize a new walk state */
> +
> +	walk_state =
> +	    acpi_ds_create_walk_state(info->obj_desc->method.owner_id,
> NULL,
> +				      NULL, NULL);
> +	if (!walk_state) {
> +		status = AE_NO_MEMORY;
> +		goto cleanup;
> +	}
> +
> +	status = acpi_ds_init_aml_walk(walk_state, op, info->node,
> +				       info->obj_desc->method.aml_start,
> +				       info->obj_desc->method.aml_length,
> info,
> +				       info->pass_number);
> +	if (ACPI_FAILURE(status)) {
> +		goto cleanup;
> +	}
> +
> +	if (info->obj_desc->method.info_flags &
> ACPI_METHOD_MODULE_LEVEL) {
> +		walk_state->parse_flags |= ACPI_PARSE_MODULE_LEVEL;
> +	}
> +
> +	/*
> +	 * Parse the AML, walk_state will be deleted by parse_aml
> +	 */
> +	status = acpi_ps_parse_aml(walk_state);
> +	walk_state = NULL;
> +
> +cleanup:
> +	if (op) {
> +		acpi_ps_delete_parse_tree(op);
> +	}
> +	if (walk_state) {
> +		acpi_ds_delete_walk_state(walk_state);
> +	}
> +	return_ACPI_STATUS(status);
> +}
> +
> +/********************************************************
> ***********************
> + *
>   * FUNCTION:    acpi_ps_update_parameter_list
>   *
>   * PARAMETERS:  info            - See struct acpi_evaluate_info
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index ac71abc..2b9e87f 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -103,7 +103,8 @@ acpi_status __init acpi_load_tables(void)
>  				"While loading namespace from ACPI
> tables"));
>  	}
> 
> -	if (!acpi_gbl_group_module_level_code) {
> +	if (acpi_gbl_parse_table_as_term_list
> +	    || !acpi_gbl_group_module_level_code) {
>  		/*
>  		 * Initialize the objects that remain uninitialized. This
>  		 * runs the executable AML that may be part of the
> diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
> index 75b5f27..e41424a 100644
> --- a/drivers/acpi/acpica/utxfinit.c
> +++ b/drivers/acpi/acpica/utxfinit.c
> @@ -265,7 +265,8 @@ acpi_status __init acpi_initialize_objects(u32 flags)
>  	 * all of the tables have been loaded. It is a legacy option and is
>  	 * not compatible with other ACPI implementations. See
> acpi_ns_load_table.
>  	 */
> -	if (acpi_gbl_group_module_level_code) {
> +	if (!acpi_gbl_parse_table_as_term_list
> +	    && acpi_gbl_group_module_level_code) {
>  		acpi_ns_exec_module_code_list();
> 
>  		/*
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 4e4c214..22b0397 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -195,6 +195,12 @@ ACPI_INIT_GLOBAL(u8,
> acpi_gbl_do_not_use_xsdt, FALSE);
>  ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, FALSE);
> 
>  /*
> + * Optionally support module level code by parsing the entire table as
> + * a term_list. Default is FALSE, do not execute entire table.
> + */
> +ACPI_INIT_GLOBAL(u8, acpi_gbl_parse_table_as_term_list, FALSE);
> +
> +/*
>   * Optionally use 32-bit FADT addresses if and when there is a conflict
>   * (address mismatch) between the 32-bit and 64-bit versions of the
>   * address. Although ACPICA adheres to the ACPI specification which
> --
> 1.7.10

