From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] eeepc-laptop: Properly annote eeepc_enable_camera().
Date: Thu, 15 Oct 2009 00:59:40 -0400
Message-ID: <dcb73eed70575c68f1389f7fac7cbd0feaeb50f3.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:37926 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZJOFBN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:01:13 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ003RGHVSVRK3@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:58 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rakib Mullick <rakib.mullick@gmail.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Rakib Mullick <rakib.mullick@gmail.com>

Currently the annotation for function eeepc_enable_camera() is
__init, and refers to a
function eeepc_hotk_add() which is non-init. Use __devinit for both
functions which is
more appropriate and fixes a section mismatch warning.

 We were warned by the following warning:

  LD      drivers/platform/x86/built-in.o
WARNING: drivers/platform/x86/built-in.o(.text+0x12e1): Section
mismatch in reference from the function eeepc_hotk_add() to the
function .init.text:eeepc_enable_camera()
The function eeepc_hotk_add() references
the function __init eeepc_enable_camera().
This is often because eeepc_hotk_add lacks a __init
annotation or the annotation of eeepc_enable_camera is wrong.

Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 749e210..789d6ae 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -350,7 +350,7 @@ static const struct rfkill_ops eeepc_rfkill_ops = {
 	.set_block = eeepc_rfkill_set,
 };
 
-static void __init eeepc_enable_camera(void)
+static void __devinit eeepc_enable_camera(void)
 {
 	/*
 	 * If the following call to set_acpi() fails, it's because there's no
@@ -1189,7 +1189,7 @@ static int eeepc_input_init(struct device *dev)
 	return 0;
 }
 
-static int eeepc_hotk_add(struct acpi_device *device)
+static int __devinit eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
 	int result;
-- 
1.6.0.6

