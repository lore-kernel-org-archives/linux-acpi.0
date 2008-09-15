From: Pavel Machek <pavel@suse.cz>
Subject: ACPI suspend: test 64-bit waking vector (was Re: [PATCH] ACPI
	suspend: Always use the 32-bit waking vector)
Date: Mon, 15 Sep 2008 13:18:36 +0200
Message-ID: <20080915111836.GA17913@elf.ucw.cz>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <1220577437.4007.148.camel@yakui_zhao.sh.intel.com> <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com> <200809061313.02088.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48396 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYIOMWd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2008 08:22:33 -0400
Content-Disposition: inline
In-Reply-To: <200809061313.02088.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Suspend-devel list <suspend-devel@lists.sourceforge.net>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

Hi!

ACPI specificiation tells us that x_firmware_waking_vector is
preffered, and maybe it works better than firmware_waking_vector on
some machines.

Unfortunately, it does not seem to work on thinkpad x60... but I am
not sure if I'm not doing something wrong.

Testing/ideas would be welcome.
								Pavel

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 426e5d9..8ce0899 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -164,3 +164,24 @@ #endif
 }
 
 __setup("acpi_sleep=", acpi_sleep_setup);
+
+void acpi_pmode_wakeup(void)
+{
+	asm volatile ("\
+	cli; \
+	inb     $97, %al; \
+        outb    %al, $0x80;     \
+        movb    $3, %al;        \
+        outb    %al, $97;       \
+        outb    %al, $0x80;     \
+        movb    $-74, %al;      \
+        outb    %al, $67;       \
+        outb    %al, $0x80;     \
+        movb    $-119, %al;     \
+        outb    %al, $66;       \
+        outb    %al, $0x80;     \
+        movb    $15, %al;       \
+        outb    %al, $66;  \
+	1: jmp 1b; ");
+}
+
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index dba3cfb..33f157a 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -44,6 +44,7 @@
 
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
+#include <asm/io.h>
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
@@ -60,6 +61,9 @@ ACPI_MODULE_NAME("hwsleep")
  * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
  *
  ******************************************************************************/
+
+extern void acpi_pmode_wakeup(void);
+
 acpi_status
 acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
 {
@@ -80,6 +84,12 @@ acpi_set_firmware_waking_vector(acpi_phy
 
 	/* Set the vector */
 
+	if (facs->length < 32)
+		panic("only acpi1 supported?!");
+
+	facs->firmware_waking_vector = 0;
+	facs->xfirmware_waking_vector = virt_to_phys(acpi_pmode_wakeup);
+#if 0
 	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
 		/*
 		 * ACPI 1.0 FACS or short table or optional X_ field is zero
@@ -91,6 +101,7 @@ acpi_set_firmware_waking_vector(acpi_phy
 		 */
 		facs->xfirmware_waking_vector = physical_address;
 	}
+#endif
 
 	return_ACPI_STATUS(AE_OK);
 }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
