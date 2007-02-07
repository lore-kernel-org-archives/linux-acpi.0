From: Len Brown <lenb@kernel.org>
Subject: [PATCH 120/140] ACPICA: Allow processor to be declared with the Device() instead of Processor()
Date: Wed,  7 Feb 2007 13:52:14 -0500
Message-ID: <1170874535674-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <11bf04c44fd284a5f4e2348a04da6f749cace250.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21178 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422865AbXBGSzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:39 -0500
In-Reply-To: <1170874535409-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Allow processor to be declered with the Device(), such as:
Device(CPU1234) {
	Name(_HID, "ACPI007")
	Name(_UID, 1234)
}

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   53 ++++++++++++++++++++++++----------------
 include/acpi/acpi_drivers.h   |    2 +-
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 6893c0b..eacf9a2 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -377,7 +377,7 @@ static int acpi_processor_remove_fs(struct acpi_device *device)
 /* Use the acpiid in MADT to map cpus in case of SMP */
 
 #ifndef CONFIG_SMP
-#define convert_acpiid_to_cpu(acpi_id) (-1)
+static int get_cpu_id(acpi_handle handle, u32 acpi_id) {return -1;}
 #else
 
 static struct acpi_table_madt *madt;
@@ -483,7 +483,7 @@ exit:
 	return apic_id;
 }
 
-static int get_apic_id(acpi_handle handle, u32 acpi_id)
+static int get_cpu_id(acpi_handle handle, u32 acpi_id)
 {
 	int i;
 	int apic_id = -1;
@@ -506,7 +506,7 @@ static int get_apic_id(acpi_handle handle, u32 acpi_id)
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_processor_get_info(struct acpi_processor *pr)
+static int acpi_processor_get_info(struct acpi_processor *pr, unsigned has_uid)
 {
 	acpi_status status = 0;
 	union acpi_object object = { 0 };
@@ -535,24 +535,35 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No bus mastering arbitration control\n"));
 
-	/*
-	 * Evalute the processor object.  Note that it is common on SMP to
-	 * have the first (boot) processor with a valid PBLK address while
-	 * all others have a NULL address.
-	 */
-	status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Evaluating processor object\n");
-		return -ENODEV;
-	}
-
-	/*
-	 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-	 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in arch/xxx/acpi.c
-	 */
-	pr->acpi_id = object.processor.proc_id;
+	/* Check if it is a Device with HID and UID */
+	if (has_uid) {
+		unsigned long value;
+		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
+						NULL, &value);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR PREFIX "Evaluating processor _UID\n");
+			return -ENODEV;
+		}
+		pr->acpi_id = value;
+	} else {
+		/*
+		* Evalute the processor object.  Note that it is common on SMP to
+		* have the first (boot) processor with a valid PBLK address while
+		* all others have a NULL address.
+		*/
+		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR PREFIX "Evaluating processor object\n");
+			return -ENODEV;
+		}
 
-	cpu_index = get_apic_id(pr->handle, pr->acpi_id);
+		/*
+		* TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
+		*      >>> 'acpi_get_processor_id(acpi_id, &id)' in arch/xxx/acpi.c
+		*/
+		pr->acpi_id = object.processor.proc_id;
+	}
+	cpu_index = get_cpu_id(pr->handle, pr->acpi_id);
 
 	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
 	if (!cpu0_initialized && (cpu_index == -1) &&
@@ -621,7 +632,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 
 	pr = acpi_driver_data(device);
 
-	result = acpi_processor_get_info(pr);
+	result = acpi_processor_get_info(pr, device->flags.unique_id);
 	if (result) {
 		/* Processor is physically not present */
 		return 0;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 6a5bdce..baaa734 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -37,7 +37,7 @@
 /* _HID definitions */
 
 #define ACPI_POWER_HID			"ACPI_PWR"
-#define ACPI_PROCESSOR_HID		"ACPI_CPU"
+#define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"ACPI_SYS"
 #define ACPI_THERMAL_HID		"ACPI_THM"
 #define ACPI_BUTTON_HID_POWERF		"ACPI_FPB"
-- 
1.5.0.rc3.39.gec804
