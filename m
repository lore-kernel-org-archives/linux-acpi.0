From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/5] ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by
 switching to new TermList grammar for table loading
Date: Tue, 5 Jul 2016 02:09:10 +0200
Message-ID: <CAJZ5v0iJQxBJs0hHPADCN=iHdcn0M+GzDzHF+UhywUL29_BvHg@mail.gmail.com>
References: <cover.1466479787.git.lv.zheng@intel.com> <e481a3b182657e907fb1db6f6f71144c36228ddc.1466479787.git.lv.zheng@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBFFF69@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36474 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbcGEAJN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 20:09:13 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBFFF69@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Jul 5, 2016 at 1:42 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: Zheng, Lv
>> Subject: [PATCH v4 3/5] ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by
>> switching to new TermList grammar for table loading
>>
>> The MLC (Module Level Code) is an ACPICA terminology describing the
>> AML
>> code out of any control method, its support is the main contention of the
>> interpreter behavior during the table loading.
>>
>> The original implementation of MLC in ACPICA had several issues:
>> 1. Out of any control method, besides of the object creating opcodes, only
>>    the code blocks wrapped by "If/Else/While" opcodes were supported.
>> 2. The supported MLC code blocks were executed after loading the table
>>    rather than being executed right in place.
>>
>> ==========================================================
>> ==
>>    The demo of this order issue is as follows:
>>      Name (OBJ1, 1)
>>      If (CND1 == 1)
>>      {
>>        Name (OBJ2, 2)
>>      }
>>      Name (OBJ3, 3)
>>    The original MLC support created OBJ2 after OBJ3's creation.
>>
>> ==========================================================
>> ==
>> Other than these limitations, MLC support in ACPICA looks correct. And
>> supporting this should be easy/natural for ACPICA, but enabling of this
>> was
>> blocked by some ACPICA internal and OSPM specific initialization order
>> issues we've fixed recently. The wrong support started from the following
>> false bug fixing commit:
>>   Commit: 80d7951177315f70b5ffd8663985fbf725d07799
>>   Subject: Add support for module-level executable AML code.
>>
>> We can confirm Windows interpreter behavior via reverse engineering
>> means.
>> It can be proven that not only If/Else/While wrapped code blocks, all
>> opcodes can be executed at the module level, including operation region
>> accesses. And it can be proven that the MLC should be executed right in
>> place, not in such a deferred way executed after loading the table.
>>
>> And the above facts indeed reflect the spec words around ACPI definition
>> block tables (DSDT/SSDT/...), the entire table and the Scope object is
>> defined by the AML specification in BNF style as:
>>   AMLCode := DefBlockHeader TermList
>>   DefScope := ScopeOp PkgLength NameString TermList
>> The bodies of the scope opening terms (AMLCode/Scope) are all TermList,
>> thus the table loading should be no difference than the control method
>> evaluations as the body of the Method is also defined by the AML
>> specification as TermList:
>>   DefMethod := MethodOp PkgLength NameString MethodFlags TermList
>> The only difference is: after evaluating control method, created named
>> objects may be freed due to no reference, while named objects created by
>> the table loading should only be freed after unloading the table.
>>
>> So this patch follows the spec and the de-facto standard behavior, enables
>> the new grammar (TermList) for the table loading.
>>
>> By doing so, beyond the fixes to the above issues, we can see additional
>> differences comparing to the old grammar based table loading:
>> 1. Originally, beyond the scope opening terms (AMLCode/Scope),
>>    If/Else/While wrapped code blocks under the scope creating terms
>>    (Device/PowerResource/Processor/ThermalZone) are also supported as
>>    deferred MLC, which violates the spec defined grammar where ObjectList
>>    is enforced. With MLC support improved as non-deferred, the interpreter
>>    parses such scope creating terms as TermList rather ObjectList like the
>>    scope opening terms.
>>    After probing the Windows behavior and proving that it also parses
>> these
>>    terms as TermList, we submitted an ECR (Engineering Change Request) to
>>    the ASWG (ACPI Specification Working Group) to clarify this. The ECR is
>>    titled as "ASL Grammar Clarification for Executable AML Opcodes" and
>> has
>>    been accepted by the ASWG. The new grammar will appear in ACPI
>>    specification 6.2.
>> 2. Originally, Buffer/Package/OperationRegion/CreateXXXField/BankField
>>    arguments are evaluated in a deferred way after loading the table. With
>>    MLC support improved, they are also parsed right in place during the
>>    table loading.
>>    This is also Windows compliant and the only difference is the removal
>>    of the debugging messages implemented before
>> acpi_ds_execute_arguments(),
>>    see Link 1 for the details. A previous commit should have ensured that
>>    acpi_check_address_range() won't regress.
>>
>> Note that enabling this feature may cause regressions due to long term
>> Linux ACPI support on top of the wrong grammar. So this patch also
>> prepares
>> a global option to be used to roll back to the old grammar during the
>> period between a regression is reported and the regression is
>> root-cause-fixed. ACPICA BZ 963, fixed by Lv Zheng.
>>
>> Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=112911
>> Link 2: https://bugs.acpica.org/show_bug.cgi?id=963
>> Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> ---
>>  drivers/acpi/acpica/acnamesp.h |    3 +
>>  drivers/acpi/acpica/acparser.h |    2 +
>>  drivers/acpi/acpica/evrgnini.c |    3 +-
>>  drivers/acpi/acpica/exconfig.c |    3 +-
>>  drivers/acpi/acpica/nsload.c   |    3 +-
>>  drivers/acpi/acpica/nsparse.c  |  166
>> ++++++++++++++++++++++++++++++++--------
>>  drivers/acpi/acpica/psparse.c  |    4 +-
>>  drivers/acpi/acpica/psxface.c  |   71 +++++++++++++++++
>>  drivers/acpi/acpica/tbxfload.c |    3 +-
>>  drivers/acpi/acpica/utxfinit.c |    3 +-
>>  include/acpi/acpixf.h          |    6 ++
>>  11 files changed, 229 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/acnamesp.h
>> b/drivers/acpi/acpica/acnamesp.h
>> index f33a4ba..829672a 100644
>> --- a/drivers/acpi/acpica/acnamesp.h
>> +++ b/drivers/acpi/acpica/acnamesp.h
>> @@ -130,6 +130,9 @@ acpi_status
>>  acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node
>> *start_node);
>>
>>  acpi_status
>> +acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node
>> *start_node);
>> +
>> +acpi_status
>>  acpi_ns_one_complete_parse(u32 pass_number,
>>                          u32 table_index,
>>                          struct acpi_namespace_node *start_node);
>> diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
>> index fc30577..939d411 100644
>> --- a/drivers/acpi/acpica/acparser.h
>> +++ b/drivers/acpi/acpica/acparser.h
>> @@ -78,6 +78,8 @@ extern const u8 acpi_gbl_long_op_index[];
>>   */
>>  acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info);
>>
>> +acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info);
>> +
>>  /*
>>   * psargs - Parse AML opcode arguments
>>   */
>> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
>> index b6ea9c0..3843f1f 100644
>> --- a/drivers/acpi/acpica/evrgnini.c
>> +++ b/drivers/acpi/acpica/evrgnini.c
>> @@ -553,7 +553,8 @@ acpi_ev_initialize_region(union
>> acpi_operand_object *region_obj,
>>                                *
>>                                * See acpi_ns_exec_module_code
>>                                */
>> -                             if (obj_desc->method.
>> +                             if (!acpi_gbl_parse_table_as_term_list &&
>> +                                 obj_desc->method.
>>                                   info_flags &
>> ACPI_METHOD_MODULE_LEVEL) {
>>                                       handler_obj =
>>                                           obj_desc-
>> >method.dispatch.handler;
>> diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
>> index 21932d6..75679bc 100644
>> --- a/drivers/acpi/acpica/exconfig.c
>> +++ b/drivers/acpi/acpica/exconfig.c
>> @@ -120,7 +120,8 @@ acpi_ex_add_table(u32 table_index,
>>       /* Execute any module-level code that was found in the table */
>>
>>       acpi_ex_exit_interpreter();
>> -     if (acpi_gbl_group_module_level_code) {
>> +     if (!acpi_gbl_parse_table_as_term_list
>> +         && acpi_gbl_group_module_level_code) {
>>               acpi_ns_exec_module_code_list();
>>       }
>>       acpi_ex_enter_interpreter();
>> diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
>> index b5e2b0a..2daa9a09 100644
>> --- a/drivers/acpi/acpica/nsload.c
>> +++ b/drivers/acpi/acpica/nsload.c
>> @@ -162,7 +162,8 @@ unlock:
>>        * other ACPI implementations. Optionally, the execution can be
>> deferred
>>        * until later, see acpi_initialize_objects.
>>        */
>> -     if (!acpi_gbl_group_module_level_code) {
>> +     if (!acpi_gbl_parse_table_as_term_list
>> +         && !acpi_gbl_group_module_level_code) {
>>               acpi_ns_exec_module_code_list();
>>       }
>>
>> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
>> index 1783cd7..f475889 100644
>> --- a/drivers/acpi/acpica/nsparse.c
>> +++ b/drivers/acpi/acpica/nsparse.c
>> @@ -54,6 +54,98 @@ ACPI_MODULE_NAME("nsparse")
>>
>>
>> /*********************************************************
>> **********************
>>   *
>> + * FUNCTION:    ns_execute_table
>> + *
>> + * PARAMETERS:  table_desc      - An ACPI table descriptor for table to
>> parse
>> + *              start_node      - Where to enter the table into the namespace
>> + *
>> + * RETURN:      Status
>> + *
>> + * DESCRIPTION: Load ACPI/AML table by executing the entire table as a
>> + *              term_list.
>> + *
>> +
>> **********************************************************
>> ********************/
>> +acpi_status
>> +acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node
>> *start_node)
>> +{
>> +     acpi_status status;
>> +     struct acpi_table_header *table;
>> +     acpi_owner_id owner_id;
>> +     struct acpi_evaluate_info *info = NULL;
>> +     u32 aml_length;
>> +     u8 *aml_start;
>> +     union acpi_operand_object *method_obj = NULL;
>> +
>> +     ACPI_FUNCTION_TRACE(ns_execute_table);
>> +
>> +     status = acpi_get_table_by_index(table_index, &table);
>> +     if (ACPI_FAILURE(status)) {
>> +             return_ACPI_STATUS(status);
>> +     }
>> +
>> +     /* Table must consist of at least a complete header */
>> +
>> +     if (table->length < sizeof(struct acpi_table_header)) {
>> +             return_ACPI_STATUS(AE_BAD_HEADER);
>> +     }
>> +
>> +     aml_start = (u8 *)table + sizeof(struct acpi_table_header);
>> +     aml_length = table->length - sizeof(struct acpi_table_header);
>> +
>> +     status = acpi_tb_get_owner_id(table_index, &owner_id);
>> +     if (ACPI_FAILURE(status)) {
>> +             return_ACPI_STATUS(status);
>> +     }
>> +
>> +     /* Create, initialize, and link a new temporary method object */
>> +
>> +     method_obj =
>> acpi_ut_create_internal_object(ACPI_TYPE_METHOD);
>> +     if (!method_obj) {
>> +             return_ACPI_STATUS(AE_NO_MEMORY);
>> +     }
>> +
>> +     /* Allocate the evaluation information block */
>> +
>> +     info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
>> +     if (!info) {
>> +             status = AE_NO_MEMORY;
>> +             goto cleanup;
>> +     }
>> +
>> +     ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
>> +                       "Create table code block: %p\n", method_obj));
>> +
>> +     method_obj->method.aml_start = aml_start;
>> +     method_obj->method.aml_length = aml_length;
>> +     method_obj->method.owner_id = owner_id;
>> +     method_obj->method.info_flags |=
>> ACPI_METHOD_MODULE_LEVEL;
>> +
>> +     info->pass_number = ACPI_IMODE_EXECUTE;
>> +     info->node = start_node;
>> +     info->obj_desc = method_obj;
>> +     info->node_flags = info->node->flags;
>> +     info->full_pathname = acpi_ns_get_normalized_pathname(info-
>> >node, TRUE);
>> +     if (!info->full_pathname) {
>> +             status = AE_NO_MEMORY;
>> +             goto cleanup;
>> +     }
>> +
>> +     (void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
>> +     status = acpi_ps_execute_table(info);
>> +     (void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> [Lv Zheng]
> I got a report that we have lock order issue in the previous bug fix:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2f38b1b1
> And I'll send a quick fix for that later today.
>
> After investigation, we found that ACPICA namespace lock design actually requires a big change in order to support this grammar change.
> This means that this patch still need to be improved.
> And the above 3 lines are currently known to be not compliant to the current ACPICA namespace lock design.
>
> So please drop this series, and I'll re-send this series after improving the ACPICA namespace lock design.
>

Dropped, thanks!
