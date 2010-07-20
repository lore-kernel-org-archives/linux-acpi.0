From: akpm@linux-foundation.org
Subject: [patch 13/26] classmate-laptop: make needlessly global symbols static
Date: Tue, 20 Jul 2010 15:19:44 -0700
Message-ID: <201007202219.o6KMJi6H021037@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51368 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932733Ab0GTWk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, cascardo@holoscopio.com, don@syst.com.br, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

cmpc_accel_sensitivity_attr is needlessly defined global.
This patch makes the symbol static.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Daniel Oliveira Nascimento <don@syst.com.br>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/classmate-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/classmate-laptop.c~classmate-laptop-make-needlessly-global-symbols-static drivers/platform/x86/classmate-laptop.c
--- a/drivers/platform/x86/classmate-laptop.c~classmate-laptop-make-needlessly-global-symbols-static
+++ a/drivers/platform/x86/classmate-laptop.c
@@ -208,7 +208,7 @@ static ssize_t cmpc_accel_sensitivity_st
 	return strnlen(buf, count);
 }
 
-struct device_attribute cmpc_accel_sensitivity_attr = {
+static struct device_attribute cmpc_accel_sensitivity_attr = {
 	.attr = { .name = "sensitivity", .mode = 0660 },
 	.show = cmpc_accel_sensitivity_show,
 	.store = cmpc_accel_sensitivity_store
_
