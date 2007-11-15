From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch_5/7 ] :Throttling control uses T-states returned by
	_TSS when _TSS exists
Date: Thu, 15 Nov 2007 16:42:38 +0800
Message-ID: <1195116158.6817.14.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5910 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683AbXKOIfI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:35:08 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Throttling control uses T-states returned by _TSS when _TSS exists
>From : Zhao Yakui <yakui.zhao@intel.com>

If _TSS exists, throttling control will use the T-states returned by _TSS.
Otherwise the calculated T-states from FADT.duty_width are used.

When TSS is used , the access width is included in the PTC control/status
register.So it is unnecessary that the access bit width is multiplied by 8.
At the same time the bit_offset should be considered for system I/O Access.

It should be checked the bit_width and bit_offset of PTC regsiter in order to
avoid the failure of system I/O access. It means that bit_width plus 
bit_offset can't be greater than 32.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_throttling.c |   42 ++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
@@ -131,6 +131,7 @@ static int acpi_processor_get_throttling
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *ptc = NULL;
 	union acpi_object obj = { 0 };
+	struct acpi_processor_throttling *throttling;
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -182,6 +183,22 @@ static int acpi_processor_get_throttling
 	memcpy(&pr->throttling.status_register, obj.buffer.pointer,
 	       sizeof(struct acpi_ptc_register));
 
+	throttling = &pr->throttling;
+
+	if ((throttling->control_register.bit_width +
+		throttling->control_register.bit_offset) > 32) {
+		printk(KERN_ERR PREFIX "Invalid _PTC control register\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if ((throttling->status_register.bit_width +
+		throttling->status_register.bit_offset) > 32) {
+		printk(KERN_ERR PREFIX "Invalid _PTC status register\n");
+		result = -EFAULT;
+		goto end;
+	}
+
       end:
 	kfree(buffer.pointer);
 
@@ -379,7 +396,9 @@ static int acpi_processor_get_throttling
 static int acpi_read_throttling_status(struct acpi_processor *pr,
 					acpi_integer *value)
 {
+	u32 bit_width, bit_offset;
 	u64 ptc_value;
+	u64 ptc_mask;
 	struct acpi_processor_throttling *throttling;
 	int ret = -1;
 
@@ -387,11 +406,14 @@ static int acpi_read_throttling_status(s
 	switch (throttling->status_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		ptc_value = 0;
+		bit_width = throttling->status_register.bit_width;
+		bit_offset = throttling->status_register.bit_offset;
+
 		acpi_os_read_port((acpi_io_address) throttling->status_register.
 				  address, (u32 *) &ptc_value,
-				  (u32) throttling->status_register.bit_width *
-				  8);
-		*value = (acpi_integer) ptc_value;
+				  (u32) (bit_width + bit_offset));
+		ptc_mask = (1 << bit_width) - 1;
+		*value = (acpi_integer) ((ptc_value >> bit_offset) & ptc_mask);
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
@@ -408,18 +430,24 @@ static int acpi_read_throttling_status(s
 static int acpi_write_throttling_state(struct acpi_processor *pr,
 				acpi_integer value)
 {
+	u32 bit_width, bit_offset;
 	u64 ptc_value;
+	u64 ptc_mask;
 	struct acpi_processor_throttling *throttling;
 	int ret = -1;
 
 	throttling = &pr->throttling;
 	switch (throttling->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		ptc_value = value;
+		bit_width = throttling->control_register.bit_width;
+		bit_offset = throttling->control_register.bit_offset;
+		ptc_mask = (1 << bit_width) - 1;
+		ptc_value = value & ptc_mask;
+
 		acpi_os_write_port((acpi_io_address) throttling->
-				   control_register.address, (u32) ptc_value,
-				   (u32) throttling->control_register.
-				   bit_width * 8);
+					control_register.address,
+					(u32) (ptc_value << bit_offset),
+					(u32) (bit_width + bit_offset));
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
