From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPICA: Linuxize: Export debugger files to Linux
Date: Tue, 3 Nov 2015 17:25:37 +0300
Message-ID: <20151103142537.GC28591@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37159 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbKCOZq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2015 09:25:46 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Lv Zheng,

This is a semi-automatic email about new static checker warnings.

The patch 995751025572: "ACPICA: Linuxize: Export debugger files to 
Linux" from Oct 19, 2015, leads to the following Smatch complaint:

drivers/acpi/acpica/dbxface.c:298 acpi_db_single_step()
	 error: we previously assumed 'walk_state->control_state' could be null (see line 252)

drivers/acpi/acpica/dbxface.c
   251			if (parent_op) {
   252				if ((walk_state->control_state) &&
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^
Checked.

   253				    (walk_state->control_state->common.state ==
   254				     ACPI_CONTROL_PREDICATE_EXECUTING)) {
   255					/*
   256					 * We are executing the predicate of an IF or WHILE statement
   257					 * Search upwards for the containing IF or WHILE so that the
   258					 * entire predicate can be displayed.
   259					 */
   260					while (parent_op) {
   261						if ((parent_op->common.aml_opcode ==
   262						     AML_IF_OP)
   263						    || (parent_op->common.aml_opcode ==
   264							AML_WHILE_OP)) {
   265							display_op = parent_op;
   266							break;
   267						}
   268						parent_op = parent_op->common.parent;
   269					}
   270				} else {
   271					while (parent_op) {
   272						if ((parent_op->common.aml_opcode ==
   273						     AML_IF_OP)
   274						    || (parent_op->common.aml_opcode ==
   275							AML_ELSE_OP)
   276						    || (parent_op->common.aml_opcode ==
   277							AML_SCOPE_OP)
   278						    || (parent_op->common.aml_opcode ==
   279							AML_METHOD_OP)
   280						    || (parent_op->common.aml_opcode ==
   281							AML_WHILE_OP)) {
   282							break;
   283						}
   284						display_op = parent_op;
   285						parent_op = parent_op->common.parent;
   286					}
   287				}
   288			}
   289	
   290			/* Now we can display it */
   291	
   292	#ifdef ACPI_DISASSEMBLER
   293			acpi_dm_disassemble(walk_state, display_op, ACPI_UINT32_MAX);
   294	#endif
   295	
   296			if ((op->common.aml_opcode == AML_IF_OP) ||
   297			    (op->common.aml_opcode == AML_WHILE_OP)) {
   298				if (walk_state->control_state->common.value) {
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Not checked.

   299					acpi_os_printf
   300					    ("Predicate = [True], IF block was executed\n");

regards,
dan carpenter
