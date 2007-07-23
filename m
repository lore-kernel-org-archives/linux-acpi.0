From: helgaas@ldl.fc.hp.com
Subject: [patch 12/17] PNPBIOS: Lindent bioscalls.c
Date: Mon, 23 Jul 2007 15:28:09 -0600
Message-ID: <20070723213242.747295779@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:45625 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759298AbXGWVdh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:37 -0400
Content-Disposition: inline; filename=pnpbios-format-bioscalls
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.  Remove unused code under
"#if needed".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- work2.orig/drivers/pnp/pnpbios/bioscalls.c	2007-07-23 14:30:22.000000000 -0600
+++ work2/drivers/pnp/pnpbios/bioscalls.c	2007-07-23 14:30:56.000000000 -0600
@@ -1,6 +1,5 @@
 /*
  * bioscalls.c - the lowlevel layer of the PnPBIOS driver
- *
  */
 
 #include <linux/types.h>
@@ -26,11 +25,10 @@
 #include "pnpbios.h"
 
 static struct {
-	u16	offset;
-	u16	segment;
+	u16 offset;
+	u16 segment;
 } pnp_bios_callpoint;
 
-
 /*
  * These are some opcodes for a "static asmlinkage"
  * As this code is *not* executed inside the linux kernel segment, but in a
@@ -44,8 +42,7 @@
 
 asmlinkage void pnp_bios_callfunc(void);
 
-__asm__(
-	".text			\n"
+__asm__(".text			\n"
 	__ALIGN_STR "\n"
 	"pnp_bios_callfunc:\n"
 	"	pushl %edx	\n"
@@ -55,8 +52,7 @@
 	"	lcallw *pnp_bios_callpoint\n"
 	"	addl $16, %esp	\n"
 	"	lret		\n"
-	".previous		\n"
-);
+	".previous		\n");
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
@@ -78,7 +74,6 @@
 
 static spinlock_t pnp_bios_lock;
 
-
 /*
  * Support Functions
  */
@@ -97,7 +92,7 @@
 	 * PnP BIOSes are generally not terribly re-entrant.
 	 * Also, don't rely on them to save everything correctly.
 	 */
-	if(pnp_bios_is_utter_crap)
+	if (pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
 	cpu = get_cpu();
@@ -113,112 +108,128 @@
 	if (ts2_size)
 		Q2_SET_SEL(smp_processor_id(), PNP_TS2, ts2_base, ts2_size);
 
-	__asm__ __volatile__(
-	        "pushl %%ebp\n\t"
-		"pushl %%edi\n\t"
-		"pushl %%esi\n\t"
-		"pushl %%ds\n\t"
-		"pushl %%es\n\t"
-		"pushl %%fs\n\t"
-		"pushl %%gs\n\t"
-		"pushfl\n\t"
-		"movl %%esp, pnp_bios_fault_esp\n\t"
-		"movl $1f, pnp_bios_fault_eip\n\t"
-		"lcall %5,%6\n\t"
-		"1:popfl\n\t"
-		"popl %%gs\n\t"
-		"popl %%fs\n\t"
-		"popl %%es\n\t"
-		"popl %%ds\n\t"
-	        "popl %%esi\n\t"
-		"popl %%edi\n\t"
-		"popl %%ebp\n\t"
-		: "=a" (status)
-		: "0" ((func) | (((u32)arg1) << 16)),
-		  "b" ((arg2) | (((u32)arg3) << 16)),
-		  "c" ((arg4) | (((u32)arg5) << 16)),
-		  "d" ((arg6) | (((u32)arg7) << 16)),
-		  "i" (PNP_CS32),
-		  "i" (0)
-		: "memory"
-	);
+	__asm__ __volatile__("pushl %%ebp\n\t"
+			     "pushl %%edi\n\t"
+			     "pushl %%esi\n\t"
+			     "pushl %%ds\n\t"
+			     "pushl %%es\n\t"
+			     "pushl %%fs\n\t"
+			     "pushl %%gs\n\t"
+			     "pushfl\n\t"
+			     "movl %%esp, pnp_bios_fault_esp\n\t"
+			     "movl $1f, pnp_bios_fault_eip\n\t"
+			     "lcall %5,%6\n\t"
+			     "1:popfl\n\t"
+			     "popl %%gs\n\t"
+			     "popl %%fs\n\t"
+			     "popl %%es\n\t"
+			     "popl %%ds\n\t"
+			     "popl %%esi\n\t"
+			     "popl %%edi\n\t"
+			     "popl %%ebp\n\t":"=a"(status)
+			     :"0"((func) | (((u32) arg1) << 16)),
+			     "b"((arg2) | (((u32) arg3) << 16)),
+			     "c"((arg4) | (((u32) arg5) << 16)),
+			     "d"((arg6) | (((u32) arg7) << 16)),
+			     "i"(PNP_CS32), "i"(0)
+			     :"memory");
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 
 	get_cpu_gdt_table(cpu)[0x40 / 8] = save_desc_40;
 	put_cpu();
 
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
-	if(pnp_bios_is_utter_crap)
-	{
-		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue\n");
-		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"pnpbios=off\" option to operate stably\n");
-		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
+	if (pnp_bios_is_utter_crap) {
+		printk(KERN_ERR
+		       "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue\n");
+		printk(KERN_ERR
+		       "PnPBIOS: You may need to reboot with the \"pnpbios=off\" option to operate stably\n");
+		printk(KERN_ERR
+		       "PnPBIOS: Check with your vendor for an updated BIOS\n");
 	}
 
 	return status;
 }
 
-void pnpbios_print_status(const char * module, u16 status)
+void pnpbios_print_status(const char *module, u16 status)
 {
-	switch(status) {
+	switch (status) {
 	case PNP_SUCCESS:
 		printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
 		break;
 	case PNP_NOT_SET_STATICALLY:
-		printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n",
+		       module);
 		break;
 	case PNP_UNKNOWN_FUNCTION:
-		printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n",
+		       module);
 		break;
 	case PNP_FUNCTION_NOT_SUPPORTED:
-		printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+		printk(KERN_ERR
+		       "PnPBIOS: %s: function not supported on this system\n",
+		       module);
 		break;
 	case PNP_INVALID_HANDLE:
 		printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
 		break;
 	case PNP_BAD_PARAMETER:
-		printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n",
+		       module);
 		break;
 	case PNP_SET_FAILED:
-		printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n",
+		       module);
 		break;
 	case PNP_EVENTS_NOT_PENDING:
 		printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
 		break;
 	case PNP_SYSTEM_NOT_DOCKED:
-		printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n",
+		       module);
 		break;
 	case PNP_NO_ISA_PNP_CARDS:
-		printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+		printk(KERN_ERR
+		       "PnPBIOS: %s: no isapnp cards are installed on this system\n",
+		       module);
 		break;
 	case PNP_UNABLE_TO_DETERMINE_DOCK_CAPABILITIES:
-		printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+		printk(KERN_ERR
+		       "PnPBIOS: %s: cannot determine the capabilities of the docking station\n",
+		       module);
 		break;
 	case PNP_CONFIG_CHANGE_FAILED_NO_BATTERY:
-		printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+		printk(KERN_ERR
+		       "PnPBIOS: %s: unable to undock, the system does not have a battery\n",
+		       module);
 		break;
 	case PNP_CONFIG_CHANGE_FAILED_RESOURCE_CONFLICT:
-		printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+		printk(KERN_ERR
+		       "PnPBIOS: %s: could not dock due to resource conflicts\n",
+		       module);
 		break;
 	case PNP_BUFFER_TOO_SMALL:
-		printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n",
+		       module);
 		break;
 	case PNP_USE_ESCD_SUPPORT:
 		printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
 		break;
 	case PNP_MESSAGE_NOT_SUPPORTED:
-		printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n",
+		       module);
 		break;
 	case PNP_HARDWARE_ERROR:
-		printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n",
+		       module);
 		break;
 	default:
-		printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+		printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module,
+		       status);
 		break;
 	}
 }
 
-
 /*
  * PnP BIOS Low Level Calls
  */
@@ -243,19 +254,22 @@
 static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0,
-			       data, sizeof(struct pnp_dev_node_info), NULL, 0);
+	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2,
+			       PNP_TS1, PNP_DS, 0, 0, data,
+			       sizeof(struct pnp_dev_node_info), NULL, 0);
 	data->no_nodes &= 0xff;
 	return status;
 }
 
 int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
-	int status = __pnp_bios_dev_node_info( data );
-	if ( status )
-		pnpbios_print_status( "dev_node_info", status );
+	int status = __pnp_bios_dev_node_info(data);
+
+	if (status)
+		pnpbios_print_status("dev_node_info", status);
 	return status;
 }
 
@@ -273,17 +287,20 @@
  *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
-static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+static int __pnp_bios_get_dev_node(u8 *nodenum, char boot,
+				   struct pnp_bios_node *data)
 {
 	u16 status;
 	u16 tmp_nodenum;
+
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot && pnpbios_dont_use_current_config )
+	if (!boot && pnpbios_dont_use_current_config)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	tmp_nodenum = *nodenum;
-	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
-			       &tmp_nodenum, sizeof(tmp_nodenum), data, 65536);
+	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2,
+			       boot ? 2 : 1, PNP_DS, 0, &tmp_nodenum,
+			       sizeof(tmp_nodenum), data, 65536);
 	*nodenum = tmp_nodenum;
 	return status;
 }
@@ -291,104 +308,66 @@
 int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	int status;
-	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
-	if ( status )
-		pnpbios_print_status( "get_dev_node", status );
+
+	status = __pnp_bios_get_dev_node(nodenum, boot, data);
+	if (status)
+		pnpbios_print_status("get_dev_node", status);
 	return status;
 }
 
-
 /*
  * Call PnP BIOS with function 0x02, "set system device node"
  * Input: *nodenum = desired node, 
  *        boot = whether to set nonvolatile boot (!=0)
  *               or volatile current (0) config
  */
-static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+static int __pnp_bios_set_dev_node(u8 nodenum, char boot,
+				   struct pnp_bios_node *data)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot && pnpbios_dont_use_current_config )
+	if (!boot && pnpbios_dont_use_current_config)
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
-			       data, 65536, NULL, 0);
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1,
+			       boot ? 2 : 1, PNP_DS, 0, 0, data, 65536, NULL,
+			       0);
 	return status;
 }
 
 int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	int status;
-	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
-	if ( status ) {
-		pnpbios_print_status( "set_dev_node", status );
+
+	status = __pnp_bios_set_dev_node(nodenum, boot, data);
+	if (status) {
+		pnpbios_print_status("set_dev_node", status);
 		return status;
 	}
-	if ( !boot ) { /* Update devlist */
-		status =  pnp_bios_get_dev_node( &nodenum, boot, data );
-		if ( status )
+	if (!boot) {		/* Update devlist */
+		status = pnp_bios_get_dev_node(&nodenum, boot, data);
+		if (status)
 			return status;
 	}
 	return status;
 }
 
-#if needed
-/*
- * Call PnP BIOS with function 0x03, "get event"
- */
-static int pnp_bios_get_event(u16 *event)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
-			       event, sizeof(u16), NULL, 0);
-	return status;
-}
-#endif
-
-#if needed
-/*
- * Call PnP BIOS with function 0x04, "send message"
- */
-static int pnp_bios_send_message(u16 message)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0, 0, 0, 0, 0);
-	return status;
-}
-#endif
-
 /*
  * Call PnP BIOS with function 0x05, "get docking station information"
  */
 int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       data, sizeof(struct pnp_docking_station_info), NULL, 0);
-	return status;
-}
 
-#if needed
-/*
- * Call PnP BIOS with function 0x09, "set statically allocated resource
- * information"
- */
-static int pnp_bios_set_stat_res(char *info)
-{
-	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       info, *((u16 *) info), 0, 0);
+	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1,
+			       PNP_DS, 0, 0, 0, 0, data,
+			       sizeof(struct pnp_docking_station_info), NULL,
+			       0);
 	return status;
 }
-#endif
 
 /*
  * Call PnP BIOS with function 0x0a, "get statically allocated resource
@@ -397,36 +376,23 @@
 static int __pnp_bios_get_stat_res(char *info)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       info, 65536, NULL, 0);
+	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1,
+			       PNP_DS, 0, 0, 0, 0, info, 65536, NULL, 0);
 	return status;
 }
 
 int pnp_bios_get_stat_res(char *info)
 {
 	int status;
-	status = __pnp_bios_get_stat_res( info );
-	if ( status )
-		pnpbios_print_status( "get_stat_res", status );
-	return status;
-}
 
-#if needed
-/*
- * Call PnP BIOS with function 0x0b, "get APM id table"
- */
-static int pnp_bios_apm_id_table(char *table, u16 *size)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0,
-			       table, *size, size, sizeof(u16));
+	status = __pnp_bios_get_stat_res(info);
+	if (status)
+		pnpbios_print_status("get_stat_res", status);
 	return status;
 }
-#endif
 
 /*
  * Call PnP BIOS with function 0x40, "get isa pnp configuration structure"
@@ -434,19 +400,22 @@
 static int __pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       data, sizeof(struct pnp_isa_config_struc), NULL, 0);
+	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS,
+			       0, 0, 0, 0, data,
+			       sizeof(struct pnp_isa_config_struc), NULL, 0);
 	return status;
 }
 
 int pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
 	int status;
-	status = __pnp_bios_isapnp_config( data );
-	if ( status )
-		pnpbios_print_status( "isapnp_config", status );
+
+	status = __pnp_bios_isapnp_config(data);
+	if (status)
+		pnpbios_print_status("isapnp_config", status);
 	return status;
 }
 
@@ -456,19 +425,22 @@
 static int __pnp_bios_escd_info(struct escd_info_struc *data)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS,
-			       data, sizeof(struct escd_info_struc), NULL, 0);
+	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4,
+			       PNP_TS1, PNP_DS, data,
+			       sizeof(struct escd_info_struc), NULL, 0);
 	return status;
 }
 
 int pnp_bios_escd_info(struct escd_info_struc *data)
 {
 	int status;
-	status = __pnp_bios_escd_info( data );
-	if ( status )
-		pnpbios_print_status( "escd_info", status );
+
+	status = __pnp_bios_escd_info(data);
+	if (status)
+		pnpbios_print_status("escd_info", status);
 	return status;
 }
 
@@ -479,57 +451,42 @@
 static int __pnp_bios_read_escd(char *data, u32 nvram_base)
 {
 	u16 status;
+
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, __va(nvram_base), 65536);
+	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0,
+			       0, data, 65536, __va(nvram_base), 65536);
 	return status;
 }
 
 int pnp_bios_read_escd(char *data, u32 nvram_base)
 {
 	int status;
-	status = __pnp_bios_read_escd( data, nvram_base );
-	if ( status )
-		pnpbios_print_status( "read_escd", status );
-	return status;
-}
 
-#if needed
-/*
- * Call PnP BIOS function 0x43, "write ESCD"
- */
-static int pnp_bios_write_escd(char *data, u32 nvram_base)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, __va(nvram_base), 65536);
+	status = __pnp_bios_read_escd(data, nvram_base);
+	if (status)
+		pnpbios_print_status("read_escd", status);
 	return status;
 }
-#endif
-
-
-/*
- * Initialization
- */
 
 void pnpbios_calls_init(union pnp_bios_install_struct *header)
 {
 	int i;
+
 	spin_lock_init(&pnp_bios_lock);
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
- 	for (i = 0; i < NR_CPUS; i++) {
-  		struct desc_struct *gdt = get_cpu_gdt_table(i);
-  		if (!gdt)
-  			continue;
- 		set_base(gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
- 		set_base(gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
- 		set_base(gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
-  	}
+	for (i = 0; i < NR_CPUS; i++) {
+		struct desc_struct *gdt = get_cpu_gdt_table(i);
+		if (!gdt)
+			continue;
+		set_base(gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
+		set_base(gdt[GDT_ENTRY_PNPBIOS_CS16],
+			 __va(header->fields.pm16cseg));
+		set_base(gdt[GDT_ENTRY_PNPBIOS_DS],
+			 __va(header->fields.pm16dseg));
+	}
 }

--
