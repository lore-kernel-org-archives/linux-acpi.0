From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH1/2] ACPI : Add module parameter processor.idle to disable
	mwait for CPU C-states
Date: Fri, 13 Jun 2008 13:32:30 +0800
Message-ID: <1213335150.13591.15.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1085 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbYFMFWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 01:22:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject:[ACPI]:Add module parameter processor.idle to disable mwait for CPU C-states
From: Zhao Yakui <yakui.zhao@intel.com>

Add the module parameter processor.idle to disable Mwait for CPU C-states.
If the module parameter of "processor.idle=1" is added , OSPM should not 
use mwait for cpu idle even when the mwait is supported. In such case the 
C2C3_FFH access mode will be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/processor_core.c       |   16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -79,6 +79,10 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
+static int idle_nomwait;
+module_param_named(idle, idle_nomwait, int, 0);
+MODULE_PARM_DESC(idle, "Disable the mwait for CPU idle");
+
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
@@ -261,11 +265,21 @@ static int acpi_processor_set_pdc(struct
 {
 	struct acpi_object_list *pdc_in = pr->pdc;
 	acpi_status status = AE_OK;
+	u32 *buffer = NULL;
+	union acpi_object *obj;
 
 
 	if (!pdc_in)
 		return status;
-
+	if (idle_nomwait) {
+		/*
+		 * If mwait is not used for cpu C-states, the C2C3_FFH
+		 * will be disabled in the paramter of _PDC object.
+		 */
+		obj = pdc_in->pointer;
+		buffer = (u32 *) (obj->buffer.pointer);
+		buffer[2] &= ~ACPI_PDC_C_C2C3_FFH;
+	}
 	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -1617,6 +1617,10 @@ and is between 256 and 4096 characters. 
 			Ignore the _CST method to determine C-states,
 			instead using the legacy FADT method
 
+	processor.idle=	[HW,ACPI]
+			{ 1 } disable MWait for CPU C-states even when MWAIT
+			is supported
+
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
 			See Documentation/ramdisk.txt.


