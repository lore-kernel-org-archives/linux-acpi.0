From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/26] ACPI: thinkpad-acpi: trivial fix to documentation
Date: Thu, 21 Feb 2008 04:25:23 -0500
Message-ID: <5f24927f48c63e79ff8e286fc8530f4525b4182a.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36615 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756635AbYBUJ3M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:12 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix a stray ibm-acpi that should have been replaced with thinkpad-acpi.
Thanks to Damjan <gdamjan@mail.net.mk> for noticing this one.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 6c24777..33d6e5a 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1309,7 +1309,7 @@ Enabling debugging output
 The module takes a debug parameter which can be used to selectively
 enable various classes of debugging output, for example:
 
-	 modprobe ibm_acpi debug=0xffff
+	 modprobe thinkpad_acpi debug=0xffff
 
 will enable all debugging output classes.  It takes a bitmask, so
 to enable more than one output class, just add their values.
-- 
1.5.4.2

