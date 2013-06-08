From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/16] ACPICA: Standardize all switch() blocks
Date: Sat,  8 Jun 2013 08:58:14 +0800
Message-ID: <91d82cf071b27d24ec8a43da281fc7e1c3d542a9.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61910 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab3FHA7A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:59:00 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Chao Guan <chao.guan@intel.com>

From: Chao Guan <chao.guan@intel.com>

After many years, different formatting for switch() has crept in.
This change makes every switch block identical. Chao Guan.
ACPICA bugzilla 997.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=997
Signed-off-by: Chao Guan <chao.guan@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dscontrol.c |    4 ++--
 drivers/acpi/acpica/dsfield.c   |    4 ++++
 drivers/acpi/acpica/dsinit.c    |    1 +
 drivers/acpi/acpica/dsmthdat.c  |    2 +-
 drivers/acpi/acpica/dsobject.c  |    3 +--
 drivers/acpi/acpica/dsopcode.c  |    1 +
 drivers/acpi/acpica/dsutils.c   |    5 ++---
 drivers/acpi/acpica/dswexec.c   |    3 +--
 drivers/acpi/acpica/dswload.c   |    7 ++++---
 drivers/acpi/acpica/dswload2.c  |    4 ++++
 drivers/acpi/acpica/evgpe.c     |    6 ++----
 drivers/acpi/acpica/evgpeinit.c |    3 +++
 drivers/acpi/acpica/evhandler.c |    7 +++++++
 drivers/acpi/acpica/evmisc.c    |    1 +
 drivers/acpi/acpica/evrgnini.c  |    2 ++
 drivers/acpi/acpica/evxfgpe.c   |    3 +++
 drivers/acpi/acpica/evxfregn.c  |    1 +
 drivers/acpi/acpica/exconfig.c  |    1 +
 drivers/acpi/acpica/exconvrt.c  |   13 ++++++++++---
 drivers/acpi/acpica/excreate.c  |    3 ---
 drivers/acpi/acpica/exdebug.c   |    2 ++
 drivers/acpi/acpica/exdump.c    |    2 ++
 drivers/acpi/acpica/exfield.c   |    4 ++++
 drivers/acpi/acpica/exfldio.c   |    2 --
 drivers/acpi/acpica/exmisc.c    |   12 +++++++++++-
 drivers/acpi/acpica/exoparg1.c  |   16 ++++++++--------
 drivers/acpi/acpica/exoparg2.c  |    1 -
 drivers/acpi/acpica/exoparg3.c  |    1 -
 drivers/acpi/acpica/exoparg6.c  |    5 -----
 drivers/acpi/acpica/exprep.c    |    7 +++++++
 drivers/acpi/acpica/exregion.c  |   27 +++++++++++++++++++++++----
 drivers/acpi/acpica/exresnte.c  |    1 +
 drivers/acpi/acpica/exresolv.c  |    6 +++++-
 drivers/acpi/acpica/exresop.c   |    9 +++++----
 drivers/acpi/acpica/exstore.c   |    4 +---
 drivers/acpi/acpica/exstoren.c  |    4 ----
 drivers/acpi/acpica/hwacpi.c    |    2 +-
 drivers/acpi/acpica/hwgpe.c     |    3 +++
 drivers/acpi/acpica/hwregs.c    |    4 ++--
 drivers/acpi/acpica/hwxface.c   |    3 +++
 drivers/acpi/acpica/hwxfsleep.c |    4 ++++
 drivers/acpi/acpica/nsaccess.c  |    1 +
 drivers/acpi/acpica/nsconvert.c |    3 +++
 drivers/acpi/acpica/nsdump.c    |   10 ++++++++++
 drivers/acpi/acpica/nsinit.c    |    9 +++++++++
 drivers/acpi/acpica/nspredef.c  |    6 ++++++
 drivers/acpi/acpica/nsprepkg.c  |    5 -----
 drivers/acpi/acpica/nsrepair.c  |    1 +
 drivers/acpi/acpica/nsrepair2.c |    1 +
 drivers/acpi/acpica/nsutils.c   |    3 +++
 drivers/acpi/acpica/nsxfeval.c  |    1 +
 drivers/acpi/acpica/psargs.c    |    4 ++++
 drivers/acpi/acpica/psloop.c    |    2 +-
 drivers/acpi/acpica/psobject.c  |    1 +
 drivers/acpi/acpica/psparse.c   |    3 +--
 drivers/acpi/acpica/pstree.c    |    2 ++
 drivers/acpi/acpica/rscalc.c    |    2 ++
 drivers/acpi/acpica/rsdump.c    |   10 ++++++++++
 drivers/acpi/acpica/rsmisc.c    |    3 ++-
 drivers/acpi/acpica/rsutils.c   |    5 +++++
 drivers/acpi/acpica/rsxface.c   |    1 +
 drivers/acpi/acpica/tbinstal.c  |    4 ++++
 drivers/acpi/acpica/utcopy.c    |   11 +++++++----
 drivers/acpi/acpica/utdelete.c  |    3 ++-
 drivers/acpi/acpica/uteval.c    |    5 +++++
 drivers/acpi/acpica/utexcep.c   |    1 +
 drivers/acpi/acpica/utids.c     |    3 +++
 drivers/acpi/acpica/utmisc.c    |    2 ++
 drivers/acpi/acpica/utobject.c  |    5 ++---
 drivers/acpi/acpica/utstring.c  |   11 +++++++++++
 drivers/acpi/acpica/uttrack.c   |    8 ++++++++
 71 files changed, 242 insertions(+), 77 deletions(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 7ea0f16..eb56b66 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -78,7 +78,6 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 
 	switch (op->common.aml_opcode) {
 	case AML_WHILE_OP:
-
 		/*
 		 * If this is an additional iteration of a while loop, continue.
 		 * There is no need to allocate a new control state.
@@ -99,7 +98,6 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 		/*lint -fallthrough */
 
 	case AML_IF_OP:
-
 		/*
 		 * IF/WHILE: Create a new control state to manage these
 		 * constructs. We need to manage these as a stack, in order
@@ -142,6 +140,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 		break;
 
 	default:
+
 		break;
 	}
 
@@ -344,6 +343,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 	case AML_NOOP_OP:
 
 		/* Just do nothing! */
+
 		break;
 
 	case AML_BREAK_POINT_OP:
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index feadeed..d4bfe7b 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -563,21 +563,25 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 	 */
 	switch (walk_state->opcode) {
 	case AML_FIELD_OP:
+
 		arg = acpi_ps_get_arg(op, 2);
 		type = ACPI_TYPE_LOCAL_REGION_FIELD;
 		break;
 
 	case AML_BANK_FIELD_OP:
+
 		arg = acpi_ps_get_arg(op, 4);
 		type = ACPI_TYPE_LOCAL_BANK_FIELD;
 		break;
 
 	case AML_INDEX_FIELD_OP:
+
 		arg = acpi_ps_get_arg(op, 3);
 		type = ACPI_TYPE_LOCAL_INDEX_FIELD;
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index bc8e63f..1442420 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -127,6 +127,7 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 3da8046..c4b0b36 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -285,6 +285,7 @@ acpi_ds_method_data_get_node(u8 type,
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Type %u is invalid", type));
 		return_ACPI_STATUS(AE_TYPE);
 	}
@@ -428,7 +429,6 @@ acpi_ds_method_data_get_value(u8 type,
 				return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
 
 			case ACPI_REFCLASS_LOCAL:
-
 				/*
 				 * No error message for this case, will be trapped again later to
 				 * detect and ignore cases of Store(local_x,local_x)
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index e20e9f8..63f0d22 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -648,7 +648,6 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 	switch (obj_desc->common.type) {
 	case ACPI_TYPE_BUFFER:
-
 		/*
 		 * Defer evaluation of Buffer term_arg operand
 		 */
@@ -660,7 +659,6 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		break;
 
 	case ACPI_TYPE_PACKAGE:
-
 		/*
 		 * Defer evaluation of Package term_arg operand
 		 */
@@ -741,6 +739,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 			break;
 
 		default:
+
 			ACPI_ERROR((AE_INFO, "Unknown Integer type 0x%X",
 				    op_info->type));
 			status = AE_AML_OPERAND_TYPE;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index ee6367b..1fc1ff1 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -636,6 +636,7 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 	}
 
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 9977899..c666fc0 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -240,7 +240,6 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 
 		case AML_IF_OP:
 		case AML_WHILE_OP:
-
 			/*
 			 * If we are executing the predicate AND this is the predicate op,
 			 * we will use the return value
@@ -254,7 +253,9 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			break;
 
 		default:
+
 			/* Ignore other control opcodes */
+
 			break;
 		}
 
@@ -263,7 +264,6 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 		goto result_not_used;
 
 	case AML_CLASS_CREATE:
-
 		/*
 		 * These opcodes allow term_arg(s) as operands and therefore
 		 * the operands can be method calls. The result is used.
@@ -292,7 +292,6 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 		goto result_not_used;
 
 	default:
-
 		/*
 		 * In all other cases. the parent will actually use the return
 		 * object, so keep it.
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index e2199a9..151d924 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -327,6 +327,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 		break;
 
 	default:
+
 		break;
 	}
 
@@ -488,7 +489,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 			break;
 
 		case AML_TYPE_METHOD_CALL:
-
 			/*
 			 * If the method is referenced from within a package
 			 * declaration, it is not a invocation of the method, just
@@ -582,7 +582,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 			switch (op->common.parent->common.aml_opcode) {
 			case AML_NAME_OP:
-
 				/*
 				 * Put the Node on the object stack (Contains the ACPI Name
 				 * of this object)
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 6e17c0e..95e681a 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -74,6 +74,7 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 
 	switch (pass_number) {
 	case 1:
+
 		walk_state->parse_flags = ACPI_PARSE_LOAD_PASS1 |
 		    ACPI_PARSE_DELETE_TREE;
 		walk_state->descending_callback = acpi_ds_load1_begin_op;
@@ -81,6 +82,7 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 		break;
 
 	case 2:
+
 		walk_state->parse_flags = ACPI_PARSE_LOAD_PASS1 |
 		    ACPI_PARSE_DELETE_TREE;
 		walk_state->descending_callback = acpi_ds_load2_begin_op;
@@ -88,6 +90,7 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 		break;
 
 	case 3:
+
 #ifndef ACPI_NO_METHOD_EXECUTION
 		walk_state->parse_flags |= ACPI_PARSE_EXECUTE |
 		    ACPI_PARSE_DELETE_TREE;
@@ -97,6 +100,7 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 		break;
 
 	default:
+
 		return (AE_BAD_PARAMETER);
 	}
 
@@ -161,7 +165,6 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 
 	switch (walk_state->opcode) {
 	case AML_SCOPE_OP:
-
 		/*
 		 * The target name of the Scope() operator must exist at this point so
 		 * that we can actually open the scope to enter new names underneath it.
@@ -210,7 +213,6 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 		case ACPI_TYPE_INTEGER:
 		case ACPI_TYPE_STRING:
 		case ACPI_TYPE_BUFFER:
-
 			/*
 			 * These types we will allow, but we will change the type.
 			 * This enables some existing code of the form:
@@ -232,7 +234,6 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 			break;
 
 		case ACPI_TYPE_METHOD:
-
 			/*
 			 * Allow scope change to root during execution of module-level
 			 * code. Root is typed METHOD during this time.
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 4407ff2..b1f8f47 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -509,6 +509,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 			break;
 
 		default:
+
 			/* All NAMED_FIELD opcodes must be handled above */
 			break;
 		}
@@ -548,6 +549,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 			break;
 
 		default:
+
 			/* Unknown opcode */
 
 			status = AE_OK;
@@ -674,6 +676,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 #endif				/* ACPI_NO_METHOD_EXECUTION */
 
 		default:
+
 			/* All NAMED_COMPLEX opcodes must be handled above */
 			break;
 		}
@@ -721,6 +724,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index ae50d6c..c8a1f7d 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -529,7 +529,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	switch (local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
 	case ACPI_GPE_DISPATCH_NOTIFY:
-
 		/*
 		 * Implicit notify.
 		 * Dispatch a DEVICE_WAKE notify to the appropriate handler.
@@ -582,7 +581,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		break;
 
 	default:
-		return_VOID;    /* Should never happen */
+
+		return_VOID;	/* Should never happen */
 	}
 
 	/* Defer enabling of GPE until all notify handlers are done */
@@ -754,7 +754,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 
 	case ACPI_GPE_DISPATCH_METHOD:
 	case ACPI_GPE_DISPATCH_NOTIFY:
-
 		/*
 		 * Execute the method associated with the GPE
 		 * NOTE: Level-triggered GPEs are cleared after the method completes.
@@ -770,7 +769,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		break;
 
 	default:
-
 		/*
 		 * No handler or method to run!
 		 * 03/2010: This case should no longer be possible. We will not allow
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 72b8f6b..9037f17 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -363,14 +363,17 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	 */
 	switch (name[1]) {
 	case 'L':
+
 		type = ACPI_GPE_LEVEL_TRIGGERED;
 		break;
 
 	case 'E':
+
 		type = ACPI_GPE_EDGE_TRIGGERED;
 		break;
 
 	default:
+
 		/* Unknown method type, just ignore it */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index d4f8311..068af96 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -354,36 +354,43 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 
 		switch (space_id) {
 		case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+
 			handler = acpi_ex_system_memory_space_handler;
 			setup = acpi_ev_system_memory_region_setup;
 			break;
 
 		case ACPI_ADR_SPACE_SYSTEM_IO:
+
 			handler = acpi_ex_system_io_space_handler;
 			setup = acpi_ev_io_space_region_setup;
 			break;
 
 		case ACPI_ADR_SPACE_PCI_CONFIG:
+
 			handler = acpi_ex_pci_config_space_handler;
 			setup = acpi_ev_pci_config_region_setup;
 			break;
 
 		case ACPI_ADR_SPACE_CMOS:
+
 			handler = acpi_ex_cmos_space_handler;
 			setup = acpi_ev_cmos_region_setup;
 			break;
 
 		case ACPI_ADR_SPACE_PCI_BAR_TARGET:
+
 			handler = acpi_ex_pci_bar_space_handler;
 			setup = acpi_ev_pci_bar_region_setup;
 			break;
 
 		case ACPI_ADR_SPACE_DATA_TABLE:
+
 			handler = acpi_ex_data_table_space_handler;
 			setup = NULL;
 			break;
 
 		default:
+
 			status = AE_BAD_PARAMETER;
 			goto unlock_and_exit;
 		}
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index c986b23..db59fe3 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -78,6 +78,7 @@ u8 acpi_ev_is_notify_object(struct acpi_namespace_node *node)
 		return (TRUE);
 
 	default:
+
 		return (FALSE);
 	}
 }
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 3bb6167..8354c4f 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -596,7 +596,9 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 				break;
 
 			default:
+
 				/* Ignore other objects */
+
 				break;
 			}
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index aff4cc2..7662f1a 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -366,16 +366,19 @@ acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action)
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
+
 		ACPI_SET_BIT(gpe_register_info->enable_for_wake,
 			     (u8)register_bit);
 		break;
 
 	case ACPI_GPE_DISABLE:
+
 		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake,
 			       (u8)register_bit);
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "%u, Invalid action", action));
 		status = AE_BAD_PARAMETER;
 		break;
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 96c9e5f..80cecf8 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -139,6 +139,7 @@ acpi_install_address_space_handler(acpi_handle device,
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index a689aac..06d216c 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -480,6 +480,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index d2b9613..69e4a8c 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -99,6 +99,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_TYPE);
 	}
 
@@ -117,7 +118,6 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	switch (obj_desc->common.type) {
 	case ACPI_TYPE_STRING:
-
 		/*
 		 * Convert string to an integer - for most cases, the string must be
 		 * hexadecimal as per the ACPI specification. The only exception (as
@@ -161,6 +161,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 	default:
 
 		/* No other types can get here */
+
 		break;
 	}
 
@@ -213,7 +214,6 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_OK);
 
 	case ACPI_TYPE_INTEGER:
-
 		/*
 		 * Create a new Buffer object.
 		 * Need enough space for one integer
@@ -233,7 +233,6 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		break;
 
 	case ACPI_TYPE_STRING:
-
 		/*
 		 * Create a new Buffer object
 		 * Size will be the string length
@@ -258,6 +257,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_TYPE);
 	}
 
@@ -304,15 +304,18 @@ acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
 
 		switch (data_width) {
 		case 1:
+
 			decimal_length = ACPI_MAX8_DECIMAL_DIGITS;
 			break;
 
 		case 4:
+
 			decimal_length = ACPI_MAX32_DECIMAL_DIGITS;
 			break;
 
 		case 8:
 		default:
+
 			decimal_length = ACPI_MAX64_DECIMAL_DIGITS;
 			break;
 		}
@@ -546,6 +549,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_TYPE);
 	}
 
@@ -599,6 +603,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 			break;
 
 		default:
+
 			/* No conversion allowed for these types */
 
 			if (destination_type != source_desc->common.type) {
@@ -649,6 +654,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 			break;
 
 		default:
+
 			ACPI_ERROR((AE_INFO,
 				    "Bad destination type during conversion: 0x%X",
 				    destination_type));
@@ -664,6 +670,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO,
 			    "Unknown Target type ID 0x%X AmlOpcode 0x%X DestType %s",
 			    GET_CURRENT_ARG_TYPE(walk_state->op_info->
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 26a13f6..269e81d 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -103,7 +103,6 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	case ACPI_TYPE_BUFFER:
 	case ACPI_TYPE_PACKAGE:
 	case ACPI_TYPE_BUFFER_FIELD:
-
 		/*
 		 * These types open a new scope, so we need the NS node in order to access
 		 * any children.
@@ -113,7 +112,6 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_THERMAL:
 	case ACPI_TYPE_LOCAL_SCOPE:
-
 		/*
 		 * The new alias has the type ALIAS and points to the original
 		 * NS node, not the object itself.
@@ -124,7 +122,6 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 		break;
 
 	case ACPI_TYPE_METHOD:
-
 		/*
 		 * Control method aliases need to be differentiated
 		 */
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 7eb853c..81c72a4 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -193,6 +193,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 			return_VOID;
 
 		default:
+
 			break;
 		}
 
@@ -226,6 +227,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 					break;
 
 				default:
+
 					acpi_ex_do_debug_object((source_desc->
 								 reference.
 								 node)->object,
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index e5a3c24..c740f24 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -357,6 +357,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 
 		switch (info->opcode) {
 		case ACPI_EXD_INIT:
+
 			break;
 
 		case ACPI_EXD_TYPE:
@@ -718,6 +719,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 		break;
 
 	default:
+
 		/* Unknown Type */
 
 		acpi_os_printf("Unknown Type %X\n", obj_desc->common.type);
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 7d4bae7..c2a65aa 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -331,21 +331,25 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 	switch (source_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
+
 		buffer = &source_desc->integer.value;
 		length = sizeof(source_desc->integer.value);
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		buffer = source_desc->buffer.pointer;
 		length = source_desc->buffer.length;
 		break;
 
 	case ACPI_TYPE_STRING:
+
 		buffer = source_desc->string.pointer;
 		length = source_desc->string.length;
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index c84ee95..7e0afe7 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -446,7 +446,6 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		break;
 
 	case ACPI_TYPE_LOCAL_BANK_FIELD:
-
 		/*
 		 * Ensure that the bank_value is not beyond the capacity of
 		 * the register
@@ -488,7 +487,6 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		break;
 
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
-
 		/*
 		 * Ensure that the index_value is not beyond the capacity of
 		 * the register
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 72a2a13..00bf298 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -105,7 +105,6 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 		break;
 
 	case ACPI_DESC_TYPE_NAMED:
-
 		/*
 		 * A named reference that has already been resolved to a Node
 		 */
@@ -261,20 +260,24 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 	 */
 	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
+
 		status =
 		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
 		break;
 
 	case ACPI_TYPE_STRING:
+
 		status = acpi_ex_convert_to_string(operand1, &local_operand1,
 						   ACPI_IMPLICIT_CONVERT_HEX);
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		status = acpi_ex_convert_to_buffer(operand1, &local_operand1);
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
 			    operand0->common.type));
 		status = AE_AML_INTERNAL;
@@ -519,6 +522,7 @@ acpi_ex_do_logical_numeric_op(u16 opcode,
 		break;
 
 	default:
+
 		status = AE_AML_INTERNAL;
 		break;
 	}
@@ -580,20 +584,24 @@ acpi_ex_do_logical_op(u16 opcode,
 	 */
 	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
+
 		status =
 		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
 		break;
 
 	case ACPI_TYPE_STRING:
+
 		status = acpi_ex_convert_to_string(operand1, &local_operand1,
 						   ACPI_IMPLICIT_CONVERT_HEX);
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		status = acpi_ex_convert_to_buffer(operand1, &local_operand1);
 		break;
 
 	default:
+
 		status = AE_AML_INTERNAL;
 		break;
 	}
@@ -636,6 +644,7 @@ acpi_ex_do_logical_op(u16 opcode,
 			break;
 
 		default:
+
 			status = AE_AML_INTERNAL;
 			break;
 		}
@@ -703,6 +712,7 @@ acpi_ex_do_logical_op(u16 opcode,
 			break;
 
 		default:
+
 			status = AE_AML_INTERNAL;
 			break;
 		}
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index b60c877..814b4a3 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -327,7 +327,6 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 			break;
 
 		case AML_FROM_BCD_OP:	/* from_bcd (BCDValue, Result) */
-
 			/*
 			 * The 64-bit ACPI integer can hold 16 4-bit BCD characters
 			 * (if table is 32-bit, integer can hold 8 BCD characters)
@@ -407,7 +406,6 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 			break;
 
 		case AML_COND_REF_OF_OP:	/* cond_ref_of (source_object, Result) */
-
 			/*
 			 * This op is a little strange because the internal return value is
 			 * different than the return value stored in the result descriptor
@@ -442,13 +440,14 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 			goto cleanup;
 
 		default:
+
 			/* No other opcodes get here */
+
 			break;
 		}
 		break;
 
 	case AML_STORE_OP:	/* Store (Source, Target) */
-
 		/*
 		 * A store operand is typically a number, string, buffer or lvalue
 		 * Be careful about deleting the source object,
@@ -615,7 +614,6 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 	case AML_DECREMENT_OP:	/* Decrement (Operand)  */
 	case AML_INCREMENT_OP:	/* Increment (Operand)  */
-
 		/*
 		 * Create a new integer. Can't just get the base integer and
 		 * increment it because it may be an Arg or Field.
@@ -682,7 +680,6 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		break;
 
 	case AML_TYPE_OP:	/* object_type (source_object) */
-
 		/*
 		 * Note: The operand is not resolved at this point because we want to
 		 * get the associated object, not its value. For example, we don't
@@ -709,7 +706,6 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		break;
 
 	case AML_SIZE_OF_OP:	/* size_of (source_object) */
-
 		/*
 		 * Note: The operand is not resolved at this point because we want to
 		 * get the associated object, not its value.
@@ -735,10 +731,12 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		 */
 		switch (type) {
 		case ACPI_TYPE_INTEGER:
+
 			value = acpi_gbl_integer_byte_width;
 			break;
 
 		case ACPI_TYPE_STRING:
+
 			value = temp_desc->string.length;
 			break;
 
@@ -759,6 +757,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 			break;
 
 		default:
+
 			ACPI_ERROR((AE_INFO,
 				    "Operand must be Buffer/Integer/String/Package - found type %s",
 				    acpi_ut_get_type_name(type)));
@@ -860,9 +859,11 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				break;
 
 			case ACPI_TYPE_STRING:
+
 				break;
 
 			default:
+
 				status = AE_AML_OPERAND_TYPE;
 				goto cleanup;
 			}
@@ -923,7 +924,6 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 			 */
 			switch (operand[0]->reference.class) {
 			case ACPI_REFCLASS_INDEX:
-
 				/*
 				 * The target type for the Index operator must be
 				 * either a Buffer or a Package
@@ -956,7 +956,6 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					break;
 
 				case ACPI_TYPE_PACKAGE:
-
 					/*
 					 * Return the referenced element of the package. We must
 					 * add another reference to the referenced object, however.
@@ -999,6 +998,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				break;
 
 			default:
+
 				ACPI_ERROR((AE_INFO,
 					    "Unknown class in reference(%p) - 0x%2.2X",
 					    operand[0],
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index b0838a4..d5088f7 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -304,7 +304,6 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		break;
 
 	case AML_TO_STRING_OP:	/* to_string (Buffer, Length, Result) (ACPI 2.0) */
-
 		/*
 		 * Input object is guaranteed to be a buffer at this point (it may have
 		 * been converted.)  Copy the raw buffer data to a new object of
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 2d7491f..37656f1 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -155,7 +155,6 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 	switch (walk_state->opcode) {
 	case AML_MID_OP:	/* Mid (Source[0], Index[1], Length[2], Result[3]) */
-
 		/*
 		 * Create the return object. The Source operand is guaranteed to be
 		 * either a String or a Buffer, so just use its type.
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index b76b970..879b6cd 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -119,7 +119,6 @@ acpi_ex_do_match(u32 match_op,
 		break;
 
 	case MATCH_MEQ:
-
 		/*
 		 * True if equal: (P[i] == M)
 		 * Change to:     (M == P[i])
@@ -133,7 +132,6 @@ acpi_ex_do_match(u32 match_op,
 		break;
 
 	case MATCH_MLE:
-
 		/*
 		 * True if less than or equal: (P[i] <= M) (P[i] not_greater than M)
 		 * Change to:                  (M >= P[i]) (M not_less than P[i])
@@ -148,7 +146,6 @@ acpi_ex_do_match(u32 match_op,
 		break;
 
 	case MATCH_MLT:
-
 		/*
 		 * True if less than: (P[i] < M)
 		 * Change to:         (M > P[i])
@@ -162,7 +159,6 @@ acpi_ex_do_match(u32 match_op,
 		break;
 
 	case MATCH_MGE:
-
 		/*
 		 * True if greater than or equal: (P[i] >= M) (P[i] not_less than M)
 		 * Change to:                     (M <= P[i]) (M not_greater than P[i])
@@ -177,7 +173,6 @@ acpi_ex_do_match(u32 match_op,
 		break;
 
 	case MATCH_MGT:
-
 		/*
 		 * True if greater than: (P[i] > M)
 		 * Change to:            (M < P[i])
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 6b728ae..5a58861 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -253,26 +253,31 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 
 	case AML_FIELD_ACCESS_BYTE:
 	case AML_FIELD_ACCESS_BUFFER:	/* ACPI 2.0 (SMBus Buffer) */
+
 		byte_alignment = 1;
 		bit_length = 8;
 		break;
 
 	case AML_FIELD_ACCESS_WORD:
+
 		byte_alignment = 2;
 		bit_length = 16;
 		break;
 
 	case AML_FIELD_ACCESS_DWORD:
+
 		byte_alignment = 4;
 		bit_length = 32;
 		break;
 
 	case AML_FIELD_ACCESS_QWORD:	/* ACPI 2.0 */
+
 		byte_alignment = 8;
 		bit_length = 64;
 		break;
 
 	default:
+
 		/* Invalid field access type */
 
 		ACPI_ERROR((AE_INFO, "Unknown field access type 0x%X", access));
@@ -598,7 +603,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		break;
 
 	default:
+
 		/* No other types should get here */
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 182abaf..303429bb 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -88,22 +88,27 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 	switch (bit_width) {
 	case 8:
+
 		length = 1;
 		break;
 
 	case 16:
+
 		length = 2;
 		break;
 
 	case 32:
+
 		length = 4;
 		break;
 
 	case 64:
+
 		length = 8;
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Invalid SystemMemory width %u",
 			    bit_width));
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
@@ -214,23 +219,29 @@ acpi_ex_system_memory_space_handler(u32 function,
 		*value = 0;
 		switch (bit_width) {
 		case 8:
-			*value = (u64) ACPI_GET8(logical_addr_ptr);
+
+			*value = (u64)ACPI_GET8(logical_addr_ptr);
 			break;
 
 		case 16:
-			*value = (u64) ACPI_GET16(logical_addr_ptr);
+
+			*value = (u64)ACPI_GET16(logical_addr_ptr);
 			break;
 
 		case 32:
-			*value = (u64) ACPI_GET32(logical_addr_ptr);
+
+			*value = (u64)ACPI_GET32(logical_addr_ptr);
 			break;
 
 		case 64:
-			*value = (u64) ACPI_GET64(logical_addr_ptr);
+
+			*value = (u64)ACPI_GET64(logical_addr_ptr);
 			break;
 
 		default:
+
 			/* bit_width was already validated */
+
 			break;
 		}
 		break;
@@ -239,28 +250,35 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		switch (bit_width) {
 		case 8:
+
 			ACPI_SET8(logical_addr_ptr, *value);
 			break;
 
 		case 16:
+
 			ACPI_SET16(logical_addr_ptr, *value);
 			break;
 
 		case 32:
+
 			ACPI_SET32(logical_addr_ptr, *value);
 			break;
 
 		case 64:
+
 			ACPI_SET64(logical_addr_ptr, *value);
 			break;
 
 		default:
+
 			/* bit_width was already validated */
+
 			break;
 		}
 		break;
 
 	default:
+
 		status = AE_BAD_PARAMETER;
 		break;
 	}
@@ -320,6 +338,7 @@ acpi_ex_system_io_space_handler(u32 function,
 		break;
 
 	default:
+
 		status = AE_BAD_PARAMETER;
 		break;
 	}
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 8565b6b..acd34f5 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -248,6 +248,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 			break;
 
 		default:
+
 			/* No named references are allowed here */
 
 			ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index e4f9dfb..ac04278 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -156,7 +156,6 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		switch (ref_type) {
 		case ACPI_REFCLASS_LOCAL:
 		case ACPI_REFCLASS_ARG:
-
 			/*
 			 * Get the local from the method's state info
 			 * Note: this increments the local's object reference count
@@ -309,6 +308,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		break;
 
 	default:
+
 		break;
 	}
 
@@ -348,10 +348,12 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 
 	switch (ACPI_GET_DESCRIPTOR_TYPE(obj_desc)) {
 	case ACPI_DESC_TYPE_OPERAND:
+
 		type = obj_desc->common.type;
 		break;
 
 	case ACPI_DESC_TYPE_NAMED:
+
 		type = ((struct acpi_namespace_node *)obj_desc)->type;
 		obj_desc =
 		    acpi_ns_get_attached_object((struct acpi_namespace_node *)
@@ -538,7 +540,9 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 		break;
 
 	default:
+
 		/* No change to Type required */
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 9fb9f5e..00e5af7 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -307,7 +307,6 @@ acpi_ex_resolve_operands(u16 opcode,
 		case ARGI_TARGETREF:	/* Allows implicit conversion rules before store */
 		case ARGI_FIXED_TARGET:	/* No implicit conversion before store to target */
 		case ARGI_SIMPLE_TARGET:	/* Name, Local, or arg - no implicit conversion  */
-
 			/*
 			 * Need an operand of type ACPI_TYPE_LOCAL_REFERENCE
 			 * A Namespace Node is OK as-is
@@ -326,7 +325,6 @@ acpi_ex_resolve_operands(u16 opcode,
 			goto next_operand;
 
 		case ARGI_DATAREFOBJ:	/* Store operator only */
-
 			/*
 			 * We don't want to resolve index_op reference objects during
 			 * a store because this would be an implicit de_ref_of operation.
@@ -343,7 +341,9 @@ acpi_ex_resolve_operands(u16 opcode,
 			break;
 
 		default:
+
 			/* All cases covered above */
+
 			break;
 		}
 
@@ -433,7 +433,6 @@ acpi_ex_resolve_operands(u16 opcode,
 			goto next_operand;
 
 		case ARGI_BUFFER:
-
 			/*
 			 * Need an operand of type ACPI_TYPE_BUFFER,
 			 * But we can implicitly convert from a STRING or INTEGER
@@ -459,7 +458,6 @@ acpi_ex_resolve_operands(u16 opcode,
 			goto next_operand;
 
 		case ARGI_STRING:
-
 			/*
 			 * Need an operand of type ACPI_TYPE_STRING,
 			 * But we can implicitly convert from a BUFFER or INTEGER
@@ -562,6 +560,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				break;
 
 			default:
+
 				ACPI_ERROR((AE_INFO,
 					    "Needed [Buffer/String/Package/Reference], found [%s] %p",
 					    acpi_ut_get_object_type_name
@@ -584,6 +583,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				break;
 
 			default:
+
 				ACPI_ERROR((AE_INFO,
 					    "Needed [Buffer/String/Package], found [%s] %p",
 					    acpi_ut_get_object_type_name
@@ -605,6 +605,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				break;
 
 			default:
+
 				ACPI_ERROR((AE_INFO,
 					    "Needed [Region/Buffer], found [%s] %p",
 					    acpi_ut_get_object_type_name
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 93c6049..2bdba6f 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -114,6 +114,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 
 	switch (dest_desc->common.type) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
+
 		break;
 
 	case ACPI_TYPE_INTEGER:
@@ -178,7 +179,6 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 		break;
 
 	case ACPI_REFCLASS_DEBUG:
-
 		/*
 		 * Storing to the Debug object causes the value stored to be
 		 * displayed and otherwise has no effect -- see ACPI Specification
@@ -291,7 +291,6 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		break;
 
 	case ACPI_TYPE_BUFFER_FIELD:
-
 		/*
 		 * Store into a Buffer or String (not actually a real buffer_field)
 		 * at a location defined by an Index.
@@ -447,7 +446,6 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 	case ACPI_TYPE_INTEGER:
 	case ACPI_TYPE_STRING:
 	case ACPI_TYPE_BUFFER:
-
 		/*
 		 * These target types are all of type Integer/String/Buffer, and
 		 * therefore support implicit conversion before the store.
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 1cefe77..20d809d 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -85,11 +85,9 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 		 * These cases all require only Integers or values that
 		 * can be converted to Integers (Strings or Buffers)
 		 */
-
 	case ACPI_TYPE_INTEGER:
 	case ACPI_TYPE_STRING:
 	case ACPI_TYPE_BUFFER:
-
 		/*
 		 * Stores into a Field/Region or into a Integer/Buffer/String
 		 * are all essentially the same. This case handles the
@@ -133,7 +131,6 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 
 	case ACPI_TYPE_LOCAL_ALIAS:
 	case ACPI_TYPE_LOCAL_METHOD_ALIAS:
-
 		/*
 		 * All aliases should have been resolved earlier, during the
 		 * operand resolution phase.
@@ -144,7 +141,6 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 
 	case ACPI_TYPE_PACKAGE:
 	default:
-
 		/*
 		 * All other types than Alias and the various Fields come here,
 		 * including the untyped case - ACPI_TYPE_ANY.
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 579c3a5..3d36df8 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -108,7 +108,6 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		break;
 
 	case ACPI_SYS_MODE_LEGACY:
-
 		/*
 		 * BIOS should clear all fixed status bits and restore fixed event
 		 * enable bits to default
@@ -120,6 +119,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		break;
 
 	default:
+
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 20d02e9..9654050 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -127,14 +127,17 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		/*lint -fallthrough */
 
 	case ACPI_GPE_ENABLE:
+
 		ACPI_SET_BIT(enable_mask, register_bit);
 		break;
 
 	case ACPI_GPE_DISABLE:
+
 		ACPI_CLEAR_BIT(enable_mask, register_bit);
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u", action));
 		return (AE_BAD_PARAMETER);
 	}
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 083d655..8d2e866 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -419,6 +419,7 @@ acpi_status acpi_hw_register_read(u32 register_id, u32 *return_value)
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Unknown Register ID: 0x%X", register_id));
 		status = AE_BAD_PARAMETER;
 		break;
@@ -491,7 +492,6 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 
 	case ACPI_REGISTER_PM1_CONTROL:	/* PM1 A/B: 16-bit access each */
-
 		/*
 		 * Perform a read first to preserve certain bits (per ACPI spec)
 		 * Note: This includes SCI_EN, we never want to change this bit
@@ -520,7 +520,6 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
-
 		/*
 		 * For control registers, all reserved bits must be preserved,
 		 * as per the ACPI spec.
@@ -555,6 +554,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 
 	default:
+
 		ACPI_ERROR((AE_INFO, "Unknown Register ID: 0x%X", register_id));
 		status = AE_BAD_PARAMETER;
 		break;
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index f4224e6..5ee7a81 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -528,10 +528,12 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	elements = info->return_object->package.elements;
 	switch (info->return_object->package.count) {
 	case 0:
+
 		status = AE_AML_PACKAGE_LIMIT;
 		break;
 
 	case 1:
+
 		if (elements[0]->common.type != ACPI_TYPE_INTEGER) {
 			status = AE_AML_OPERAND_TYPE;
 			break;
@@ -545,6 +547,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 
 	case 2:
 	default:
+
 		if ((elements[0]->common.type != ACPI_TYPE_INTEGER) ||
 		    (elements[1]->common.type != ACPI_TYPE_INTEGER)) {
 			status = AE_AML_OPERAND_TYPE;
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 35eebda..111849c 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -314,20 +314,24 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 
 	switch (sleep_state) {
 	case ACPI_STATE_S0:
+
 		sst_value = ACPI_SST_WORKING;
 		break;
 
 	case ACPI_STATE_S1:
 	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
+
 		sst_value = ACPI_SST_SLEEPING;
 		break;
 
 	case ACPI_STATE_S4:
+
 		sst_value = ACPI_SST_SLEEP_CONTEXT;
 		break;
 
 	default:
+
 		sst_value = ACPI_SST_INDICATOR_OFF;	/* Default is off */
 		break;
 	}
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 8769cf8..c5316e5 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -151,6 +151,7 @@ acpi_status acpi_ns_root_initialize(void)
 			 */
 			switch (init_val->type) {
 			case ACPI_TYPE_METHOD:
+
 				obj_desc->method.param_count =
 				    (u8) ACPI_TO_INTEGER(val);
 				obj_desc->common.flags |= AOPOBJ_DATA_VALID;
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 8f79a9d..acd2964 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -103,6 +103,7 @@ acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
 		break;
 
 	default:
+
 		return (AE_AML_OPERAND_TYPE);
 	}
 
@@ -191,6 +192,7 @@ acpi_ns_convert_to_string(union acpi_operand_object *original_object,
 		break;
 
 	default:
+
 		return (AE_AML_OPERAND_TYPE);
 	}
 
@@ -294,6 +296,7 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 		break;
 
 	default:
+
 		return (AE_AML_OPERAND_TYPE);
 	}
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index ce6e973..7418c77 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -244,10 +244,12 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			case ACPI_TYPE_BUFFER:
 			case ACPI_TYPE_STRING:
 			case ACPI_TYPE_METHOD:
+
 				acpi_os_printf("<No attached object>");
 				break;
 
 			default:
+
 				break;
 			}
 
@@ -433,6 +435,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			break;
 
 		default:
+
 			break;
 		}
 		break;
@@ -567,32 +570,39 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			goto cleanup;
 
 		case ACPI_TYPE_BUFFER_FIELD:
+
 			obj_desc =
 			    (union acpi_operand_object *)obj_desc->buffer_field.
 			    buffer_obj;
 			break;
 
 		case ACPI_TYPE_PACKAGE:
+
 			obj_desc = (void *)obj_desc->package.elements;
 			break;
 
 		case ACPI_TYPE_METHOD:
+
 			obj_desc = (void *)obj_desc->method.aml_start;
 			break;
 
 		case ACPI_TYPE_LOCAL_REGION_FIELD:
+
 			obj_desc = (void *)obj_desc->field.region_obj;
 			break;
 
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
+
 			obj_desc = (void *)obj_desc->bank_field.region_obj;
 			break;
 
 		case ACPI_TYPE_LOCAL_INDEX_FIELD:
+
 			obj_desc = (void *)obj_desc->index_field.index_obj;
 			break;
 
 		default:
+
 			goto cleanup;
 		}
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 23e426f..dd2ceae 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -266,28 +266,34 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 
 	switch (type) {
 	case ACPI_TYPE_REGION:
+
 		info->op_region_count++;
 		break;
 
 	case ACPI_TYPE_BUFFER_FIELD:
+
 		info->field_count++;
 		break;
 
 	case ACPI_TYPE_LOCAL_BANK_FIELD:
+
 		info->field_count++;
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		info->buffer_count++;
 		break;
 
 	case ACPI_TYPE_PACKAGE:
+
 		info->package_count++;
 		break;
 
 	default:
 
 		/* No init required, just exit now */
+
 		return (AE_OK);
 	}
 
@@ -337,7 +343,9 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 		break;
 
 	default:
+
 		/* No other types can get here */
+
 		break;
 	}
 
@@ -416,6 +424,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 5c83a8b..600268d 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -344,26 +344,32 @@ static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object)
 
 	switch (return_object->common.type) {
 	case ACPI_TYPE_INTEGER:
+
 		return_btype = ACPI_RTYPE_INTEGER;
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		return_btype = ACPI_RTYPE_BUFFER;
 		break;
 
 	case ACPI_TYPE_STRING:
+
 		return_btype = ACPI_RTYPE_STRING;
 		break;
 
 	case ACPI_TYPE_PACKAGE:
+
 		return_btype = ACPI_RTYPE_PACKAGE;
 		break;
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
+
 		return_btype = ACPI_RTYPE_REFERENCE;
 		break;
 
 	default:
+
 		/* Not one of the supported objects, must be incorrect */
 
 		return_btype = ACPI_RTYPE_ANY;
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index ab2a3f4..6d55cef 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -136,7 +136,6 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	 */
 	switch (package->ret_info.type) {
 	case ACPI_PTYPE1_FIXED:
-
 		/*
 		 * The package count is fixed and there are no sub-packages
 		 *
@@ -169,7 +168,6 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		break;
 
 	case ACPI_PTYPE1_VAR:
-
 		/*
 		 * The package count is variable, there are no sub-packages, and all
 		 * elements must be of the same type
@@ -186,7 +184,6 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		break;
 
 	case ACPI_PTYPE1_OPTION:
-
 		/*
 		 * The package count is variable, there are no sub-packages. There are
 		 * a fixed number of required elements, and a variable number of
@@ -284,7 +281,6 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	case ACPI_PTYPE2_MIN:
 	case ACPI_PTYPE2_COUNT:
 	case ACPI_PTYPE2_FIX_VAR:
-
 		/*
 		 * These types all return a single Package that consists of a
 		 * variable number of sub-Packages.
@@ -500,7 +496,6 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 			break;
 
 		case ACPI_PTYPE2_COUNT:
-
 			/*
 			 * First element is the (Integer) count of elements, including
 			 * the count field (the ACPI name is num_elements)
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 89caef0..f8e71ea 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -480,6 +480,7 @@ acpi_ns_remove_null_elements(struct acpi_evaluate_info *info,
 	case ACPI_PTYPE2_MIN:
 	case ACPI_PTYPE2_REV_FIXED:
 	case ACPI_PTYPE2_FIX_VAR:
+
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 39acc4e..daac8da 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -320,6 +320,7 @@ acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		break;
 
 	default:
+
 		return (AE_AML_OPERAND_TYPE);
 	}
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 2808586..08c0b5b 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -419,10 +419,12 @@ acpi_ns_externalize_name(u32 internal_name_length,
 
 	switch (internal_name[0]) {
 	case AML_ROOT_PREFIX:
+
 		prefix_length = 1;
 		break;
 
 	case AML_PARENT_PREFIX:
+
 		for (i = 0; i < internal_name_length; i++) {
 			if (ACPI_IS_PARENT_PREFIX(internal_name[i])) {
 				prefix_length = i + 1;
@@ -438,6 +440,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 82bec40..f553cfd 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -511,6 +511,7 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
 		break;
 
 	default:
+
 		return;
 	}
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 9f25a3d..91a5a69 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -629,24 +629,28 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				switch (opcode) {
 				case AML_BYTE_OP:	/* AML_BYTEDATA_ARG */
+
 					buffer_length =
 					    ACPI_GET8(parser_state->aml);
 					parser_state->aml += 1;
 					break;
 
 				case AML_WORD_OP:	/* AML_WORDDATA_ARG */
+
 					buffer_length =
 					    ACPI_GET16(parser_state->aml);
 					parser_state->aml += 2;
 					break;
 
 				case AML_DWORD_OP:	/* AML_DWORDATA_ARG */
+
 					buffer_length =
 					    ACPI_GET32(parser_state->aml);
 					parser_state->aml += 4;
 					break;
 
 				default:
+
 					buffer_length = 0;
 					break;
 				}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 63c4554..065b44a 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -164,7 +164,6 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 			case AML_IF_OP:
 			case AML_ELSE_OP:
 			case AML_WHILE_OP:
-
 				/*
 				 * Currently supported module-level opcodes are:
 				 * IF/ELSE/WHILE. These appear to be the most common,
@@ -289,6 +288,7 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 		default:
 
 			/* No action for all other opcodes */
+
 			break;
 		}
 
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 12c4028..95dc608 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -402,6 +402,7 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 
 	switch (status) {
 	case AE_OK:
+
 		break;
 
 	case AE_CTRL_TRANSFER:
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index abc4c48..86198a9 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -176,10 +176,10 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 
 		switch (parent_info->class) {
 		case AML_CLASS_CONTROL:
+
 			break;
 
 		case AML_CLASS_CREATE:
-
 			/*
 			 * These opcodes contain term_arg operands. The current
 			 * op must be replaced by a placeholder return op
@@ -192,7 +192,6 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 			break;
 
 		case AML_CLASS_NAMED_OBJECT:
-
 			/*
 			 * These opcodes contain term_arg operands. The current
 			 * op must be replaced by a placeholder return op
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index c1934bf..877dc0d 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -308,7 +308,9 @@ union acpi_parse_object *acpi_ps_get_child(union acpi_parse_object *op)
 		break;
 
 	default:
+
 		/* All others have no children */
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 72077fa..608ebb5 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -352,6 +352,7 @@ acpi_rs_get_aml_length(struct acpi_resource * resource, acpi_size * size_needed)
 			break;
 
 		default:
+
 			break;
 		}
 
@@ -539,6 +540,7 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			break;
 
 		default:
+
 			break;
 		}
 
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index b5fc0db..8a2d498 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -120,17 +120,20 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			/* Strings */
 
 		case ACPI_RSD_LITERAL:
+
 			acpi_rs_out_string(name,
 					   ACPI_CAST_PTR(char, table->pointer));
 			break;
 
 		case ACPI_RSD_STRING:
+
 			acpi_rs_out_string(name, ACPI_CAST_PTR(char, target));
 			break;
 
 			/* Data items, 8/16/32/64 bit */
 
 		case ACPI_RSD_UINT8:
+
 			if (table->pointer) {
 				acpi_rs_out_string(name, ACPI_CAST_PTR(char,
 								       table->
@@ -142,20 +145,24 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			break;
 
 		case ACPI_RSD_UINT16:
+
 			acpi_rs_out_integer16(name, ACPI_GET16(target));
 			break;
 
 		case ACPI_RSD_UINT32:
+
 			acpi_rs_out_integer32(name, ACPI_GET32(target));
 			break;
 
 		case ACPI_RSD_UINT64:
+
 			acpi_rs_out_integer64(name, ACPI_GET64(target));
 			break;
 
 			/* Flags: 1-bit and 2-bit flags supported */
 
 		case ACPI_RSD_1BITFLAG:
+
 			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
 							       table->
 							       pointer[*target &
@@ -163,6 +170,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			break;
 
 		case ACPI_RSD_2BITFLAG:
+
 			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
 							       table->
 							       pointer[*target &
@@ -170,6 +178,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			break;
 
 		case ACPI_RSD_3BITFLAG:
+
 			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
 							       table->
 							       pointer[*target &
@@ -258,6 +267,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			break;
 
 		default:
+
 			acpi_os_printf("**** Invalid table opcode [%X] ****\n",
 				       table->opcode);
 			return;
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index d5bf05a..80d1299 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -194,7 +194,6 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			break;
 
 		case ACPI_RSC_COUNT_GPIO_RES:
-
 			/*
 			 * Vendor data is optional (length/offset may both be zero)
 			 * Examine vendor data length field first
@@ -410,12 +409,14 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			 */
 			switch (info->resource_offset) {
 			case ACPI_RSC_COMPARE_AML_LENGTH:
+
 				if (aml_resource_length != info->value) {
 					goto exit;
 				}
 				break;
 
 			case ACPI_RSC_COMPARE_VALUE:
+
 				if (ACPI_GET8(source) != info->value) {
 					goto exit;
 				}
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 59bdf37..480b6b4 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -147,6 +147,7 @@ acpi_rs_move_data(void *destination, void *source, u16 item_count, u8 move_type)
 		case ACPI_RSC_MOVE_GPIO_RES:
 		case ACPI_RSC_MOVE_SERIAL_VEN:
 		case ACPI_RSC_MOVE_SERIAL_RES:
+
 			ACPI_MEMCPY(destination, source, item_count);
 			return;
 
@@ -157,21 +158,25 @@ acpi_rs_move_data(void *destination, void *source, u16 item_count, u8 move_type)
 			 */
 		case ACPI_RSC_MOVE16:
 		case ACPI_RSC_MOVE_GPIO_PIN:
+
 			ACPI_MOVE_16_TO_16(&ACPI_CAST_PTR(u16, destination)[i],
 					   &ACPI_CAST_PTR(u16, source)[i]);
 			break;
 
 		case ACPI_RSC_MOVE32:
+
 			ACPI_MOVE_32_TO_32(&ACPI_CAST_PTR(u32, destination)[i],
 					   &ACPI_CAST_PTR(u32, source)[i]);
 			break;
 
 		case ACPI_RSC_MOVE64:
+
 			ACPI_MOVE_64_TO_64(&ACPI_CAST_PTR(u64, destination)[i],
 					   &ACPI_CAST_PTR(u64, source)[i]);
 			break;
 
 		default:
+
 			return;
 		}
 	}
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index c0e5d2d..94e3517 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -402,6 +402,7 @@ acpi_resource_to_address64(struct acpi_resource *resource,
 		break;
 
 	default:
+
 		return (AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index e57cd38..a04e54d 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -471,15 +471,19 @@ void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 	}
 	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
 	case ACPI_TABLE_ORIGIN_MAPPED:
+
 		acpi_os_unmap_memory(table_desc->pointer, table_desc->length);
 		break;
+
 	case ACPI_TABLE_ORIGIN_ALLOCATED:
+
 		ACPI_FREE(table_desc->pointer);
 		break;
 
 		/* Not mapped or allocated, there is nothing we can do */
 
 	default:
+
 		return;
 	}
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index e4c9291..1731c27 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -178,7 +178,6 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 
 		switch (internal_object->reference.class) {
 		case ACPI_REFCLASS_NAME:
-
 			/*
 			 * For namepath, return the object handle ("reference")
 			 * We are referring to the namespace node
@@ -264,7 +263,6 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
 
 	switch (object_type) {
 	case ACPI_COPY_TYPE_SIMPLE:
-
 		/*
 		 * This is a simple or null object
 		 */
@@ -278,7 +276,6 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
 		break;
 
 	case ACPI_COPY_TYPE_PACKAGE:
-
 		/*
 		 * Build the package object
 		 */
@@ -304,6 +301,7 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
 		break;
 
 	default:
+
 		return (AE_BAD_PARAMETER);
 	}
 
@@ -481,6 +479,7 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 		return_ACPI_STATUS(AE_OK);
 
 	default:
+
 		/* All other types are not supported */
 
 		ACPI_ERROR((AE_INFO,
@@ -544,7 +543,9 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 		break;
 
 	default:
+
 		/* Other types can't get here */
+
 		break;
 	}
 
@@ -800,7 +801,9 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 		break;
 
 	default:
+
 		/* Nothing to do for other simple objects */
+
 		break;
 	}
 
@@ -868,7 +871,6 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 		break;
 
 	case ACPI_COPY_TYPE_PACKAGE:
-
 		/*
 		 * This object is a package - go down another nesting level
 		 * Create and build the package object
@@ -891,6 +893,7 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 		break;
 
 	default:
+
 		return (AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 29b9302..d6b33f2 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -303,6 +303,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		break;
 
 	default:
+
 		break;
 	}
 
@@ -508,7 +509,6 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		case ACPI_TYPE_PROCESSOR:
 		case ACPI_TYPE_POWER:
 		case ACPI_TYPE_THERMAL:
-
 			/*
 			 * Update the notify objects for these types (if present)
 			 * Two lists, system and device notify handlers.
@@ -623,6 +623,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 
 		case ACPI_TYPE_REGION:
 		default:
+
 			break;	/* No subobjects for all other types */
 		}
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 9d68029..ee83adb 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -123,22 +123,27 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 
 	switch ((info->return_object)->common.type) {
 	case ACPI_TYPE_INTEGER:
+
 		return_btype = ACPI_BTYPE_INTEGER;
 		break;
 
 	case ACPI_TYPE_BUFFER:
+
 		return_btype = ACPI_BTYPE_BUFFER;
 		break;
 
 	case ACPI_TYPE_STRING:
+
 		return_btype = ACPI_BTYPE_STRING;
 		break;
 
 	case ACPI_TYPE_PACKAGE:
+
 		return_btype = ACPI_BTYPE_PACKAGE;
 		break;
 
 	default:
+
 		return_btype = 0;
 		break;
 	}
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index b543a14..ff6d9e8 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -146,6 +146,7 @@ const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status status)
 		break;
 
 	default:
+
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 43a170a..fa69071 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -341,14 +341,17 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 
 		switch (cid_objects[i]->common.type) {
 		case ACPI_TYPE_INTEGER:
+
 			string_area_size += ACPI_EISAID_STRING_SIZE;
 			break;
 
 		case ACPI_TYPE_STRING:
+
 			string_area_size += cid_objects[i]->string.length + 1;
 			break;
 
 		default:
+
 			status = AE_TYPE;
 			goto cleanup;
 		}
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 785fdd0..02f9101 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -382,10 +382,12 @@ acpi_ut_display_init_pathname(u8 type,
 
 	switch (type) {
 	case ACPI_TYPE_METHOD:
+
 		acpi_os_printf("Executing  ");
 		break;
 
 	default:
+
 		acpi_os_printf("Initializing ");
 		break;
 	}
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 1099f5c..aa61f66 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -129,6 +129,7 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
 		break;
 
 	default:
+
 		/* All others have no secondary object */
 		break;
 	}
@@ -353,6 +354,7 @@ u8 acpi_ut_valid_internal_object(void *object)
 		return (TRUE);
 
 	default:
+
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "%p is not not an ACPI operand obj [%s]\n",
 				  object, acpi_ut_get_descriptor_name(object)));
@@ -509,7 +511,6 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 
 		switch (internal_object->reference.class) {
 		case ACPI_REFCLASS_NAME:
-
 			/*
 			 * Get the actual length of the full pathname to this object.
 			 * The reference will be converted to the pathname to the object
@@ -525,7 +526,6 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 			break;
 
 		default:
-
 			/*
 			 * No other reference opcodes are supported.
 			 * Notably, Locals and Args are not supported, but this may be
@@ -585,7 +585,6 @@ acpi_ut_get_element_length(u8 object_type,
 
 	switch (object_type) {
 	case ACPI_COPY_TYPE_SIMPLE:
-
 		/*
 		 * Simple object - just get the size (Null object/entry is handled
 		 * here also) and sum it into the running package length
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index b3e36a8..31a06a1 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -186,10 +186,13 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	switch (base) {
 	case ACPI_ANY_BASE:
 	case 16:
+
 		break;
 
 	default:
+
 		/* Invalid Base */
+
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -355,36 +358,44 @@ void acpi_ut_print_string(char *string, u8 max_length)
 
 		switch (string[i]) {
 		case 0x07:
+
 			acpi_os_printf("\\a");	/* BELL */
 			break;
 
 		case 0x08:
+
 			acpi_os_printf("\\b");	/* BACKSPACE */
 			break;
 
 		case 0x0C:
+
 			acpi_os_printf("\\f");	/* FORMFEED */
 			break;
 
 		case 0x0A:
+
 			acpi_os_printf("\\n");	/* LINEFEED */
 			break;
 
 		case 0x0D:
+
 			acpi_os_printf("\\r");	/* CARRIAGE RETURN */
 			break;
 
 		case 0x09:
+
 			acpi_os_printf("\\t");	/* HORIZONTAL TAB */
 			break;
 
 		case 0x0B:
+
 			acpi_os_printf("\\v");	/* VERTICAL TAB */
 			break;
 
 		case '\'':	/* Single Quote */
 		case '\"':	/* Double Quote */
 		case '\\':	/* Backslash */
+
 			acpi_os_printf("\\%c", (int)string[i]);
 			break;
 
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 62774c7..160f13f 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -603,6 +603,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 					switch (ACPI_GET_DESCRIPTOR_TYPE
 						(descriptor)) {
 					case ACPI_DESC_TYPE_OPERAND:
+
 						if (element->size ==
 						    sizeof(union
 							   acpi_operand_object))
@@ -613,6 +614,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					case ACPI_DESC_TYPE_PARSER:
+
 						if (element->size ==
 						    sizeof(union
 							   acpi_parse_object)) {
@@ -622,6 +624,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					case ACPI_DESC_TYPE_NAMED:
+
 						if (element->size ==
 						    sizeof(struct
 							   acpi_namespace_node))
@@ -632,6 +635,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					default:
+
 						break;
 					}
 
@@ -639,6 +643,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 
 					switch (descriptor_type) {
 					case ACPI_DESC_TYPE_OPERAND:
+
 						acpi_os_printf
 						    ("%12.12s RefCount 0x%04X\n",
 						     acpi_ut_get_type_name
@@ -649,6 +654,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					case ACPI_DESC_TYPE_PARSER:
+
 						acpi_os_printf
 						    ("AmlOpcode 0x%04hX\n",
 						     descriptor->op.asl.
@@ -656,6 +662,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					case ACPI_DESC_TYPE_NAMED:
+
 						acpi_os_printf("%4.4s\n",
 							       acpi_ut_get_node_name
 							       (&descriptor->
@@ -663,6 +670,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 						break;
 
 					default:
+
 						acpi_os_printf("\n");
 						break;
 					}
-- 
1.7.10
A
