From: akpm@linux-foundation.org
Subject: [patch 15/26] msi-laptop: make struct rfkill_ops const
Date: Tue, 20 Jul 2010 15:19:46 -0700
Message-ID: <201007202219.o6KMJkUs021049@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59554 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932070Ab0GTWY4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:24:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, mjg@redhat.com, mzxreary@0pointer.de

From: Axel Lin <axel.lin@gmail.com>

rfkill uses a const struct rfkill_ops pointer.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/msi-laptop.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/msi-laptop.c~msi-laptop-make-struct-rfkill_ops-const drivers/platform/x86/msi-laptop.c
--- a/drivers/platform/x86/msi-laptop.c~msi-laptop-make-struct-rfkill_ops-const
+++ a/drivers/platform/x86/msi-laptop.c
@@ -562,15 +562,15 @@ static int rfkill_threeg_set(void *data,
 	return 0;
 }
 
-static struct rfkill_ops rfkill_bluetooth_ops = {
+static const struct rfkill_ops rfkill_bluetooth_ops = {
 	.set_block = rfkill_bluetooth_set
 };
 
-static struct rfkill_ops rfkill_wlan_ops = {
+static const struct rfkill_ops rfkill_wlan_ops = {
 	.set_block = rfkill_wlan_set
 };
 
-static struct rfkill_ops rfkill_threeg_ops = {
+static const struct rfkill_ops rfkill_threeg_ops = {
 	.set_block = rfkill_threeg_set
 };
 
_
