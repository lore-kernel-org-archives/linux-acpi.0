From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: Divergence: remove unwanted spaces for typedef
Date: Wed,  4 May 2016 13:48:13 +0800
Message-ID: <02866199a1582483ee56c513955dc3d9652373cb.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit b2294cae776f5a66a7697414b21949d307e6856f

This patch removes unwanted spaces for typedef. This solution doesn't cover
function types.

Note that the linuxize result of this commit is very giant and should have
many conflicts against the current Linux upstream. Thus it is required to
modify the linuxize result of this commit and the commits around it
manually in order to have them merged to the Linux upstream. Since this is
very costy, we should do this only once, and if we can't ensure to do this
only once, we need to revert the Linux code to the wrong indentation result
before merging the linuxize result of this commit. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/b2294cae
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acdebug.h                      |    6 +-
 drivers/acpi/acpica/acevents.h                     |    1 +
 drivers/acpi/acpica/acinterp.h                     |    2 +-
 drivers/acpi/acpica/aclocal.h                      |   31 +++----
 drivers/acpi/acpica/acresrc.h                      |    6 +-
 drivers/acpi/acpica/actables.h                     |    2 +-
 drivers/acpi/acpica/acutils.h                      |   22 ++---
 drivers/acpi/acpica/dbcmds.c                       |    4 +-
 drivers/acpi/acpica/dbconvert.c                    |    4 +-
 drivers/acpi/acpica/dbexec.c                       |    2 +-
 drivers/acpi/acpica/dbinput.c                      |    6 +-
 drivers/acpi/acpica/dbnames.c                      |    2 +-
 drivers/acpi/acpica/dbxface.c                      |    4 +-
 drivers/acpi/acpica/dscontrol.c                    |    4 +-
 drivers/acpi/acpica/dsfield.c                      |    4 +-
 drivers/acpi/acpica/dsinit.c                       |    2 +-
 drivers/acpi/acpica/dsmethod.c                     |    2 +-
 drivers/acpi/acpica/dsutils.c                      |    2 +-
 drivers/acpi/acpica/dswload.c                      |    4 +-
 drivers/acpi/acpica/dswload2.c                     |    4 +-
 drivers/acpi/acpica/dswstate.c                     |    8 +-
 drivers/acpi/acpica/evgpe.c                        |    4 +-
 drivers/acpi/acpica/evgpeblk.c                     |    4 +-
 drivers/acpi/acpica/evgpeutil.c                    |    4 +-
 drivers/acpi/acpica/evhandler.c                    |    2 +-
 drivers/acpi/acpica/evmisc.c                       |    3 +-
 drivers/acpi/acpica/evrgnini.c                     |    2 +-
 drivers/acpi/acpica/evxfgpe.c                      |    2 +-
 drivers/acpi/acpica/exconcat.c                     |    4 +-
 drivers/acpi/acpica/exconfig.c                     |    2 +-
 drivers/acpi/acpica/exconvrt.c                     |    4 +-
 drivers/acpi/acpica/excreate.c                     |    2 +-
 drivers/acpi/acpica/exfield.c                      |    4 +-
 drivers/acpi/acpica/exfldio.c                      |    2 +-
 drivers/acpi/acpica/exoparg3.c                     |    8 +-
 drivers/acpi/acpica/exoparg6.c                     |    2 +-
 drivers/acpi/acpica/exregion.c                     |    4 +-
 drivers/acpi/acpica/exresnte.c                     |    4 +-
 drivers/acpi/acpica/exresolv.c                     |    2 +-
 drivers/acpi/acpica/exresop.c                      |    2 +-
 drivers/acpi/acpica/exstorob.c                     |    4 +-
 drivers/acpi/acpica/hwgpe.c                        |   16 ++--
 drivers/acpi/acpica/hwregs.c                       |    4 +-
 drivers/acpi/acpica/hwxface.c                      |    9 +-
 drivers/acpi/acpica/nsconvert.c                    |    6 +-
 drivers/acpi/acpica/nsnames.c                      |    2 +-
 drivers/acpi/acpica/nsobject.c                     |    4 +-
 drivers/acpi/acpica/nspredef.c                     |    2 +-
 drivers/acpi/acpica/nsrepair.c                     |    2 +-
 drivers/acpi/acpica/nsrepair2.c                    |    6 +-
 drivers/acpi/acpica/nsutils.c                      |    8 +-
 drivers/acpi/acpica/nsxfeval.c                     |    2 +-
 drivers/acpi/acpica/nsxfname.c                     |    8 +-
 drivers/acpi/acpica/nsxfobj.c                      |    6 +-
 drivers/acpi/acpica/psargs.c                       |    2 +-
 drivers/acpi/acpica/psparse.c                      |    4 +-
 drivers/acpi/acpica/psxface.c                      |    2 +-
 drivers/acpi/acpica/rscalc.c                       |   88 ++++++++++----------
 drivers/acpi/acpica/rscreate.c                     |    2 +-
 drivers/acpi/acpica/rsmisc.c                       |    2 +-
 drivers/acpi/acpica/rsutils.c                      |   12 +--
 drivers/acpi/acpica/rsxface.c                      |    6 +-
 drivers/acpi/acpica/tbdata.c                       |    9 +-
 drivers/acpi/acpica/tbfadt.c                       |    2 +-
 drivers/acpi/acpica/tbutils.c                      |    6 +-
 drivers/acpi/acpica/tbxface.c                      |    8 +-
 drivers/acpi/acpica/tbxfroot.c                     |    8 +-
 drivers/acpi/acpica/utalloc.c                      |    5 +-
 drivers/acpi/acpica/utbuffer.c                     |   24 +++---
 drivers/acpi/acpica/utcache.c                      |    7 +-
 drivers/acpi/acpica/utcopy.c                       |   16 ++--
 drivers/acpi/acpica/utids.c                        |    8 +-
 drivers/acpi/acpica/utlock.c                       |    4 +-
 drivers/acpi/acpica/utmath.c                       |    4 +-
 drivers/acpi/acpica/utobject.c                     |   18 ++--
 drivers/acpi/acpica/utosi.c                        |    4 +-
 drivers/acpi/acpica/utownerid.c                    |    6 +-
 drivers/acpi/acpica/utprint.c                      |   14 ++--
 drivers/acpi/acpica/utstring.c                     |    2 +-
 drivers/acpi/acpica/utxface.c                      |    4 +-
 include/acpi/acpiosxf.h                            |   10 +--
 include/acpi/acpixf.h                              |   21 ++---
 include/acpi/actypes.h                             |   41 ++++-----
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   47 +++++------
 .../acpi/os_specific/service_layers/osunixxf.c     |   24 +++---
 tools/power/acpi/tools/acpidump/apdump.c           |    2 +-
 86 files changed, 337 insertions(+), 337 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 9e2e080..f6404ea 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -196,7 +196,7 @@ ACPI_DBR_DEPENDENT_RETURN_VOID(void
 							     acpi_walk_state
 							     *walk_state))
 
- acpi_status acpi_db_display_all_methods(char *display_count_arg);
+acpi_status acpi_db_display_all_methods(char *display_count_arg);
 
 void acpi_db_display_arguments(void);
 
@@ -220,7 +220,7 @@ ACPI_DBR_DEPENDENT_RETURN_VOID(void
  * dbexec - debugger control method execution
  */
 void
-acpi_db_execute(char *name, char **args, acpi_object_type * types, u32 flags);
+acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags);
 
 void
 acpi_db_create_execution_threads(char *num_threads_arg,
@@ -271,7 +271,7 @@ void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 acpi_status acpi_db_user_commands(void);
 
 char *acpi_db_get_next_token(char *string,
-			     char **next, acpi_object_type * return_type);
+			     char **next, acpi_object_type *return_type);
 
 /*
  * dbobject
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 17f2217..77af91c 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -72,6 +72,7 @@ acpi_status acpi_ev_init_global_lock_handler(void);
 ACPI_HW_DEPENDENT_RETURN_OK(acpi_status
 			    acpi_ev_acquire_global_lock(u16 timeout))
 ACPI_HW_DEPENDENT_RETURN_OK(acpi_status acpi_ev_release_global_lock(void))
+
 acpi_status acpi_ev_remove_global_lock_handler(void);
 
 /*
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 8b09d28..7ead235 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -370,7 +370,7 @@ acpi_ex_resolve_to_value(union acpi_operand_object **stack_ptr,
 acpi_status
 acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			 union acpi_operand_object *operand,
-			 acpi_object_type * return_type,
+			 acpi_object_type *return_type,
 			 union acpi_operand_object **return_desc);
 
 /*
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 379797e..166a67f 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -278,7 +278,7 @@ struct acpi_create_field_info {
 };
 
 typedef
-acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
+acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
 
 /*
  * Bitmapped ACPI types. Used internally only
@@ -395,11 +395,12 @@ union acpi_predefined_info {
 
 /* Return object auto-repair info */
 
-typedef acpi_status(*acpi_object_converter) (struct acpi_namespace_node * scope,
-					     union acpi_operand_object
-					     *original_object,
-					     union acpi_operand_object
-					     **converted_object);
+typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
+					      scope,
+					      union acpi_operand_object *
+					      original_object,
+					      union acpi_operand_object **
+					      converted_object);
 
 struct acpi_simple_repair_info {
 	char name[ACPI_NAME_SIZE];
@@ -539,10 +540,10 @@ struct acpi_gpe_device_info {
 	struct acpi_namespace_node *gpe_device;
 };
 
-typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
-					 gpe_xrupt_info,
-					 struct acpi_gpe_block_info * gpe_block,
-					 void *context);
+typedef acpi_status (*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
+					  gpe_xrupt_info,
+					  struct acpi_gpe_block_info *
+					  gpe_block, void *context);
 
 /* Information about each particular fixed event */
 
@@ -657,10 +658,11 @@ struct acpi_result_values {
 };
 
 typedef
-acpi_status(*acpi_parse_downwards) (struct acpi_walk_state * walk_state,
-				    union acpi_parse_object ** out_op);
+acpi_status (*acpi_parse_downwards) (struct acpi_walk_state * walk_state,
+				     union acpi_parse_object ** out_op);
 
-typedef acpi_status(*acpi_parse_upwards) (struct acpi_walk_state * walk_state);
+typedef
+acpi_status (*acpi_parse_upwards) (struct acpi_walk_state * walk_state);
 
 /* Global handlers for AML Notifies */
 
@@ -700,7 +702,8 @@ union acpi_generic_state {
  *
  ****************************************************************************/
 
-typedef acpi_status(*acpi_execute_op) (struct acpi_walk_state * walk_state);
+typedef
+acpi_status (*acpi_execute_op) (struct acpi_walk_state * walk_state);
 
 /* Address Range info block */
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index baacde8..63da1e3 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -224,15 +224,15 @@ acpi_rs_get_aei_method_data(struct acpi_namespace_node *node,
  */
 acpi_status
 acpi_rs_get_list_length(u8 *aml_buffer,
-			u32 aml_buffer_length, acpi_size * size_needed);
+			u32 aml_buffer_length, acpi_size *size_needed);
 
 acpi_status
 acpi_rs_get_aml_length(struct acpi_resource *resource_list,
-		       acpi_size resource_list_size, acpi_size * size_needed);
+		       acpi_size resource_list_size, acpi_size *size_needed);
 
 acpi_status
 acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
-				     acpi_size * buffer_size_needed);
+				     acpi_size *buffer_size_needed);
 
 acpi_status
 acpi_rs_convert_aml_to_resources(u8 * aml,
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index fa81099..848ad3a 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -131,7 +131,7 @@ acpi_status acpi_tb_allocate_owner_id(u32 table_index);
 
 acpi_status acpi_tb_release_owner_id(u32 table_index);
 
-acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id);
+acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id);
 
 /*
  * tbutils - table manager utilities
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 4ff971c..107f9e0 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -136,16 +136,16 @@ extern const char *acpi_gbl_pt_decode[];
 #define ACPI_SMALL_VARIABLE_LENGTH      3
 
 typedef
-acpi_status(*acpi_walk_aml_callback) (u8 *aml,
-				      u32 length,
-				      u32 offset,
-				      u8 resource_index, void **context);
+acpi_status (*acpi_walk_aml_callback) (u8 *aml,
+				       u32 length,
+				       u32 offset,
+				       u8 resource_index, void **context);
 
 typedef
-acpi_status(*acpi_pkg_callback) (u8 object_type,
-				 union acpi_operand_object *source_object,
-				 union acpi_generic_state * state,
-				 void *context);
+acpi_status (*acpi_pkg_callback) (u8 object_type,
+				  union acpi_operand_object * source_object,
+				  union acpi_generic_state * state,
+				  void *context);
 
 struct acpi_pkg_info {
 	u8 *free_space;
@@ -424,7 +424,7 @@ union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size);
 union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size);
 
 acpi_status
-acpi_ut_get_object_size(union acpi_operand_object *obj, acpi_size * obj_length);
+acpi_ut_get_object_size(union acpi_operand_object *obj, acpi_size *obj_length);
 
 /*
  * utosi - Support for the _OSI predefined control method
@@ -541,9 +541,9 @@ acpi_ut_display_init_pathname(u8 type,
 /*
  * utownerid - Support for Table/Method Owner IDs
  */
-acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id);
+acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id);
 
-void acpi_ut_release_owner_id(acpi_owner_id * owner_id);
+void acpi_ut_release_owner_id(acpi_owner_id *owner_id);
 
 /*
  * utresrc
diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 772178c..62bd446 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -738,9 +738,9 @@ acpi_dm_test_resource_conversion(struct acpi_namespace_node *node, char *name)
 	original_aml = return_buffer.pointer;
 
 	acpi_dm_compare_aml_resources(original_aml->buffer.pointer,
-				      (acpi_rsdesc_size) original_aml->buffer.
+				      (acpi_rsdesc_size)original_aml->buffer.
 				      length, new_aml.pointer,
-				      (acpi_rsdesc_size) new_aml.length);
+				      (acpi_rsdesc_size)new_aml.length);
 
 	/* Cleanup and exit */
 
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index c79c5fb..7cd07b2 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -194,7 +194,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
  *
  ******************************************************************************/
 
-acpi_status acpi_db_convert_to_package(char *string, union acpi_object * object)
+acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 {
 	char *this;
 	char *next;
@@ -252,7 +252,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object * object)
 
 acpi_status
 acpi_db_convert_to_object(acpi_object_type type,
-			  char *string, union acpi_object * object)
+			  char *string, union acpi_object *object)
 {
 	acpi_status status = AE_OK;
 
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index c814855..12df291 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -361,7 +361,7 @@ acpi_db_execution_walk(acpi_handle obj_handle,
  ******************************************************************************/
 
 void
-acpi_db_execute(char *name, char **args, acpi_object_type * types, u32 flags)
+acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 {
 	acpi_status status;
 	struct acpi_buffer return_obj;
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index f53cb30..7cd5d2e 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -466,7 +466,7 @@ static void acpi_db_display_help(char *command)
  ******************************************************************************/
 
 char *acpi_db_get_next_token(char *string,
-			     char **next, acpi_object_type * return_type)
+			     char **next, acpi_object_type *return_type)
 {
 	char *start;
 	u32 depth;
@@ -684,8 +684,8 @@ static u32 acpi_db_match_command(char *user_command)
 
 acpi_status
 acpi_db_command_dispatch(char *input_buffer,
-			 struct acpi_walk_state * walk_state,
-			 union acpi_parse_object * op)
+			 struct acpi_walk_state *walk_state,
+			 union acpi_parse_object *op)
 {
 	u32 temp;
 	u32 command_index;
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3c23b5a..4c9e59a 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -285,7 +285,7 @@ void acpi_db_dump_namespace_by_owner(char *owner_arg, char *depth_arg)
 	u32 max_depth = ACPI_UINT32_MAX;
 	acpi_owner_id owner_id;
 
-	owner_id = (acpi_owner_id) strtoul(owner_arg, NULL, 0);
+	owner_id = (acpi_owner_id)strtoul(owner_arg, NULL, 0);
 
 	/* Now we can check for the depth argument */
 
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index e94e0d8..124db23 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -162,8 +162,8 @@ void acpi_db_signal_break_point(struct acpi_walk_state *walk_state)
  ******************************************************************************/
 
 acpi_status
-acpi_db_single_step(struct acpi_walk_state * walk_state,
-		    union acpi_parse_object * op, u32 opcode_class)
+acpi_db_single_step(struct acpi_walk_state *walk_state,
+		    union acpi_parse_object *op, u32 opcode_class)
 {
 	union acpi_parse_object *next;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index c9a663f..4ddcbf1 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -163,8 +163,8 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
-			    union acpi_parse_object * op)
+acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
+			    union acpi_parse_object *op)
 {
 	acpi_status status = AE_OK;
 	union acpi_generic_state *control_state;
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 0cd777f..6a4b603 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -147,8 +147,8 @@ acpi_ds_create_external_region(acpi_status lookup_status,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_create_buffer_field(union acpi_parse_object * op,
-			    struct acpi_walk_state * walk_state)
+acpi_ds_create_buffer_field(union acpi_parse_object *op,
+			    struct acpi_walk_state *walk_state)
 {
 	union acpi_parse_object *arg;
 	struct acpi_namespace_node *node;
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 5aa1c5f..f1e6dcc 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -188,7 +188,7 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 
 acpi_status
 acpi_ds_initialize_objects(u32 table_index,
-			   struct acpi_namespace_node * start_node)
+			   struct acpi_namespace_node *start_node)
 {
 	acpi_status status;
 	struct acpi_init_walk_info info;
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 1982310..ddfec05 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -209,7 +209,7 @@ acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_method_error(acpi_status status, struct acpi_walk_state * walk_state)
+acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 {
 	u32 aml_offset;
 
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 8ca9416..f393de9 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -569,7 +569,7 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 					/* TBD: May only be temporary */
 
 					obj_desc =
-					    acpi_ut_create_string_object((acpi_size) name_length);
+					    acpi_ut_create_string_object((acpi_size)name_length);
 
 					strncpy(obj_desc->string.pointer,
 						name_string, name_length);
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index d1cedcf..fd34040 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -137,8 +137,8 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
  ******************************************************************************/
 
 acpi_status
-acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
-		       union acpi_parse_object ** out_op)
+acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
+		       union acpi_parse_object **out_op)
 {
 	union acpi_parse_object *op;
 	struct acpi_namespace_node *node;
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 0bac6e1..762db3f 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -490,8 +490,8 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 
 			status =
 			    acpi_ds_create_index_field(op,
-						       (acpi_handle) arg->
-						       common.node, walk_state);
+						       (acpi_handle)arg->common.
+						       node, walk_state);
 			break;
 
 		case AML_BANK_FIELD_OP:
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 6ec8dca..e333869 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -144,7 +144,7 @@ acpi_ds_result_pop(union acpi_operand_object **object,
 
 acpi_status
 acpi_ds_result_push(union acpi_operand_object *object,
-		    struct acpi_walk_state * walk_state)
+		    struct acpi_walk_state *walk_state)
 {
 	union acpi_generic_state *state;
 	acpi_status status;
@@ -307,7 +307,7 @@ static acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *walk_state)
  ******************************************************************************/
 
 acpi_status
-acpi_ds_obj_stack_push(void *object, struct acpi_walk_state * walk_state)
+acpi_ds_obj_stack_push(void *object, struct acpi_walk_state *walk_state)
 {
 	ACPI_FUNCTION_NAME(ds_obj_stack_push);
 
@@ -354,7 +354,7 @@ acpi_ds_obj_stack_push(void *object, struct acpi_walk_state * walk_state)
  ******************************************************************************/
 
 acpi_status
-acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state * walk_state)
+acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state *walk_state)
 {
 	u32 i;
 
@@ -411,7 +411,7 @@ acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 		return;
 	}
 
-	for (i = (s32) pop_count - 1; i >= 0; i--) {
+	for (i = (s32)pop_count - 1; i >= 0; i--) {
 		if (walk_state->num_operands == 0) {
 			return;
 		}
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index b47e62aaf..4b4949c 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -440,7 +440,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 
 				gpe_event_info =
 				    &gpe_block->
-				    event_info[((acpi_size) i *
+				    event_info[((acpi_size)i *
 						ACPI_GPE_REGISTER_WIDTH) + j];
 				gpe_number =
 				    j + gpe_register_info->base_gpe_number;
@@ -652,7 +652,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
  *
  ******************************************************************************/
 
-acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info * gpe_event_info)
+acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 447fa1c..d54014c 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -211,7 +211,7 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 	/* Allocate the GPE register information block */
 
-	gpe_register_info = ACPI_ALLOCATE_ZEROED((acpi_size) gpe_block->
+	gpe_register_info = ACPI_ALLOCATE_ZEROED((acpi_size)gpe_block->
 						 register_count *
 						 sizeof(struct
 							acpi_gpe_register_info));
@@ -225,7 +225,7 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 	 * Allocate the GPE event_info block. There are eight distinct GPEs
 	 * per register. Initialization to zeros is sufficient.
 	 */
-	gpe_event_info = ACPI_ALLOCATE_ZEROED((acpi_size) gpe_block->gpe_count *
+	gpe_event_info = ACPI_ALLOCATE_ZEROED((acpi_size)gpe_block->gpe_count *
 					      sizeof(struct
 						     acpi_gpe_event_info));
 	if (!gpe_event_info) {
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 66c4b5b..3f150d5 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -163,7 +163,7 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 acpi_status
 acpi_ev_get_gpe_xrupt_block(u32 interrupt_number,
-			    struct acpi_gpe_xrupt_info ** gpe_xrupt_block)
+			    struct acpi_gpe_xrupt_info **gpe_xrupt_block)
 {
 	struct acpi_gpe_xrupt_info *next_gpe_xrupt;
 	struct acpi_gpe_xrupt_info *gpe_xrupt;
@@ -320,7 +320,7 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		/* Now look at the individual GPEs in this byte register */
 
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
-			gpe_event_info = &gpe_block->event_info[((acpi_size) i *
+			gpe_event_info = &gpe_block->event_info[((acpi_size)i *
 								 ACPI_GPE_REGISTER_WIDTH)
 								+ j];
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 0f6be89..24768ca 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -359,7 +359,7 @@ union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
  ******************************************************************************/
 
 acpi_status
-acpi_ev_install_space_handler(struct acpi_namespace_node * node,
+acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 			      acpi_adr_space_type space_id,
 			      acpi_adr_space_handler handler,
 			      acpi_adr_space_setup setup, void *context)
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index c67d78c..f51d43a 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -99,8 +99,7 @@ u8 acpi_ev_is_notify_object(struct acpi_namespace_node *node)
  ******************************************************************************/
 
 acpi_status
-acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
-			     u32 notify_value)
+acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 {
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *handler_list_head = NULL;
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 6972ab4..b6ea9c0 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -227,7 +227,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 
 				/* Install a handler for this PCI root bridge */
 
-				status = acpi_install_address_space_handler((acpi_handle) pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
+				status = acpi_install_address_space_handler((acpi_handle)pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
 				if (ACPI_FAILURE(status)) {
 					if (status == AE_SAME_HANDLER) {
 						/*
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 9045671..17cfef7 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -917,7 +917,7 @@ ACPI_EXPORT_SYMBOL(acpi_remove_gpe_block)
  *              the FADT-defined gpe blocks. Otherwise, the GPE block device.
  *
  ******************************************************************************/
-acpi_status acpi_get_gpe_device(u32 index, acpi_handle * gpe_device)
+acpi_status acpi_get_gpe_device(u32 index, acpi_handle *gpe_device)
 {
 	struct acpi_gpe_device_info info;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index 553e014..2423fe0 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -340,7 +340,7 @@ acpi_ex_convert_to_object_type_string(union acpi_operand_object *obj_desc,
 
 	type_string = acpi_ut_get_type_name(obj_desc->common.type);
 
-	return_desc = acpi_ut_create_string_object(((acpi_size) strlen(type_string) + 9));	/* 9 For "[ Object]" */
+	return_desc = acpi_ut_create_string_object(((acpi_size)strlen(type_string) + 9));	/* 9 For "[ Object]" */
 	if (!return_desc) {
 		return (AE_NO_MEMORY);
 	}
@@ -372,7 +372,7 @@ acpi_status
 acpi_ex_concat_template(union acpi_operand_object *operand0,
 			union acpi_operand_object *operand1,
 			union acpi_operand_object **actual_return_desc,
-			struct acpi_walk_state * walk_state)
+			struct acpi_walk_state *walk_state)
 {
 	acpi_status status;
 	union acpi_operand_object *return_desc;
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 03d2eb0..a1d177d 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -334,7 +334,7 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
 acpi_status
 acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		union acpi_operand_object *target,
-		struct acpi_walk_state * walk_state)
+		struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *ddb_handle;
 	struct acpi_table_header *table_header;
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index d0d16da..b7e9b3d 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -441,7 +441,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		 * Need enough space for one ASCII integer (plus null terminator)
 		 */
 		return_desc =
-		    acpi_ut_create_string_object((acpi_size) string_length);
+		    acpi_ut_create_string_object((acpi_size)string_length);
 		if (!return_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -520,7 +520,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		}
 
 		return_desc =
-		    acpi_ut_create_string_object((acpi_size) string_length);
+		    acpi_ut_create_string_object((acpi_size)string_length);
 		if (!return_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index bea9612..613ba6e 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -394,7 +394,7 @@ acpi_status acpi_ex_create_processor(struct acpi_walk_state *walk_state)
 	obj_desc->processor.proc_id = (u8) operand[1]->integer.value;
 	obj_desc->processor.length = (u8) operand[3]->integer.value;
 	obj_desc->processor.address =
-	    (acpi_io_address) operand[2]->integer.value;
+	    (acpi_io_address)operand[2]->integer.value;
 
 	/* Install the processor object in the parent Node */
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index d5d8020..d7d3ee3 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -126,7 +126,7 @@ acpi_ex_get_serial_access_length(u32 accessor_type, u32 access_length)
  ******************************************************************************/
 
 acpi_status
-acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
+acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 			     union acpi_operand_object *obj_desc,
 			     union acpi_operand_object **ret_buffer_desc)
 {
@@ -233,7 +233,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 	 * Note: Field.length is in bits.
 	 */
 	length =
-	    (acpi_size) ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.bit_length);
+	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.bit_length);
 
 	if (length > acpi_gbl_integer_byte_width) {
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index f0c5ed0..72f9176 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -164,7 +164,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 			if (ACPI_ROUND_UP(rgn_desc->region.length,
 					  obj_desc->common_field.
 					  access_byte_width) >=
-			    ((acpi_size) obj_desc->common_field.
+			    ((acpi_size)obj_desc->common_field.
 			     base_byte_offset +
 			     obj_desc->common_field.access_byte_width +
 			     field_datum_byte_offset)) {
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 5aa21c4..69e4e26 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -184,7 +184,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 		/* Get the Integer values from the objects */
 
 		index = operand[1]->integer.value;
-		length = (acpi_size) operand[2]->integer.value;
+		length = (acpi_size)operand[2]->integer.value;
 
 		/*
 		 * If the index is beyond the length of the String/Buffer, or if the
@@ -198,8 +198,8 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 		else if ((index + length) > operand[0]->string.length) {
 			length =
-			    (acpi_size) operand[0]->string.length -
-			    (acpi_size) index;
+			    (acpi_size)operand[0]->string.length -
+			    (acpi_size)index;
 		}
 
 		/* Strings always have a sub-pointer, not so for buffers */
@@ -209,7 +209,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 			/* Always allocate a new buffer for the String */
 
-			buffer = ACPI_ALLOCATE_ZEROED((acpi_size) length + 1);
+			buffer = ACPI_ALLOCATE_ZEROED((acpi_size)length + 1);
 			if (!buffer) {
 				status = AE_NO_MEMORY;
 				goto cleanup;
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index e2b6348..786d53b 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -207,7 +207,7 @@ acpi_ex_do_match(u32 match_op,
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
+acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object **operand = &walk_state->operands[0];
 	union acpi_operand_object *return_desc = NULL;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 3bcea59..31b381c 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -325,14 +325,14 @@ acpi_ex_system_io_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
 
-		status = acpi_hw_read_port((acpi_io_address) address,
+		status = acpi_hw_read_port((acpi_io_address)address,
 					   &value32, bit_width);
 		*value = value32;
 		break;
 
 	case ACPI_WRITE:
 
-		status = acpi_hw_write_port((acpi_io_address) address,
+		status = acpi_hw_write_port((acpi_io_address)address,
 					    (u32)*value, bit_width);
 		break;
 
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index c1e8bfb..a183cb7 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -93,7 +93,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	 */
 	node = *object_ptr;
 	source_desc = acpi_ns_get_attached_object(node);
-	entry_type = acpi_ns_get_type((acpi_handle) node);
+	entry_type = acpi_ns_get_type((acpi_handle)node);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Entry=%p SourceDesc=%p [%s]\n",
 			  node, source_desc,
@@ -106,7 +106,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 		node = ACPI_CAST_PTR(struct acpi_namespace_node, node->object);
 		source_desc = acpi_ns_get_attached_object(node);
-		entry_type = acpi_ns_get_type((acpi_handle) node);
+		entry_type = acpi_ns_get_type((acpi_handle)node);
 		*object_ptr = node;
 	}
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index fedacf1..e1d3878 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -334,7 +334,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 acpi_status
 acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			 union acpi_operand_object *operand,
-			 acpi_object_type * return_type,
+			 acpi_object_type *return_type,
 			 union acpi_operand_object **return_desc)
 {
 	union acpi_operand_object *obj_desc = ACPI_CAST_PTR(void, operand);
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index da6bf0e..27b41fd 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -132,7 +132,7 @@ acpi_ex_check_object_type(acpi_object_type type_needed,
 acpi_status
 acpi_ex_resolve_operands(u16 opcode,
 			 union acpi_operand_object **stack_ptr,
-			 struct acpi_walk_state * walk_state)
+			 struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 28b7248..1dab827 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -188,7 +188,7 @@ acpi_ex_store_string_to_string(union acpi_operand_object *source_desc,
 		 * Clear old string and copy in the new one
 		 */
 		memset(target_desc->string.pointer, 0,
-		       (acpi_size) target_desc->string.length + 1);
+		       (acpi_size)target_desc->string.length + 1);
 		memcpy(target_desc->string.pointer, buffer, length);
 	} else {
 		/*
@@ -204,7 +204,7 @@ acpi_ex_store_string_to_string(union acpi_operand_object *source_desc,
 		}
 
 		target_desc->string.pointer =
-		    ACPI_ALLOCATE_ZEROED((acpi_size) length + 1);
+		    ACPI_ALLOCATE_ZEROED((acpi_size)length + 1);
 
 		if (!target_desc->string.pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 8cc5cc0..bdecd5e 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -166,7 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
+acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info *gpe_event_info)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
@@ -206,7 +206,7 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
  ******************************************************************************/
 
 acpi_status
-acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
+acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status *event_status)
 {
 	u32 in_byte;
@@ -315,8 +315,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-			  struct acpi_gpe_block_info * gpe_block, void *context)
+acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			  struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -352,8 +352,8 @@ acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-			struct acpi_gpe_block_info * gpe_block, void *context)
+acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -390,8 +390,8 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-				 struct acpi_gpe_block_info * gpe_block,
+acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+				 struct acpi_gpe_block_info *gpe_block,
 				 void *context)
 {
 	u32 i;
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 65b300d..035fb52 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -157,7 +157,7 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
+acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 {
 	u64 address;
 	u64 value64;
@@ -214,7 +214,7 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_write(u32 value, struct acpi_generic_address * reg)
+acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 {
 	u64 address;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 312769d..98c26ff 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -91,10 +91,9 @@ acpi_status acpi_reset(void)
 		 * compatibility with other ACPI implementations that have allowed
 		 * BIOS code with bad register width values to go unnoticed.
 		 */
-		status =
-		    acpi_os_write_port((acpi_io_address) reset_reg->address,
-				       acpi_gbl_FADT.reset_value,
-				       ACPI_RESET_REGISTER_WIDTH);
+		status = acpi_os_write_port((acpi_io_address)reset_reg->address,
+					    acpi_gbl_FADT.reset_value,
+					    ACPI_RESET_REGISTER_WIDTH);
 	} else {
 		/* Write the reset value to the reset register */
 
@@ -212,7 +211,7 @@ ACPI_EXPORT_SYMBOL(acpi_read)
  * DESCRIPTION: Write to either memory or IO space.
  *
  ******************************************************************************/
-acpi_status acpi_write(u64 value, struct acpi_generic_address * reg)
+acpi_status acpi_write(u64 value, struct acpi_generic_address *reg)
 {
 	u32 width;
 	u64 address;
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 256f56c..c803bda 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -318,7 +318,7 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_convert_to_unicode(struct acpi_namespace_node * scope,
+acpi_ns_convert_to_unicode(struct acpi_namespace_node *scope,
 			   union acpi_operand_object *original_object,
 			   union acpi_operand_object **return_object)
 {
@@ -385,7 +385,7 @@ acpi_ns_convert_to_unicode(struct acpi_namespace_node * scope,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_convert_to_resource(struct acpi_namespace_node * scope,
+acpi_ns_convert_to_resource(struct acpi_namespace_node *scope,
 			    union acpi_operand_object *original_object,
 			    union acpi_operand_object **return_object)
 {
@@ -464,7 +464,7 @@ acpi_ns_convert_to_resource(struct acpi_namespace_node * scope,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_convert_to_reference(struct acpi_namespace_node * scope,
+acpi_ns_convert_to_reference(struct acpi_namespace_node *scope,
 			     union acpi_operand_object *original_object,
 			     union acpi_operand_object **return_object)
 {
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index eb6e1b8..f03dd41 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -113,7 +113,7 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 
 acpi_status
 acpi_ns_handle_to_pathname(acpi_handle target_handle,
-			   struct acpi_buffer * buffer, u8 no_trailing)
+			   struct acpi_buffer *buffer, u8 no_trailing)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node;
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 051306f..cfa2bb7 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -399,7 +399,7 @@ acpi_ns_attach_data(struct acpi_namespace_node *node,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_detach_data(struct acpi_namespace_node * node,
+acpi_ns_detach_data(struct acpi_namespace_node *node,
 		    acpi_object_handler handler)
 {
 	union acpi_operand_object *obj_desc;
@@ -444,7 +444,7 @@ acpi_ns_detach_data(struct acpi_namespace_node * node,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_get_attached_data(struct acpi_namespace_node * node,
+acpi_ns_get_attached_data(struct acpi_namespace_node *node,
 			  acpi_object_handler handler, void **data)
 {
 	union acpi_operand_object *obj_desc;
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index bd7ddcc..6d78445 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -220,7 +220,7 @@ exit:
  ******************************************************************************/
 
 acpi_status
-acpi_ns_check_object_type(struct acpi_evaluate_info * info,
+acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index)
 {
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 805e36d..9523d41 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -399,7 +399,7 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
  ******************************************************************************/
 
 acpi_status
-acpi_ns_repair_null_element(struct acpi_evaluate_info * info,
+acpi_ns_repair_null_element(struct acpi_evaluate_info *info,
 			    u32 expected_btypes,
 			    u32 package_index,
 			    union acpi_operand_object **return_object_ptr)
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 63edbbb..d533612 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -54,9 +54,9 @@ ACPI_MODULE_NAME("nsrepair2")
  * be repaired on a per-name basis.
  */
 typedef
-acpi_status(*acpi_repair_function) (struct acpi_evaluate_info * info,
-				    union acpi_operand_object
-				    **return_object_ptr);
+acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
+				     union acpi_operand_object **
+				     return_object_ptr);
 
 typedef struct acpi_repair_info {
 	char name[ACPI_NAME_SIZE];
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index c72cc62..784a30b 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -272,11 +272,11 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 			result = &internal_name[i];
 		} else if (num_segments == 2) {
 			internal_name[i] = AML_DUAL_NAME_PREFIX;
-			result = &internal_name[(acpi_size) i + 1];
+			result = &internal_name[(acpi_size)i + 1];
 		} else {
 			internal_name[i] = AML_MULTI_NAME_PREFIX_OP;
-			internal_name[(acpi_size) i + 1] = (char)num_segments;
-			result = &internal_name[(acpi_size) i + 2];
+			internal_name[(acpi_size)i + 1] = (char)num_segments;
+			result = &internal_name[(acpi_size)i + 2];
 		}
 	}
 
@@ -456,7 +456,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 
 			names_index = prefix_length + 2;
 			num_segments = (u8)
-			    internal_name[(acpi_size) prefix_length + 1];
+			    internal_name[(acpi_size)prefix_length + 1];
 			break;
 
 		case AML_DUAL_NAME_PREFIX:
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index a7deeaa..614e4ba 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -256,7 +256,7 @@ acpi_evaluate_object(acpi_handle handle,
 		 * Allocate a new parameter block for the internal objects
 		 * Add 1 to count to allow for null terminated internal list
 		 */
-		info->parameters = ACPI_ALLOCATE_ZEROED(((acpi_size) info->
+		info->parameters = ACPI_ALLOCATE_ZEROED(((acpi_size)info->
 							 param_count +
 							 1) * sizeof(void *));
 		if (!info->parameters) {
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 41f97e8..76a1bd4 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -78,7 +78,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 
 acpi_status
 acpi_get_handle(acpi_handle parent,
-		acpi_string pathname, acpi_handle * ret_handle)
+		acpi_string pathname, acpi_handle *ret_handle)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node = NULL;
@@ -155,7 +155,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_handle)
  *
  ******************************************************************************/
 acpi_status
-acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
+acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer *buffer)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node;
@@ -278,7 +278,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 
 acpi_status
 acpi_get_object_info(acpi_handle handle,
-		     struct acpi_device_info ** return_buffer)
+		     struct acpi_device_info **return_buffer)
 {
 	struct acpi_namespace_node *node;
 	struct acpi_device_info *info;
@@ -448,7 +448,7 @@ acpi_get_object_info(acpi_handle handle,
 		/* Point past the CID PNP_DEVICE_ID array */
 
 		next_id_string +=
-		    ((acpi_size) cid_list->count *
+		    ((acpi_size)cid_list->count *
 		     sizeof(struct acpi_pnp_device_id));
 	}
 
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index c312cd4..32d372b 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -63,7 +63,7 @@ ACPI_MODULE_NAME("nsxfobj")
  * DESCRIPTION: This routine returns the type associatd with a particular handle
  *
  ******************************************************************************/
-acpi_status acpi_get_type(acpi_handle handle, acpi_object_type * ret_type)
+acpi_status acpi_get_type(acpi_handle handle, acpi_object_type *ret_type)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -115,7 +115,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_type)
  *              Handle.
  *
  ******************************************************************************/
-acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
+acpi_status acpi_get_parent(acpi_handle handle, acpi_handle *ret_handle)
 {
 	struct acpi_namespace_node *node;
 	struct acpi_namespace_node *parent_node;
@@ -183,7 +183,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_parent)
 acpi_status
 acpi_get_next_object(acpi_object_type type,
 		     acpi_handle parent,
-		     acpi_handle child, acpi_handle * ret_handle)
+		     acpi_handle child, acpi_handle *ret_handle)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node;
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index d48cbed..c29c930 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -87,7 +87,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	 * used to encode the package length, either 0,1,2, or 3
 	 */
 	byte_count = (aml[0] >> 6);
-	parser_state->aml += ((acpi_size) byte_count + 1);
+	parser_state->aml += ((acpi_size)byte_count + 1);
 
 	/* Get bytes 3, 2, 1 as needed */
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 8038ed2..0a23897 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -130,8 +130,8 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
  ******************************************************************************/
 
 acpi_status
-acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
-			 union acpi_parse_object * op)
+acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
+			 union acpi_parse_object *op)
 {
 	union acpi_parse_object *prev;
 	union acpi_parse_object *next;
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 04b37fc..cf30cd82 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -115,7 +115,7 @@ acpi_debug_trace(const char *name, u32 debug_level, u32 debug_layer, u32 flags)
  *
  ******************************************************************************/
 
-acpi_status acpi_ps_execute_method(struct acpi_evaluate_info * info)
+acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 {
 	acpi_status status;
 	union acpi_parse_object *op;
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 8763ce6..f1e83ad 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -112,7 +112,7 @@ acpi_rs_struct_option_length(struct acpi_resource_source *resource_source)
 	 * resource_source_index (1).
 	 */
 	if (resource_source->string_ptr) {
-		return ((acpi_rs_length) (resource_source->string_length + 1));
+		return ((acpi_rs_length)(resource_source->string_length + 1));
 	}
 
 	return (0);
@@ -188,7 +188,7 @@ acpi_rs_stream_option_length(u32 resource_length,
 
 acpi_status
 acpi_rs_get_aml_length(struct acpi_resource *resource,
-		       acpi_size resource_list_size, acpi_size * size_needed)
+		       acpi_size resource_list_size, acpi_size *size_needed)
 {
 	acpi_size aml_size_needed = 0;
 	struct acpi_resource *resource_end;
@@ -278,11 +278,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 16-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length) (total_size +
-						       acpi_rs_struct_option_length
-						       (&resource->data.
-							address16.
-							resource_source));
+			total_size = (acpi_rs_length)(total_size +
+						      acpi_rs_struct_option_length
+						      (&resource->data.
+						       address16.
+						       resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_ADDRESS32:
@@ -290,11 +290,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 32-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length) (total_size +
-						       acpi_rs_struct_option_length
-						       (&resource->data.
-							address32.
-							resource_source));
+			total_size = (acpi_rs_length)(total_size +
+						      acpi_rs_struct_option_length
+						      (&resource->data.
+						       address32.
+						       resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_ADDRESS64:
@@ -302,11 +302,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 64-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length) (total_size +
-						       acpi_rs_struct_option_length
-						       (&resource->data.
-							address64.
-							resource_source));
+			total_size = (acpi_rs_length)(total_size +
+						      acpi_rs_struct_option_length
+						      (&resource->data.
+						       address64.
+						       resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
@@ -315,28 +315,28 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * Add the size of each additional optional interrupt beyond the
 			 * required 1 (4 bytes for each u32 interrupt number)
 			 */
-			total_size = (acpi_rs_length) (total_size +
-						       ((resource->data.
-							 extended_irq.
-							 interrupt_count -
-							 1) * 4) +
-						       /* Add the size of the optional resource_source info */
-						       acpi_rs_struct_option_length
-						       (&resource->data.
+			total_size = (acpi_rs_length)(total_size +
+						      ((resource->data.
 							extended_irq.
-							resource_source));
+							interrupt_count -
+							1) * 4) +
+						      /* Add the size of the optional resource_source info */
+						      acpi_rs_struct_option_length
+						      (&resource->data.
+						       extended_irq.
+						       resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_GPIO:
 
-			total_size = (acpi_rs_length) (total_size +
-						       (resource->data.gpio.
-							pin_table_length * 2) +
-						       resource->data.gpio.
-						       resource_source.
-						       string_length +
-						       resource->data.gpio.
-						       vendor_length);
+			total_size = (acpi_rs_length)(total_size +
+						      (resource->data.gpio.
+						       pin_table_length * 2) +
+						      resource->data.gpio.
+						      resource_source.
+						      string_length +
+						      resource->data.gpio.
+						      vendor_length);
 
 			break;
 
@@ -348,14 +348,14 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 								   common_serial_bus.
 								   type];
 
-			total_size = (acpi_rs_length) (total_size +
-						       resource->data.
-						       i2c_serial_bus.
-						       resource_source.
-						       string_length +
-						       resource->data.
-						       i2c_serial_bus.
-						       vendor_length);
+			total_size = (acpi_rs_length)(total_size +
+						      resource->data.
+						      i2c_serial_bus.
+						      resource_source.
+						      string_length +
+						      resource->data.
+						      i2c_serial_bus.
+						      vendor_length);
 
 			break;
 
@@ -398,7 +398,7 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 
 acpi_status
 acpi_rs_get_list_length(u8 *aml_buffer,
-			u32 aml_buffer_length, acpi_size * size_needed)
+			u32 aml_buffer_length, acpi_size *size_needed)
 {
 	acpi_status status;
 	u8 *end_aml;
@@ -610,7 +610,7 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 
 acpi_status
 acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
-				     acpi_size * buffer_size_needed)
+				     acpi_size *buffer_size_needed)
 {
 	u32 number_of_elements;
 	acpi_size temp_size_needed = 0;
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 1297889..809b61c 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -347,7 +347,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 					   (u8 *) output_buffer->pointer);
 				path_buffer.pointer = user_prt->source;
 
-				status = acpi_ns_handle_to_pathname((acpi_handle) node, &path_buffer, FALSE);
+				status = acpi_ns_handle_to_pathname((acpi_handle)node, &path_buffer, FALSE);
 
 				/* +1 to include null terminator */
 
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index ce3d0b7..25165ca 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -87,7 +87,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	if (((acpi_size) resource) & 0x3) {
+	if (((acpi_size)resource) & 0x3) {
 
 		/* Each internal resource struct is expected to be 32-bit aligned */
 
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index e0d6023..fa491c6 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -338,7 +338,7 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 	 * Note: Some resource descriptors will have an additional null, so
 	 * we add 1 to the minimum length.
 	 */
-	if (total_length > (acpi_rsdesc_size) (minimum_length + 1)) {
+	if (total_length > (acpi_rsdesc_size)(minimum_length + 1)) {
 
 		/* Get the resource_source_index */
 
@@ -377,7 +377,7 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 				   ACPI_CAST_PTR(char,
 						 &aml_resource_source[1]));
 
-		return ((acpi_rs_length) total_length);
+		return ((acpi_rs_length)total_length);
 	}
 
 	/* resource_source is not present */
@@ -406,9 +406,9 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
  ******************************************************************************/
 
 acpi_rsdesc_size
-acpi_rs_set_resource_source(union aml_resource * aml,
+acpi_rs_set_resource_source(union aml_resource *aml,
 			    acpi_rs_length minimum_length,
-			    struct acpi_resource_source * resource_source)
+			    struct acpi_resource_source *resource_source)
 {
 	u8 *aml_resource_source;
 	acpi_rsdesc_size descriptor_length;
@@ -466,8 +466,8 @@ acpi_rs_set_resource_source(union aml_resource * aml,
  ******************************************************************************/
 
 acpi_status
-acpi_rs_get_prt_method_data(struct acpi_namespace_node * node,
-			    struct acpi_buffer * ret_buffer)
+acpi_rs_get_prt_method_data(struct acpi_namespace_node *node,
+			    struct acpi_buffer *ret_buffer)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 900933b..465ed81 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -433,8 +433,8 @@ ACPI_EXPORT_SYMBOL(acpi_resource_to_address64)
 acpi_status
 acpi_get_vendor_resource(acpi_handle device_handle,
 			 char *name,
-			 struct acpi_vendor_uuid * uuid,
-			 struct acpi_buffer * ret_buffer)
+			 struct acpi_vendor_uuid *uuid,
+			 struct acpi_buffer *ret_buffer)
 {
 	struct acpi_vendor_walk_info info;
 	acpi_status status;
@@ -539,7 +539,7 @@ acpi_rs_match_vendor_resource(struct acpi_resource *resource, void *context)
  ******************************************************************************/
 
 acpi_status
-acpi_walk_resource_buffer(struct acpi_buffer * buffer,
+acpi_walk_resource_buffer(struct acpi_buffer *buffer,
 			  acpi_walk_resource_callback user_function,
 			  void *context)
 {
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 7da79ce..d471df3 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -368,7 +368,7 @@ acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc)
  *****************************************************************************/
 
 acpi_status
-acpi_tb_verify_temp_table(struct acpi_table_desc * table_desc, char *signature)
+acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc, char *signature)
 {
 	acpi_status status = AE_OK;
 
@@ -454,7 +454,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 		table_count = acpi_gbl_root_table_list.current_table_count;
 	}
 
-	tables = ACPI_ALLOCATE_ZEROED(((acpi_size) table_count +
+	tables = ACPI_ALLOCATE_ZEROED(((acpi_size)table_count +
 				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
 				      sizeof(struct acpi_table_desc));
 	if (!tables) {
@@ -467,8 +467,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	if (acpi_gbl_root_table_list.tables) {
 		memcpy(tables, acpi_gbl_root_table_list.tables,
-		       (acpi_size) table_count *
-		       sizeof(struct acpi_table_desc));
+		       (acpi_size)table_count * sizeof(struct acpi_table_desc));
 
 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
@@ -701,7 +700,7 @@ acpi_status acpi_tb_release_owner_id(u32 table_index)
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id)
+acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 635d951..6208069 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -344,7 +344,7 @@ void acpi_tb_parse_fadt(void)
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-	acpi_tb_install_fixed_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
+	acpi_tb_install_fixed_table((acpi_physical_address)acpi_gbl_FADT.Xdsdt,
 				    ACPI_SIG_DSDT, &acpi_gbl_dsdt_index);
 
 	/* If Hardware Reduced flag is set, there is no FACS */
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9240c76..a962a85 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -231,7 +231,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 					   ACPI_FORMAT_UINT64(address64)));
 		}
 #endif
-		return ((acpi_physical_address) (address64));
+		return ((acpi_physical_address)(address64));
 	}
 }
 
@@ -287,12 +287,12 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		 * the XSDT if the revision is > 1 and the XSDT pointer is present,
 		 * as per the ACPI specification.
 		 */
-		address = (acpi_physical_address) rsdp->xsdt_physical_address;
+		address = (acpi_physical_address)rsdp->xsdt_physical_address;
 		table_entry_size = ACPI_XSDT_ENTRY_SIZE;
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
-		address = (acpi_physical_address) rsdp->rsdt_physical_address;
+		address = (acpi_physical_address)rsdp->rsdt_physical_address;
 		table_entry_size = ACPI_RSDT_ENTRY_SIZE;
 	}
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 72a239e..3ecec93 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -99,7 +99,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count)
  ******************************************************************************/
 
 acpi_status __init
-acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
+acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
 	acpi_physical_address rsdp_address;
@@ -120,7 +120,7 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 		/* Root Table Array has been statically allocated by the host */
 
 		memset(initial_table_array, 0,
-		       (acpi_size) initial_table_count *
+		       (acpi_size)initial_table_count *
 		       sizeof(struct acpi_table_desc));
 
 		acpi_gbl_root_table_list.tables = initial_table_array;
@@ -328,7 +328,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
 
 acpi_status
 acpi_get_table(char *signature,
-	       u32 instance, struct acpi_table_header ** out_table)
+	       u32 instance, struct acpi_table_header **out_table)
 {
 	acpi_size tbl_size;
 
@@ -352,7 +352,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
  *
  ******************************************************************************/
 acpi_status
-acpi_get_table_by_index(u32 table_index, struct acpi_table_header ** table)
+acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index b9a78e4..adb6cfc 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -90,7 +90,7 @@ u32 acpi_tb_get_rsdp_length(struct acpi_table_rsdp *rsdp)
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp * rsdp)
+acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 {
 
 	/*
@@ -142,7 +142,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp * rsdp)
  *
  ******************************************************************************/
 
-acpi_status __init acpi_find_root_pointer(acpi_physical_address * table_address)
+acpi_status __init acpi_find_root_pointer(acpi_physical_address *table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
@@ -201,7 +201,7 @@ acpi_status __init acpi_find_root_pointer(acpi_physical_address * table_address)
 			    (u32) ACPI_PTR_DIFF(mem_rover, table_ptr);
 
 			*table_address =
-			    (acpi_physical_address) physical_address;
+			    (acpi_physical_address)physical_address;
 			return_ACPI_STATUS(AE_OK);
 		}
 	}
@@ -234,7 +234,7 @@ acpi_status __init acpi_find_root_pointer(acpi_physical_address * table_address)
 		    (ACPI_HI_RSDP_WINDOW_BASE +
 		     ACPI_PTR_DIFF(mem_rover, table_ptr));
 
-		*table_address = (acpi_physical_address) physical_address;
+		*table_address = (acpi_physical_address)physical_address;
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 3dbdc3a..13324a2 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -231,7 +231,7 @@ acpi_status acpi_ut_delete_caches(void)
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_validate_buffer(struct acpi_buffer * buffer)
+acpi_status acpi_ut_validate_buffer(struct acpi_buffer *buffer)
 {
 
 	/* Obviously, the structure pointer must be valid */
@@ -272,8 +272,7 @@ acpi_status acpi_ut_validate_buffer(struct acpi_buffer * buffer)
  ******************************************************************************/
 
 acpi_status
-acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
-			  acpi_size required_length)
+acpi_ut_initialize_buffer(struct acpi_buffer *buffer, acpi_size required_length)
 {
 	acpi_size input_buffer_length;
 
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 0cfb2b8..bd31faf 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -106,31 +106,31 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 			default:	/* Default is BYTE display */
 
 				acpi_os_printf("%02X ",
-					       buffer[(acpi_size) i + j]);
+					       buffer[(acpi_size)i + j]);
 				break;
 
 			case DB_WORD_DISPLAY:
 
 				ACPI_MOVE_16_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_os_printf("%04X ", temp32);
 				break;
 
 			case DB_DWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_os_printf("%08X ", temp32);
 				break;
 
 			case DB_QWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_os_printf("%08X", temp32);
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j +
+						   &buffer[(acpi_size)i + j +
 							   4]);
 				acpi_os_printf("%08X ", temp32);
 				break;
@@ -158,7 +158,7 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 				acpi_os_printf("// ");
 			}
 
-			buf_char = buffer[(acpi_size) i + j];
+			buf_char = buffer[(acpi_size)i + j];
 			if (isprint(buf_char)) {
 				acpi_os_printf("%c", buf_char);
 			} else {
@@ -274,31 +274,31 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 			default:	/* Default is BYTE display */
 
 				acpi_ut_file_printf(file, "%02X ",
-						    buffer[(acpi_size) i + j]);
+						    buffer[(acpi_size)i + j]);
 				break;
 
 			case DB_WORD_DISPLAY:
 
 				ACPI_MOVE_16_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_ut_file_printf(file, "%04X ", temp32);
 				break;
 
 			case DB_DWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_ut_file_printf(file, "%08X ", temp32);
 				break;
 
 			case DB_QWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
+						   &buffer[(acpi_size)i + j]);
 				acpi_ut_file_printf(file, "%08X", temp32);
 
 				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j +
+						   &buffer[(acpi_size)i + j +
 							   4]);
 				acpi_ut_file_printf(file, "%08X ", temp32);
 				break;
@@ -318,7 +318,7 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 				return;
 			}
 
-			buf_char = buffer[(acpi_size) i + j];
+			buf_char = buffer[(acpi_size)i + j];
 			if (isprint(buf_char)) {
 				acpi_ut_file_printf(file, "%c", buf_char);
 			} else {
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index f8e9978..3b8d23e 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -105,7 +105,7 @@ acpi_os_create_cache(char *cache_name,
  *
  ******************************************************************************/
 
-acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
+acpi_status acpi_os_purge_cache(struct acpi_memory_list *cache)
 {
 	void *next;
 	acpi_status status;
@@ -151,7 +151,7 @@ acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_delete_cache(struct acpi_memory_list * cache)
+acpi_status acpi_os_delete_cache(struct acpi_memory_list *cache)
 {
 	acpi_status status;
 
@@ -184,8 +184,7 @@ acpi_status acpi_os_delete_cache(struct acpi_memory_list * cache)
  *
  ******************************************************************************/
 
-acpi_status
-acpi_os_release_object(struct acpi_memory_list * cache, void *object)
+acpi_status acpi_os_release_object(struct acpi_memory_list *cache, void *object)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 5ba8cb8..82f9714 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -53,7 +53,7 @@ ACPI_MODULE_NAME("utcopy")
 static acpi_status
 acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 				union acpi_object *external_object,
-				u8 *data_space, acpi_size * buffer_space_used);
+				u8 *data_space, acpi_size *buffer_space_used);
 
 static acpi_status
 acpi_ut_copy_ielement_to_ielement(u8 object_type,
@@ -63,7 +63,7 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 
 static acpi_status
 acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
-				  u8 *buffer, acpi_size * space_used);
+				  u8 *buffer, acpi_size *space_used);
 
 static acpi_status
 acpi_ut_copy_esimple_to_isimple(union acpi_object *user_obj,
@@ -111,7 +111,7 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
 static acpi_status
 acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 				union acpi_object *external_object,
-				u8 *data_space, acpi_size * buffer_space_used)
+				u8 *data_space, acpi_size *buffer_space_used)
 {
 	acpi_status status = AE_OK;
 
@@ -151,7 +151,7 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 
 		memcpy((void *)data_space,
 		       (void *)internal_object->string.pointer,
-		       (acpi_size) internal_object->string.length + 1);
+		       (acpi_size)internal_object->string.length + 1);
 		break;
 
 	case ACPI_TYPE_BUFFER:
@@ -331,7 +331,7 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
 
 static acpi_status
 acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
-				  u8 *buffer, acpi_size * space_used)
+				  u8 *buffer, acpi_size *space_used)
 {
 	union acpi_object *external_object;
 	acpi_status status;
@@ -362,7 +362,7 @@ acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
 	 * Leave room for an array of ACPI_OBJECTS in the buffer
 	 * and move the free space past it
 	 */
-	info.length += (acpi_size) external_object->package.count *
+	info.length += (acpi_size)external_object->package.count *
 	    ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object));
 	info.free_space += external_object->package.count *
 	    ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object));
@@ -738,7 +738,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 		 */
 		if (source_desc->string.pointer) {
 			dest_desc->string.pointer =
-			    ACPI_ALLOCATE((acpi_size) source_desc->string.
+			    ACPI_ALLOCATE((acpi_size)source_desc->string.
 					  length + 1);
 			if (!dest_desc->string.pointer) {
 				return (AE_NO_MEMORY);
@@ -748,7 +748,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 
 			memcpy(dest_desc->string.pointer,
 			       source_desc->string.pointer,
-			       (acpi_size) source_desc->string.length + 1);
+			       (acpi_size)source_desc->string.length + 1);
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 6fb4ec3..f7cd2d5 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -95,7 +95,7 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 
 	hid =
 	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
-				 (acpi_size) length);
+				 (acpi_size)length);
 	if (!hid) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
@@ -173,7 +173,7 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 
 	uid =
 	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
-				 (acpi_size) length);
+				 (acpi_size)length);
 	if (!uid) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
@@ -309,7 +309,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	/* Area for CID strings starts after the CID PNP_DEVICE_ID array */
 
 	next_id_string = ACPI_CAST_PTR(char, cid_list->ids) +
-	    ((acpi_size) count * sizeof(struct acpi_pnp_device_id));
+	    ((acpi_size)count * sizeof(struct acpi_pnp_device_id));
 
 	/* Copy/convert the CIDs to the return buffer */
 
@@ -413,7 +413,7 @@ acpi_ut_execute_CLS(struct acpi_namespace_node *device_node,
 
 	cls =
 	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
-				 (acpi_size) length);
+				 (acpi_size)length);
 	if (!cls) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 9cc64b6..3cd0978 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -124,7 +124,7 @@ acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock)
 	return (status);
 }
 
-acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock * lock)
+acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
 {
 	acpi_status status;
 
@@ -160,7 +160,7 @@ acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock * lock)
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock * lock)
+acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock *lock)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 2fbc682..2d6530e 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -236,8 +236,8 @@ acpi_ut_divide(u64 in_dividend,
 			}
 
 			remainder.full = remainder.full - dividend.full;
-			remainder.part.hi = (u32)-((s32) remainder.part.hi);
-			remainder.part.lo = (u32)-((s32) remainder.part.lo);
+			remainder.part.hi = (u32)-((s32)remainder.part.hi);
+			remainder.part.lo = (u32)-((s32)remainder.part.lo);
 
 			if (remainder.part.lo) {
 				remainder.part.hi--;
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index edad3f0..72b9a06 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -51,11 +51,11 @@ ACPI_MODULE_NAME("utobject")
 /* Local prototypes */
 static acpi_status
 acpi_ut_get_simple_object_size(union acpi_operand_object *obj,
-			       acpi_size * obj_length);
+			       acpi_size *obj_length);
 
 static acpi_status
 acpi_ut_get_package_object_size(union acpi_operand_object *obj,
-				acpi_size * obj_length);
+				acpi_size *obj_length);
 
 static acpi_status
 acpi_ut_get_element_length(u8 object_type,
@@ -177,7 +177,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	 * Create the element array. Count+1 allows the array to be null
 	 * terminated.
 	 */
-	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size) count +
+	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size)count +
 						 1) * sizeof(void *));
 	if (!package_elements) {
 		ACPI_FREE(package_desc);
@@ -454,7 +454,7 @@ void acpi_ut_delete_object_desc(union acpi_operand_object *object)
 
 static acpi_status
 acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
-			       acpi_size * obj_length)
+			       acpi_size *obj_length)
 {
 	acpi_size length;
 	acpi_size size;
@@ -495,12 +495,12 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 	switch (internal_object->common.type) {
 	case ACPI_TYPE_STRING:
 
-		length += (acpi_size) internal_object->string.length + 1;
+		length += (acpi_size)internal_object->string.length + 1;
 		break;
 
 	case ACPI_TYPE_BUFFER:
 
-		length += (acpi_size) internal_object->buffer.length;
+		length += (acpi_size)internal_object->buffer.length;
 		break;
 
 	case ACPI_TYPE_INTEGER:
@@ -640,7 +640,7 @@ acpi_ut_get_element_length(u8 object_type,
 
 static acpi_status
 acpi_ut_get_package_object_size(union acpi_operand_object *internal_object,
-				acpi_size * obj_length)
+				acpi_size *obj_length)
 {
 	acpi_status status;
 	struct acpi_pkg_info info;
@@ -665,7 +665,7 @@ acpi_ut_get_package_object_size(union acpi_operand_object *internal_object,
 	 */
 	info.length +=
 	    ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object)) *
-	    (acpi_size) info.num_packages;
+	    (acpi_size)info.num_packages;
 
 	/* Return the total package length */
 
@@ -689,7 +689,7 @@ acpi_ut_get_package_object_size(union acpi_operand_object *internal_object,
 
 acpi_status
 acpi_ut_get_object_size(union acpi_operand_object *internal_object,
-			acpi_size * obj_length)
+			acpi_size *obj_length)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index b5cfe57..3f5fed6 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -150,7 +150,7 @@ acpi_status acpi_ut_initialize_interfaces(void)
 	     i < (ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces) - 1);
 	     i++) {
 		acpi_default_supported_interfaces[i].next =
-		    &acpi_default_supported_interfaces[(acpi_size) i + 1];
+		    &acpi_default_supported_interfaces[(acpi_size)i + 1];
 	}
 
 	acpi_os_release_mutex(acpi_gbl_osi_mutex);
@@ -397,7 +397,7 @@ struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name)
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_osi_implementation(struct acpi_walk_state * walk_state)
+acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *string_desc;
 	union acpi_operand_object *return_desc;
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 813520a..3cd573c 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("utownerid")
  *              when the method exits or the table is unloaded.
  *
  ******************************************************************************/
-acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
+acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 {
 	u32 i;
 	u32 j;
@@ -122,7 +122,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 				 * permanently allocated (prevents +1 overflow)
 				 */
 				*owner_id =
-				    (acpi_owner_id) ((k + 1) + ACPI_MUL_32(j));
+				    (acpi_owner_id)((k + 1) + ACPI_MUL_32(j));
 
 				ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
 						  "Allocated OwnerId: %2.2X\n",
@@ -167,7 +167,7 @@ exit:
  *
  ******************************************************************************/
 
-void acpi_ut_release_owner_id(acpi_owner_id * owner_id_ptr)
+void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 {
 	acpi_owner_id owner_id = *owner_id_ptr;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 208d71a..dd084cf 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -264,9 +264,9 @@ static char *acpi_ut_format_number(char *string,
 
 	sign = '\0';
 	if (type & ACPI_FORMAT_SIGN) {
-		if ((s64) number < 0) {
+		if ((s64)number < 0) {
 			sign = '-';
-			number = -(s64) number;
+			number = -(s64)number;
 			width--;
 		} else if (type & ACPI_FORMAT_SIGN_PLUS) {
 			sign = '+';
@@ -404,7 +404,7 @@ acpi_ut_vsnprintf(char *string,
 		width = -1;
 		if (isdigit((int)*format)) {
 			format = acpi_ut_scan_number(format, &number);
-			width = (s32) number;
+			width = (s32)number;
 		} else if (*format == '*') {
 			++format;
 			width = va_arg(args, int);
@@ -421,7 +421,7 @@ acpi_ut_vsnprintf(char *string,
 			++format;
 			if (isdigit((int)*format)) {
 				format = acpi_ut_scan_number(format, &number);
-				precision = (s32) number;
+				precision = (s32)number;
 			} else if (*format == '*') {
 				++format;
 				precision = va_arg(args, int);
@@ -550,17 +550,17 @@ acpi_ut_vsnprintf(char *string,
 		if (qualifier == 'L') {
 			number = va_arg(args, u64);
 			if (type & ACPI_FORMAT_SIGN) {
-				number = (s64) number;
+				number = (s64)number;
 			}
 		} else if (qualifier == 'l') {
 			number = va_arg(args, unsigned long);
 			if (type & ACPI_FORMAT_SIGN) {
-				number = (s32) number;
+				number = (s32)number;
 			}
 		} else if (qualifier == 'h') {
 			number = (u16)va_arg(args, int);
 			if (type & ACPI_FORMAT_SIGN) {
-				number = (s16) number;
+				number = (s16)number;
 			}
 		} else {
 			number = va_arg(args, unsigned int);
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 0b00572..241259b 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -130,7 +130,7 @@ void acpi_ut_print_string(char *string, u16 max_length)
 			} else {
 				/* All others will be Hex escapes */
 
-				acpi_os_printf("\\x%2.2X", (s32) string[i]);
+				acpi_os_printf("\\x%2.2X", (s32)string[i]);
 			}
 			break;
 		}
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 68d4673..d9e6aac 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -127,7 +127,7 @@ ACPI_EXPORT_SYMBOL(acpi_subsystem_status)
  *              and the value of out_buffer is undefined.
  *
  ******************************************************************************/
-acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
+acpi_status acpi_get_system_info(struct acpi_buffer *out_buffer)
 {
 	struct acpi_system_info *info_ptr;
 	acpi_status status;
@@ -483,7 +483,7 @@ ACPI_EXPORT_SYMBOL(acpi_check_address_range)
  ******************************************************************************/
 acpi_status
 acpi_decode_pld_buffer(u8 *in_buffer,
-		       acpi_size length, struct acpi_pld_info ** return_buffer)
+		       acpi_size length, struct acpi_pld_info **return_buffer)
 {
 	struct acpi_pld_info *pld_info;
 	u32 *buffer = ACPI_CAST_PTR(u32, in_buffer);
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index dfdcf5a..562603d 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -96,7 +96,7 @@ acpi_physical_address acpi_os_get_root_pointer(void);
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
-			    acpi_string * new_val);
+			    acpi_string *new_val);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
@@ -108,7 +108,7 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_physical_table_override
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
-				acpi_physical_address * new_address,
+				acpi_physical_address *new_address,
 				u32 *new_table_length);
 #endif
 
@@ -203,7 +203,7 @@ void acpi_os_unmap_memory(void *logical_address, acpi_size size);
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_physical_address
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
-			     acpi_physical_address * physical_address);
+			     acpi_physical_address *physical_address);
 #endif
 
 /*
@@ -379,14 +379,14 @@ acpi_status
 acpi_os_get_table_by_name(char *signature,
 			  u32 instance,
 			  struct acpi_table_header **table,
-			  acpi_physical_address * address);
+			  acpi_physical_address *address);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_index
 acpi_status
 acpi_os_get_table_by_index(u32 index,
 			   struct acpi_table_header **table,
-			   u32 *instance, acpi_physical_address * address);
+			   u32 *instance, acpi_physical_address *address);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_address
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index cef1223..366b364 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -484,8 +484,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_load_tables(void))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_reallocate_root_table(void))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
-			    acpi_find_root_pointer(acpi_physical_address *
-						   rsdp_address))
+			    acpi_find_root_pointer(acpi_physical_address
+						   *rsdp_address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_table_header(acpi_string signature,
 						   u32 instance,
@@ -530,7 +530,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_handle(acpi_handle parent,
 					     acpi_string pathname,
-					     acpi_handle * ret_handle))
+					     acpi_handle *ret_handle))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_attach_data(acpi_handle object,
 					      acpi_object_handler handler,
@@ -575,15 +575,15 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_next_object(acpi_object_type type,
 						 acpi_handle parent,
 						 acpi_handle child,
-						 acpi_handle * out_handle))
+						 acpi_handle *out_handle))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_type(acpi_handle object,
-					  acpi_object_type * out_type))
+					  acpi_object_type *out_type))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_parent(acpi_handle object,
-					    acpi_handle * out_handle))
+					    acpi_handle *out_handle))
 
 /*
  * Handler interfaces
@@ -755,7 +755,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_gpe_device(u32 gpe_index,
-						    acpi_handle * gpe_device))
+						    acpi_handle *gpe_device))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_install_gpe_block(acpi_handle gpe_device,
@@ -771,8 +771,8 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
  * Resource interfaces
  */
 typedef
-acpi_status(*acpi_walk_resource_callback) (struct acpi_resource * resource,
-					   void *context);
+acpi_status (*acpi_walk_resource_callback) (struct acpi_resource * resource,
+					    void *context);
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_vendor_resource(acpi_handle device,
@@ -938,7 +938,8 @@ ACPI_DBG_DEPENDENT_RETURN_VOID(void
 ACPI_APP_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(1)
 				void ACPI_INTERNAL_VAR_XFACE
 				acpi_log_error(const char *format, ...))
- acpi_status acpi_initialize_debugger(void);
+
+acpi_status acpi_initialize_debugger(void);
 
 void acpi_terminate_debugger(void);
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b9a8b72..cb389ef 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -893,7 +893,7 @@ typedef u8 acpi_adr_space_type;
 
 /* Sleep function dispatch */
 
-typedef acpi_status(*acpi_sleep_function) (u8 sleep_state);
+typedef acpi_status (*acpi_sleep_function) (u8 sleep_state);
 
 struct acpi_sleep_functions {
 	acpi_sleep_function legacy_function;
@@ -1072,20 +1072,21 @@ void (*acpi_notify_handler) (acpi_handle device, u32 value, void *context);
 typedef
 void (*acpi_object_handler) (acpi_handle object, void *data);
 
-typedef acpi_status(*acpi_init_handler) (acpi_handle object, u32 function);
+typedef
+acpi_status (*acpi_init_handler) (acpi_handle object, u32 function);
 
 #define ACPI_INIT_DEVICE_INI        1
 
 typedef
-acpi_status(*acpi_exception_handler) (acpi_status aml_status,
-				      acpi_name name,
-				      u16 opcode,
-				      u32 aml_offset, void *context);
+acpi_status (*acpi_exception_handler) (acpi_status aml_status,
+				       acpi_name name,
+				       u16 opcode,
+				       u32 aml_offset, void *context);
 
 /* Table Event handler (Load, load_table, etc.) and types */
 
 typedef
-acpi_status(*acpi_table_handler) (u32 event, void *table, void *context);
+acpi_status (*acpi_table_handler) (u32 event, void *table, void *context);
 
 #define ACPI_TABLE_LOAD             0x0
 #define ACPI_TABLE_UNLOAD           0x1
@@ -1094,12 +1095,12 @@ acpi_status(*acpi_table_handler) (u32 event, void *table, void *context);
 /* Address Spaces (For Operation Regions) */
 
 typedef
-acpi_status(*acpi_adr_space_handler) (u32 function,
-				      acpi_physical_address address,
-				      u32 bit_width,
-				      u64 *value,
-				      void *handler_context,
-				      void *region_context);
+acpi_status (*acpi_adr_space_handler) (u32 function,
+				       acpi_physical_address address,
+				       u32 bit_width,
+				       u64 *value,
+				       void *handler_context,
+				       void *region_context);
 
 #define ACPI_DEFAULT_HANDLER            NULL
 
@@ -1112,18 +1113,18 @@ struct acpi_connection_info {
 };
 
 typedef
-acpi_status(*acpi_adr_space_setup) (acpi_handle region_handle,
-				    u32 function,
-				    void *handler_context,
-				    void **region_context);
+acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
+				     u32 function,
+				     void *handler_context,
+				     void **region_context);
 
 #define ACPI_REGION_ACTIVATE    0
 #define ACPI_REGION_DEACTIVATE  1
 
 typedef
-acpi_status(*acpi_walk_callback) (acpi_handle object,
-				  u32 nesting_level,
-				  void *context, void **return_value);
+acpi_status (*acpi_walk_callback) (acpi_handle object,
+				   u32 nesting_level,
+				   void *context, void **return_value);
 
 typedef
 u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index d0e6b85..546cf4a 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -91,7 +91,7 @@ osl_get_customized_table(char *pathname,
 			 char *signature,
 			 u32 instance,
 			 struct acpi_table_header **table,
-			 acpi_physical_address * address);
+			 acpi_physical_address *address);
 
 static acpi_status osl_list_bios_tables(void);
 
@@ -99,7 +99,7 @@ static acpi_status
 osl_get_bios_table(char *signature,
 		   u32 instance,
 		   struct acpi_table_header **table,
-		   acpi_physical_address * address);
+		   acpi_physical_address *address);
 
 static acpi_status osl_get_last_status(acpi_status default_status);
 
@@ -187,7 +187,7 @@ static acpi_status osl_get_last_status(acpi_status default_status)
 
 acpi_status
 acpi_os_get_table_by_address(acpi_physical_address address,
-			     struct acpi_table_header ** table)
+			     struct acpi_table_header **table)
 {
 	u32 table_length;
 	struct acpi_table_header *mapped_table;
@@ -252,8 +252,8 @@ exit:
 acpi_status
 acpi_os_get_table_by_name(char *signature,
 			  u32 instance,
-			  struct acpi_table_header ** table,
-			  acpi_physical_address * address)
+			  struct acpi_table_header **table,
+			  acpi_physical_address *address)
 {
 	acpi_status status;
 
@@ -380,8 +380,8 @@ static acpi_status osl_add_table_to_list(char *signature, u32 instance)
 
 acpi_status
 acpi_os_get_table_by_index(u32 index,
-			   struct acpi_table_header ** table,
-			   u32 *instance, acpi_physical_address * address)
+			   struct acpi_table_header **table,
+			   u32 *instance, acpi_physical_address *address)
 {
 	struct osl_table_info *info;
 	acpi_status status;
@@ -447,7 +447,7 @@ osl_find_rsdp_via_efi_by_keyword(FILE * file, const char *keyword)
 		}
 	}
 
-	return ((acpi_physical_address) (address));
+	return ((acpi_physical_address)(address));
 }
 
 /******************************************************************************
@@ -751,10 +751,10 @@ static acpi_status osl_list_bios_tables(void)
 	for (i = 0; i < number_of_tables; ++i, table_data += item_size) {
 		if (osl_can_use_xsdt()) {
 			table_address =
-			    (acpi_physical_address) (*ACPI_CAST64(table_data));
+			    (acpi_physical_address)(*ACPI_CAST64(table_data));
 		} else {
 			table_address =
-			    (acpi_physical_address) (*ACPI_CAST32(table_data));
+			    (acpi_physical_address)(*ACPI_CAST32(table_data));
 		}
 
 		/* Skip NULL entries in RSDT/XSDT */
@@ -800,7 +800,7 @@ static acpi_status
 osl_get_bios_table(char *signature,
 		   u32 instance,
 		   struct acpi_table_header **table,
-		   acpi_physical_address * address)
+		   acpi_physical_address *address)
 {
 	struct acpi_table_header *local_table = NULL;
 	struct acpi_table_header *mapped_table = NULL;
@@ -833,38 +833,37 @@ osl_get_bios_table(char *signature,
 			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XDSDT) &&
 			    gbl_fadt->Xdsdt) {
 				table_address =
-				    (acpi_physical_address) gbl_fadt->Xdsdt;
+				    (acpi_physical_address)gbl_fadt->Xdsdt;
 			} else
 			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_DSDT)
 				&& gbl_fadt->dsdt) {
 				table_address =
-				    (acpi_physical_address) gbl_fadt->dsdt;
+				    (acpi_physical_address)gbl_fadt->dsdt;
 			}
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
 			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XFACS) &&
 			    gbl_fadt->Xfacs) {
 				table_address =
-				    (acpi_physical_address) gbl_fadt->Xfacs;
+				    (acpi_physical_address)gbl_fadt->Xfacs;
 			} else
 			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_FACS)
 				&& gbl_fadt->facs) {
 				table_address =
-				    (acpi_physical_address) gbl_fadt->facs;
+				    (acpi_physical_address)gbl_fadt->facs;
 			}
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT)) {
 			if (!gbl_revision) {
 				return (AE_BAD_SIGNATURE);
 			}
 			table_address =
-			    (acpi_physical_address) gbl_rsdp.
+			    (acpi_physical_address)gbl_rsdp.
 			    xsdt_physical_address;
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT)) {
 			table_address =
-			    (acpi_physical_address) gbl_rsdp.
+			    (acpi_physical_address)gbl_rsdp.
 			    rsdt_physical_address;
 		} else {
-			table_address =
-			    (acpi_physical_address) gbl_rsdp_address;
+			table_address = (acpi_physical_address)gbl_rsdp_address;
 			signature = ACPI_SIG_RSDP;
 		}
 
@@ -904,12 +903,12 @@ osl_get_bios_table(char *signature,
 		for (i = 0; i < number_of_tables; ++i, table_data += item_size) {
 			if (osl_can_use_xsdt()) {
 				table_address =
-				    (acpi_physical_address) (*ACPI_CAST64
-							     (table_data));
+				    (acpi_physical_address)(*ACPI_CAST64
+							    (table_data));
 			} else {
 				table_address =
-				    (acpi_physical_address) (*ACPI_CAST32
-							     (table_data));
+				    (acpi_physical_address)(*ACPI_CAST32
+							    (table_data));
 			}
 
 			/* Skip NULL entries in RSDT/XSDT */
@@ -1301,7 +1300,7 @@ osl_get_customized_table(char *pathname,
 			 char *signature,
 			 u32 instance,
 			 struct acpi_table_header **table,
-			 acpi_physical_address * address)
+			 acpi_physical_address *address)
 {
 	void *table_dir;
 	u32 current_instance = 0;
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 08cb8b2..88aa66e 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -246,8 +246,8 @@ acpi_physical_address acpi_os_get_root_pointer(void)
  *****************************************************************************/
 
 acpi_status
-acpi_os_predefined_override(const struct acpi_predefined_names * init_val,
-			    acpi_string * new_val)
+acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
+			    acpi_string *new_val)
 {
 
 	if (!init_val || !new_val) {
@@ -274,8 +274,8 @@ acpi_os_predefined_override(const struct acpi_predefined_names * init_val,
  *****************************************************************************/
 
 acpi_status
-acpi_os_table_override(struct acpi_table_header * existing_table,
-		       struct acpi_table_header ** new_table)
+acpi_os_table_override(struct acpi_table_header *existing_table,
+		       struct acpi_table_header **new_table)
 {
 
 	if (!existing_table || !new_table) {
@@ -311,8 +311,8 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
  *****************************************************************************/
 
 acpi_status
-acpi_os_physical_table_override(struct acpi_table_header * existing_table,
-				acpi_physical_address * new_address,
+acpi_os_physical_table_override(struct acpi_table_header *existing_table,
+				acpi_physical_address *new_address,
 				u32 *new_table_length)
 {
 
@@ -506,7 +506,7 @@ acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
 {
 
-	return (ACPI_TO_POINTER((acpi_size) where));
+	return (ACPI_TO_POINTER((acpi_size)where));
 }
 
 /******************************************************************************
@@ -603,9 +603,9 @@ void acpi_os_free(void *mem)
 
 acpi_status
 acpi_os_create_semaphore(u32 max_units,
-			 u32 initial_units, acpi_handle * out_handle)
+			 u32 initial_units, acpi_handle *out_handle)
 {
-	*out_handle = (acpi_handle) 1;
+	*out_handle = (acpi_handle)1;
 	return (AE_OK);
 }
 
@@ -640,7 +640,7 @@ acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 
 acpi_status
 acpi_os_create_semaphore(u32 max_units,
-			 u32 initial_units, acpi_handle * out_handle)
+			 u32 initial_units, acpi_handle *out_handle)
 {
 	sem_t *sem;
 
@@ -672,7 +672,7 @@ acpi_os_create_semaphore(u32 max_units,
 	}
 #endif
 
-	*out_handle = (acpi_handle) sem;
+	*out_handle = (acpi_handle)sem;
 	return (AE_OK);
 }
 
@@ -1035,7 +1035,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id,
  *****************************************************************************/
 
 acpi_status
-acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id,
+acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
 				u32 pci_register, u64 value, u32 width)
 {
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 9c2db0e..a39e445 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -294,7 +294,7 @@ int ap_dump_table_by_address(char *ascii_address)
 		return (-1);
 	}
 
-	address = (acpi_physical_address) long_address;
+	address = (acpi_physical_address)long_address;
 	status = acpi_os_get_table_by_address(address, &table);
 	if (ACPI_FAILURE(status)) {
 		acpi_log_error("Could not get table at 0x%8.8X%8.8X, %s\n",
-- 
1.7.10
