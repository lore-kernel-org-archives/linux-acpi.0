From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/41] sony-laptop: Small update to the Kconfig help to make people believe this driver is useful.
Date: Tue, 13 Feb 2007 00:49:16 -0500
Message-ID: <11713458031539-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060AbXBMFuF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:05 -0500
In-Reply-To: <11713458021568-git-send-email-lenb@kernel.org>
Message-Id: <e94975adbc53d65bc0362f8eec5f77bea7c88425.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 78fc47b..009aff8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -98,7 +98,8 @@ config SONY_LAPTOP
 
 	  It gives access to some extra laptop functionalities. In
 	  its current form, the only thing this driver does is letting
-	  the user set or query the screen brightness.
+	  the user set or query the screen brightness and remove/apply
+	  power to some devices.
 
 	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
 
-- 
1.5.0.rc4.345.gb4d2
