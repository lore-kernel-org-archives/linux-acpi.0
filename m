From: Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] Fix autoloading of panasonic-laptop
Date: Wed, 14 Jan 2009 13:59:50 +0800
Message-ID: <20090114055950.GL4791@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:42375 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbZANGAK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2009 01:00:10 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

This patch adds MODULE_DEVICE_TABLE() to panasonic-laptop.c in order
to ensure automatic loading of the module on systems with the respective
"MAT*" ACPI devices.

Signed-off-by: Martin Lucina <mato@kotelna.sk>
Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 drivers/platform/x86/panasonic-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index f30db36..54aa8c9 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -184,6 +184,7 @@ static const struct acpi_device_id pcc_device_ids[] = {
 	{ "MAT0019", 0},
 	{ "", 0},
 };
+MODULE_DEVICE_TABLE(acpi, pcc_device_ids);
 
 static struct acpi_driver acpi_pcc_driver = {
 	.name =		ACPI_PCC_DRIVER_NAME,
-- 
1.5.6.5
