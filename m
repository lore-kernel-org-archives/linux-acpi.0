From: Shaohua Li <shaohua.li@intel.com>
Subject: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
	Re: [ACPI] Resume from Suspend to RAM))
Date: Tue, 07 Jun 2005 14:23:30 +0800
Message-ID: <1118125410.3828.12.camel@linux-hp.sh.intel.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261808AbVFGGQJ@vger.kernel.org>
In-Reply-To: <200506061531.41132.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: stefandoesinger@gmx.at
Cc: acpi-dev <acpi-devel@lists.sourceforge.net>, Matthew Garrett <mjg59@srcf.ucam.org>, lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-06-06 at 23:31 +0800, stefandoesinger@gmx.at wrote:
> Am Montag, 6. Juni 2005 11:06 schrieb Matthew Garrett: 
> > Whoops. May have been a bit too hasty there. I'm not sure why that 
> > doesn't reset it, but we've now got the following (really rather
> odd) 
> > serial output. Does anyone have any idea what might be triggering
> this? 
> > Shell builtins work fine, but anything else seems to explode very 
> > messily. Memory corruption of some description?
> 
> <snip> 
> So it does reach the kernel, right? I don't know if I remembered that
> call  
> correctly, but "lcall $0xffff,$0" should call the real mode BIOS
> reset  
> code... 
> Anyone else who can correct me here?
> 
> Perhaps the disk driver is going mad? Has anyone tried to boot a
> kernel  
> without any disk drivers with a minimal root system on an initrd?
For those who suffer from strange S3 resume problem such as resume hang,
could you please try this debug patch.
It uses machine_real_restart to switch to real mode, and soon jump to
the S3 wakeup address. So it simulates how BIOS resume a system from S3,
but completely bypasses BIOS. If the system lives after S3 with the
patch, at least we can know the suspend/resume code path is ok and it's
not a Linux driver issue.

Thanks,
Shaohua

--- a/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:45:04.088273424 +0800
+++ b/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:49:31.858566152 +0800
@@ -242,6 +242,19 @@ acpi_enter_sleep_state_prep (
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
+#define S3_DEBUG
+#ifdef S3_DEBUG
+#include <asm/io.h>
+extern void machine_real_restart(unsigned char *code, int length);
+static unsigned char jump_to_pm [] =
+{
+	0xea,
+	0x00,
+	0x00,
+	0x00,
+	0x00		/*    ljmp  $0x0000,$0x0000  */
+};
+#endif
 
 acpi_status asmlinkage
 acpi_enter_sleep_state (
@@ -315,6 +328,14 @@ acpi_enter_sleep_state (
 	PM1Acontrol |= (acpi_gbl_sleep_type_a << sleep_type_reg_info->bit_position);
 	PM1Bcontrol |= (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
 
+#ifdef S3_DEBUG
+	if (sleep_state == ACPI_STATE_S3) {
+		*((short *)&jump_to_pm[3]) =
+			(short)(virt_to_phys((void *)acpi_wakeup_address)) >> 4;
+		/* Directly jump to acpi_wakeup_address */
+		machine_real_restart(jump_to_pm, sizeof(jump_to_pm));
+	}
+#endif
 	/*
 	 * We split the writes of SLP_TYP and SLP_EN to workaround
 	 * poorly implemented hardware.
