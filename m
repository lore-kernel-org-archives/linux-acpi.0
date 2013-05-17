From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] efi: Work around bogus pointers in BGRT
Date: Fri, 17 May 2013 14:05:33 -0700
Message-ID: <7ccd9d84f7407ba65c1f03d144e2113dee0d797a.1368824585.git.luto@amacapital.net>
References: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45077 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab3EQVFo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 May 2013 17:05:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so3930864pab.27
        for <linux-acpi@vger.kernel.org>; Fri, 17 May 2013 14:05:44 -0700 (PDT)
In-Reply-To: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andy Lutomirski <luto@amacapital.net>

The MSI MS-7760 supplies a BGRT marked "invalid" that contains a
pointer to nowhere.  Since an "invalid" BGRT isn't particularly
useful (userspace isn't supposed to use it anyway), ignore the BGRT
if it's marked "invalid" and the pointer points outside of EFI boot
services space.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
This seems to fix the problem for me.

 arch/x86/platform/efi/efi-bgrt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/platform/efi/efi-bgrt.c b/arch/x86/platform/efi/efi-bgrt.c
index 7145ec6..c77b7cf 100644
--- a/arch/x86/platform/efi/efi-bgrt.c
+++ b/arch/x86/platform/efi/efi-bgrt.c
@@ -49,6 +49,18 @@ void __init efi_bgrt_init(void)
 
 	image = efi_lookup_mapped_addr(bgrt_tab->image_address);
 	if (!image) {
+		if (!(bgrt_tab->status & 1)) {
+			/*
+			 * The MSI MS-7760 exposes an "invalid" BGRT
+			 * containing a pointer to nowhere.  This heuristic
+			 * will avoid following that pointer.  (The idea
+			 * is that an "invalid" image pointing into boot
+			 * services data is probably sensible, but other
+			 * "invalid" pointers are questionable.)
+			 */
+			return;
+		}
+
 		image = ioremap(bgrt_tab->image_address, sizeof(bmp_header));
 		ioremapped = true;
 		if (!image)
-- 
1.8.1.4

