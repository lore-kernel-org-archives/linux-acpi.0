From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/26] ACPI: thinkpad-acpi: synchronize input device switches
Date: Thu, 21 Feb 2008 04:37:58 -0500
Message-ID: <7526696a013f33d4926fdc080c26fe6af07ba30f.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:30080 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759324AbYBUJjL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:11 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Issue EV_SW events at module init time to synchronize the input device with
the current state of the switch, otherwise we might lose the first event.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6da3f40..02f9465 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2034,6 +2034,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 		hotkey_poll_setup_safe(1);
+		tpacpi_input_send_radiosw();
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
-- 
1.5.4

