From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20090123 linuxized patches
Date: Wed, 04 Feb 2009 00:05:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902032345550.5607@localhost.localdomain>
References: <1233711772.13659.28.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51430 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZBDFFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 00:05:50 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KEI008CTZHNTZZ3@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Feb 2009 23:05:48 -0600 (CST)
In-reply-to: <1233711772.13659.28.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

> ACPICA: Add error check to debug object dump routine
> ACPICA: Allow OS override of all ACPI tables

We'll need to expand acpi_os_table_override()
if we want to take advantage of this new ACPICA feature.

I suppose we'll do it the first time we need it:-)

> ACPICA: Remove extraneous parameter in table manager
> ACPICA: Add override for dynamic tables

ditto above.

Note that the reason that I didn't accept Thomas' proposal
to add SSDT overrides to Linux was because if you're doing
an override, you can always just combine the SSDT into the
DSDT override and disable loading SSDTs.
Also, the mechanism to identify the table
was the signature, and it wasn't immediately obvious how to identify
one of several SSDTs.

> ACPICA: Update FADT flag definitions

Thanks for digging through this.  It seems that sins
like the undocumented FADT v2 simply can't be swept under the rug:-)

> ACPICA: Update version to 20090123

I'm going to ignore these warnings from checkpatch.pl,
but I'd rather not have to...

applied to acpica branch.

thanks,
Len Brown, Intel Open Source Technology Center

---
scripts/checkpatch.pl
ERROR: return is not a function, parentheses are not required
#25: FILE: drivers/acpi/acpica/nsdump.c:187:
+		return (AE_OK);

WARNING: braces {} are not necessary for single statement blocks
#98: FILE: drivers/acpi/acpica/tbutils.c:317:
+	if (!mapped_table) {
 		return;
 	}

WARNING: line over 80 characters
#106: FILE: drivers/acpi/acpica/tbutils.c:323:
+	if (signature && !ACPI_COMPARE_NAME(mapped_table->signature, 
signature)) {

WARNING: line over 80 characters
#110: FILE: drivers/acpi/acpica/tbutils.c:325:
+			    "Invalid signature 0x%X for ACPI table, 
expected [%s]",

WARNING: line over 80 characters
#516: FILE: include/acpi/actbl.h:217:
+	u8 duty_width;		/* Processor duty cycle value bit width in 
P_CNT register */

WARNING: line over 80 characters
#521: FILE: include/acpi/actbl.h:221:
+	u16 boot_flags;		/* IA-PC Boot Architecture Flags (see 
below for individual flags) */

WARNING: line over 80 characters
#531: FILE: include/acpi/actbl.h:241:
+#define ACPI_FADT_LEGACY_DEVICES    (1)  	/* 00: [V2] System has LPC 
or ISA bus devices */

WARNING: line over 80 characters
#532: FILE: include/acpi/actbl.h:242:
+#define ACPI_FADT_8042              (1<<1)	/* 01: [V3] System has an 
8042 controller on port 60/64 */

WARNING: line over 80 characters
#533: FILE: include/acpi/actbl.h:243:
+#define ACPI_FADT_NO_VGA            (1<<2)	/* 02: [V4] It is not safe 
to probe for VGA hardware */

WARNING: line over 80 characters
#534: FILE: include/acpi/actbl.h:244:
+#define ACPI_FADT_NO_MSI            (1<<3)	/* 03: [V4] Message 
Signaled Interrupts (MSI) must not be enabled */

WARNING: line over 80 characters
#535: FILE: include/acpi/actbl.h:245:
+#define ACPI_FADT_NO_ASPM           (1<<4)	/* 04: [V4] PCIe ASPM 
control must not be enabled */

WARNING: line over 80 characters
#561: FILE: include/acpi/actbl.h:251:
+#define ACPI_FADT_WBINVD            (1)	/* 00: [V1] The wbinvd 
instruction works properly */

WARNING: line over 80 characters
#562: FILE: include/acpi/actbl.h:252:
+#define ACPI_FADT_WBINVD_FLUSH      (1<<1)	/* 01: [V1] wbinvd flushes 
but does not invalidate caches */

WARNING: line over 80 characters
#563: FILE: include/acpi/actbl.h:253:
+#define ACPI_FADT_C1_SUPPORTED      (1<<2)	/* 02: [V1] All processors 
support C1 state */

WARNING: line over 80 characters
#564: FILE: include/acpi/actbl.h:254:
+#define ACPI_FADT_C2_MP_SUPPORTED   (1<<3)	/* 03: [V1] C2 state works 
on MP system */

WARNING: line over 80 characters
#565: FILE: include/acpi/actbl.h:255:
+#define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: [V1] Power button 
is handled as a control method device */

WARNING: line over 80 characters
#566: FILE: include/acpi/actbl.h:256:
+#define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: [V1] Sleep button 
is handled as a control method device */

WARNING: line over 80 characters
#567: FILE: include/acpi/actbl.h:257:
+#define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: [V1] RTC wakeup 
status not in fixed register space */

WARNING: line over 80 characters
#568: FILE: include/acpi/actbl.h:258:
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: [V1] RTC alarm can 
wake system from S4 */

WARNING: line over 80 characters
#569: FILE: include/acpi/actbl.h:259:
+#define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: [V1] ACPI timer 
width is 32-bit (0=24-bit) */

WARNING: line over 80 characters
#571: FILE: include/acpi/actbl.h:261:
+#define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: [V2] System reset 
via the FADT RESET_REG supported */

WARNING: line over 80 characters
#572: FILE: include/acpi/actbl.h:262:
+#define ACPI_FADT_SEALED_CASE       (1<<11)	/* 11: [V3] No internal 
expansion capabilities and case is sealed */

WARNING: line over 80 characters
#573: FILE: include/acpi/actbl.h:263:
+#define ACPI_FADT_HEADLESS          (1<<12)	/* 12: [V3] No local video 
capabilities or local input devices */

WARNING: line over 80 characters
#574: FILE: include/acpi/actbl.h:264:
+#define ACPI_FADT_SLEEP_TYPE        (1<<13)	/* 13: [V3] Must execute 
native instruction after writing  SLP_TYPx register */

WARNING: line over 80 characters
#575: FILE: include/acpi/actbl.h:265:
+#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)	/* 14: [V4] System 
supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */

WARNING: line over 80 characters
#576: FILE: include/acpi/actbl.h:266:
+#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)	/* 15: [V4] OSPM should 
use platform-provided timer (ACPI 3.0) */

WARNING: line over 80 characters
#577: FILE: include/acpi/actbl.h:267:
+#define ACPI_FADT_S4_RTC_VALID      (1<<16)	/* 16: [V4] Contents of 
RTC_STS valid after S4 wake (ACPI 3.0) */

WARNING: line over 80 characters
#578: FILE: include/acpi/actbl.h:268:
+#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: [V4] System is 
compatible with remote power on (ACPI 3.0) */

WARNING: line over 80 characters
#579: FILE: include/acpi/actbl.h:269:
+#define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: [V4] All local 
APICs must use cluster model (ACPI 3.0) */

WARNING: line over 80 characters
#580: FILE: include/acpi/actbl.h:270:
+#define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: [V4] All local 
x_aPICs must use physical dest mode (ACPI 3.0) */

total: 1 errors, 29 warnings, 458 lines checked


