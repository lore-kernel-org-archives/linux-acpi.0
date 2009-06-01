From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] dell-wmi: Don't generate errors on empty messages
Date: Mon,  1 Jun 2009 15:14:37 +0100
Message-ID: <1243865677-25425-3-git-send-email-mjg@redhat.com>
References: <1243865677-25425-1-git-send-email-mjg@redhat.com>
 <1243865677-25425-2-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48149 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZFAOQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2009 10:16:07 -0400
In-Reply-To: <1243865677-25425-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

There's no point in generating kernel messages if we didn't receive a
parsable keyboard event - only do so if there appeared to be a scancode.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/dell-wmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 9f345dc..0f900cc 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -176,9 +176,9 @@ static void dell_wmi_notify(u32 value, void *context)
 			input_sync(dell_wmi_input_dev);
 			input_report_key(dell_wmi_input_dev, key->keycode, 0);
 			input_sync(dell_wmi_input_dev);
-		} else
+		} else if (buffer[1] & 0xFFFF)
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
-			       buffer[1]);
+			       buffer[1] & 0xFFFF);
 	}
 }
 
-- 
1.6.2.2

