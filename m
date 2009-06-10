From: akpm@linux-foundation.org
Subject: [patch 3/4] dell-wmi: don't generate errors on empty messages
Date: Wed, 10 Jun 2009 12:40:48 -0700
Message-ID: <200906101940.n5AJemJc028802@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53288 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760848AbZFJTmf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2009 15:42:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mjg@redhat.com

From: Matthew Garrett <mjg@redhat.com>

There's no point in generating kernel messages if we didn't receive a
parsable keyboard event - only do so if there appeared to be a scancode.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/dell-wmi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/dell-wmi.c~dell-wmi-dont-generate-errors-on-empty-messages drivers/platform/x86/dell-wmi.c
--- a/drivers/platform/x86/dell-wmi.c~dell-wmi-dont-generate-errors-on-empty-messages
+++ a/drivers/platform/x86/dell-wmi.c
@@ -176,9 +176,9 @@ static void dell_wmi_notify(u32 value, v
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
 
_
