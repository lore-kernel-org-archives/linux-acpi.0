From: akpm@linux-foundation.org
Subject: [patch 1/7] dell_laptop: when the "hardware" switch is disabled, don't actually allow changing the softblock status.
Date: Tue, 02 Feb 2010 14:37:54 -0800
Message-ID: <201002022237.o12MbstN018680@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40500 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932136Ab0BBWjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:39:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, Mario_Limonciello@Dell.com, mjg@redhat.com

From: Mario Limonciello <Mario_Limonciello@Dell.com>

The "hardware" switch is tied directly to a BIOS interface that will
connect and disconnect the hardware from the bus.

If you use the software interface to request the BIOS to make these
changes, the HW switch will be in an inconsistent state and LEDs may not
reflect the state of the HW.

Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/dell-laptop.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/platform/x86/dell-laptop.c~dell_laptop-when-the-hardware-switch-is-disabled-dont-actually-allow-changing-the-softblock-status drivers/platform/x86/dell-laptop.c
--- a/drivers/platform/x86/dell-laptop.c~dell_laptop-when-the-hardware-switch-is-disabled-dont-actually-allow-changing-the-softblock-status
+++ a/drivers/platform/x86/dell-laptop.c
@@ -189,6 +189,10 @@ static int dell_rfkill_set(void *data, b
 	unsigned long radio = (unsigned long)data;
 
 	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
+	dell_send_request(&buffer, 17, 11);
+	if (!(buffer.output[1] & BIT(16)))
+		return -EINVAL;
+
 	buffer.input[0] = (1 | (radio<<8) | (disable << 16));
 	dell_send_request(&buffer, 17, 11);
 
_
