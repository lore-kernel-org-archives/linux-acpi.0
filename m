From: Len Brown <lenb@kernel.org>
Subject: [PATCH 085/112] asus-laptop: add parentheses
Date: Thu,  7 Feb 2008 04:34:47 -0500
Message-ID: <e1af14e4b3d5f2a348987e3069ec835b782782b0.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754768AbYBGJgs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:48 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <12o3l@tiscali.nl>, Len Brown <len.brown@intel.com>

From: Roel Kluin <12o3l@tiscali.nl>

'!' has a higher priority than '&': bitanding has no effect.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 34666ff..3bd8831 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -327,7 +327,7 @@ static void write_status(acpi_handle handle, int out, int mask)
 
 	switch (mask) {
 	case MLED_ON:
-		out = !out & 0x1;
+		out = !(out & 0x1);
 		break;
 	case GLED_ON:
 		out = (out & 0x1) + 1;
-- 
1.5.4.23.gef5b9

