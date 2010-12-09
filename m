From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] ACPI: fix section mismatch warning
Date: Thu,  9 Dec 2010 12:35:12 +0900
Message-ID: <1291865712-31557-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:56920 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab0LIDfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2010 22:35:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Annotate acpi_os_initialize1() as __init to fix following warning:

  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x231587): Section mismatch in reference from the function
	 acpi_os_initialize1() to the function .init.text:acpi_osi_setup_late()
The function acpi_os_initialize1() references
the function __init acpi_osi_setup_late().
This is often because acpi_os_initialize1 lacks a __init
annotation or the annotation of acpi_osi_setup_late is wrong.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 966feddf6b1b..f7227e990b0f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1530,7 +1530,7 @@ acpi_status __init acpi_os_initialize(void)
 	return AE_OK;
 }
 
-acpi_status acpi_os_initialize1(void)
+acpi_status __init acpi_os_initialize1(void)
 {
 	kacpid_wq = create_workqueue("kacpid");
 	kacpi_notify_wq = create_workqueue("kacpi_notify");
-- 
1.7.3.3.400.g93cef

