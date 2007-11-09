From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] x86_64: remove acpi_pci_link_exit()
Date: Fri, 9 Nov 2007 07:03:13 +0100
Message-ID: <20071109060313.GS26163@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52859 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755062AbXKIGDh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 01:03:37 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

acpi_pci_link_exit() is both unused and empty.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
16d6853a1facb9bcb7a4bc19daad6d3b852cace3 
diff --git a/arch/x86/kernel/acpi/sleep_64.c b/arch/x86/kernel/acpi/sleep_64.c
index 79475d2..da42de2 100644
--- a/arch/x86/kernel/acpi/sleep_64.c
+++ b/arch/x86/kernel/acpi/sleep_64.c
@@ -115,6 +115,3 @@ static int __init acpi_sleep_setup(char *str)
 
 __setup("acpi_sleep=", acpi_sleep_setup);
 
-void acpi_pci_link_exit(void)
-{
-}

