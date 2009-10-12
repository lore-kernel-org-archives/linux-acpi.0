From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/2] eeepc-laptop: Properly annote eeepc_enable_camera().
Date: Tue, 13 Oct 2009 00:13:32 +0200
Message-ID: <1255385613-25400-2-git-send-email-corentincj@iksaif.net>
References: <1255385613-25400-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:54313 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933446AbZJLWNW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2009 18:13:22 -0400
In-Reply-To: <1255385613-25400-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Rakib Mullick <rakib.mullick@gmail.com>, Corentin Chary <corentincj@iksaif.net>

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
---
 drivers/platform/x86/eeepc-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index b77d758..879b2e9 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -351,7 +351,7 @@ static const struct rfkill_ops eeepc_rfkill_ops = {
 	.set_block = eeepc_rfkill_set,
 };
 
-static void __init eeepc_enable_camera(void)
+static void __devinit eeepc_enable_camera(void)
 {
 	/*
 	 * If the following call to set_acpi() fails, it's because there's no
@@ -1249,7 +1249,7 @@ static int eeepc_led_init(struct device *dev)
 	return 0;
 }
 
-static int eeepc_hotk_add(struct acpi_device *device)
+static int __devinit eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
 	int result;
-- 
1.6.5.rc2

