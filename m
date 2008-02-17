From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: i386 warnings in acpi-test
Date: Sun, 17 Feb 2008 22:49:11 +0100
Message-ID: <200802172249.11896.rjw@sisk.pl>
References: <20080215204706.89342eb5.akpm@linux-foundation.org> <200802160042.18620.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39646 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbYBQVul (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 16:50:41 -0500
In-Reply-To: <200802160042.18620.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Saturday, 16 of February 2008, Len Brown wrote:
> yeah, i know.
> 
> Linus personally created this one last week.
> 
> We're waiting for him to cool off before we re-suggest a patch that actually works:-)

Well, perhaps something like the appended one?

Thanks,
Rafael


---
 arch/x86/kernel/acpi/sleep.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -52,7 +52,7 @@ int acpi_save_state_mem(void)
 	header->video_mode = saved_video_mode;
 
 #ifndef CONFIG_64BIT
-	store_gdt(&header->pmode_gdt);
+	store_gdt((struct desc_ptr *)&header->pmode_gdt);
 
 	header->pmode_efer_low = nx_enabled;
 	if (header->pmode_efer_low & 1) {
@@ -68,8 +68,8 @@ int acpi_save_state_mem(void)
 	header->real_magic = 0x12345678;
 
 #ifndef CONFIG_64BIT
-	header->pmode_entry = &wakeup_pmode_return;
-	header->pmode_cr3 = swsusp_pg_dir - __PAGE_OFFSET;
+	header->pmode_entry = (u32)&wakeup_pmode_return;
+	header->pmode_cr3 = (u32)(swsusp_pg_dir - __PAGE_OFFSET);
 	saved_magic = 0x12345678;
 #else /* CONFIG_64BIT */
 	header->trampoline_segment = setup_trampoline() >> 4;
