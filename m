From: Andrew Morton <akpm@osdl.org>
Subject: Re: evxfevnt glitch
Date: Wed, 12 Jul 2006 02:18:09 -0700
Message-ID: <20060712021809.683437f3.akpm@osdl.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1D28E81@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:10213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbWGLJSO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 05:18:14 -0400
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1D28E81@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 12 Jul 2006 15:58:52 +0800
"Yu, Luming" <luming.yu@intel.com> wrote:

> what kernel you are using?
> 
> Is it due to a patch to reboot box with ACPI FADT reset register?
> 

Actually, it's due to your patch ;)


See http://bugzilla.kernel.org/show_bug.cgi?id=6655

--- a/arch/i386/kernel/reboot.c~acpi-asus-s3-resume-fix
+++ a/arch/i386/kernel/reboot.c
@@ -30,6 +30,12 @@ static int reboot_thru_bios;
 #ifdef CONFIG_SMP
 static int reboot_cpu = -1;
 #endif
+#ifdef CONFIG_ACPI
+extern u32 acpi_disable(void);
+#else
+static u32 acpi_disable(void){};
+#endif
+
 static int __init reboot_setup(char *str)
 {
 	while(1) {
@@ -321,6 +327,8 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+
+	acpi_disable();
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
_


We're calling acpi_disable() even if acpi is not enabled and it gets upset.


