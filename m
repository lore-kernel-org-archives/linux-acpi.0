From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/7] ACPI Hibernation: Use ACPI hardware signature
Date: Tue, 20 May 2008 01:31:33 +0200
Message-ID: <200805200131.33913.rjw@sisk.pl>
References: <200805200129.19904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40095 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbYESXmN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 May 2008 19:42:13 -0400
In-Reply-To: <200805200129.19904.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

ACPI defines a hardware signature. BIOS calculates the signature
according to hardware configure, if hardware changes, the signature
will change, in this case, S4 resume should fail.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/sleep/main.c           |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -255,6 +255,17 @@ static struct dmi_system_id __initdata a
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
+static unsigned long s4_hardware_signature;
+static struct acpi_table_facs *facs;
+static bool nosigcheck;
+
+static int __init acpi_s4_nosigcheck(char *str)
+{
+	nosigcheck = true;
+	return 1;
+}
+__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
@@ -301,6 +312,12 @@ static void acpi_hibernation_leave(void)
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	/* Check the hardware signature */
+	if (facs && s4_hardware_signature != facs->hardware_signature) {
+		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
+			"cannot resume!\n");
+		panic("ACPI S4 hardware signature mismatch");
+	}
 }
 
 static void acpi_hibernation_finish(void)
@@ -501,6 +518,13 @@ int __init acpi_sleep_init(void)
 		hibernation_set_ops(&acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
+		if (!nosigcheck) {
+			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+				(struct acpi_table_header **)&facs);
+			if (facs)
+				s4_hardware_signature =
+					facs->hardware_signature;
+		}
 	}
 #endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -152,6 +152,11 @@ and is between 256 and 4096 characters. 
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
 
+	acpi_s4_nosigcheck [HW,ACPI] S4 hardware signature
+			ACPI will ignore the S4 hardware signature
+			default: The hardware signature is checked during
+			         resume from S4.
+
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 

