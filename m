From: akpm@linux-foundation.org
Subject: [patch 21/26] hp-wmi: add return value checking for input_allocate_device()
Date: Tue, 20 Jul 2010 15:19:51 -0700
Message-ID: <201007202219.o6KMJplm021085@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40151 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932070Ab0GTWYX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:24:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, mjg@redhat.com, trenn@suse.de

From: Axel Lin <axel.lin@gmail.com>

Add error checking and return -ENOMEM if input_allocate_device() fail.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/hp-wmi.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/platform/x86/hp-wmi.c~hp-wmi-add-return-value-checking-for-input_allocate_device drivers/platform/x86/hp-wmi.c
--- a/drivers/platform/x86/hp-wmi.c~hp-wmi-add-return-value-checking-for-input_allocate_device
+++ a/drivers/platform/x86/hp-wmi.c
@@ -527,6 +527,8 @@ static int __init hp_wmi_input_setup(voi
 	int err;
 
 	hp_wmi_input_dev = input_allocate_device();
+	if (!hp_wmi_input_dev)
+		return -ENOMEM;
 
 	hp_wmi_input_dev->name = "HP WMI hotkeys";
 	hp_wmi_input_dev->phys = "wmi/input0";
_
