From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/12] sony-laptop.c: fix off-by-one
Date: Tue, 11 Mar 2008 02:51:41 -0400
Message-ID: <d399d130c82a1e1751b7770944f487fbd8b6272a.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:14880 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754187AbYCKGyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:54 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

This patch fixes an off-by-one spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 899e3f7..02ff3d1 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -315,7 +315,7 @@ static void sony_laptop_report_input_event(u8 event)
 		break;
 
 	default:
-		if (event > ARRAY_SIZE(sony_laptop_input_index)) {
+		if (event >= ARRAY_SIZE(sony_laptop_input_index)) {
 			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
 			break;
 		}
-- 
1.5.4.3.422.g34cd6

