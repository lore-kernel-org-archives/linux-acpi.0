From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/4] sony-laptop should depend on RFKILL
Date: Wed,  1 Apr 2009 22:10:46 +0900
Message-ID: <1238591447-13338-4-git-send-email-malattia@linux.it>
References: <1238591447-13338-1-git-send-email-malattia@linux.it>
 <1238591447-13338-2-git-send-email-malattia@linux.it>
 <1238591447-13338-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56579
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758941AbZDANKu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:10:50 -0400
In-Reply-To: <1238591447-13338-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexander Beregalov <a.beregalov@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Alexander Beregalov <a.beregalov@gmail.com>

Fixes this build error when RFKILL is not set:

drivers/platform/x86/sony-laptop.c:1050: undefined reference to `rfkill_unregister'
and so on..

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 3608081..36b1628 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -165,6 +165,7 @@ config SONY_LAPTOP
 	depends on ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
+	depends on RFKILL
 	  ---help---
 	  This mini-driver drives the SNC and SPIC devices present in the ACPI
 	  BIOS of the Sony Vaio laptops.
-- 
1.6.2.1

