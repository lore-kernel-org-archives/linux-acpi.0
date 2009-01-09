From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/94] ACPI: ec.c, pci_link.c, video_detec.c: static
Date: Fri, 09 Jan 2009 04:27:02 -0500
Message-ID: <8a383ef0be01e0e6e84c85f8bf35e4e6fcfb8981.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62823 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbZAIJ2X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:23 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MF96B89KX0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:21 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c           |    4 ++--
 drivers/acpi/pci_link.c     |    2 +-
 drivers/acpi/video_detect.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 30f3ef2..783acda 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -370,7 +370,7 @@ unlock:
  * Note: samsung nv5000 doesn't work with ec burst mode.
  * http://bugzilla.kernel.org/show_bug.cgi?id=4980
  */
-int acpi_ec_burst_enable(struct acpi_ec *ec)
+static int acpi_ec_burst_enable(struct acpi_ec *ec)
 {
 	u8 d;
 	struct transaction t = {.command = ACPI_EC_BURST_ENABLE,
@@ -380,7 +380,7 @@ int acpi_ec_burst_enable(struct acpi_ec *ec)
 	return acpi_ec_transaction(ec, &t, 0);
 }
 
-int acpi_ec_burst_disable(struct acpi_ec *ec)
+static int acpi_ec_burst_disable(struct acpi_ec *ec)
 {
 	struct transaction t = {.command = ACPI_EC_BURST_DISABLE,
 				.wdata = NULL, .rdata = NULL,
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index e52ad91..4869fa1 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -912,7 +912,7 @@ static int __init acpi_irq_nobalance_set(char *str)
 
 __setup("acpi_irq_nobalance", acpi_irq_nobalance_set);
 
-int __init acpi_irq_balance_set(char *str)
+static int __init acpi_irq_balance_set(char *str)
 {
 	acpi_irq_balance = 1;
 	return 1;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index f022eb6..50e3d2d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -234,7 +234,7 @@ EXPORT_SYMBOL(acpi_video_display_switch_support);
  * To force that backlight or display output switching is processed by vendor
  * specific acpi drivers or video.ko driver.
  */
-int __init acpi_backlight(char *str)
+static int __init acpi_backlight(char *str)
 {
 	if (str == NULL || *str == '\0')
 		return 1;
@@ -250,7 +250,7 @@ int __init acpi_backlight(char *str)
 }
 __setup("acpi_backlight=", acpi_backlight);
 
-int __init acpi_display_output(char *str)
+static int __init acpi_display_output(char *str)
 {
 	if (str == NULL || *str == '\0')
 		return 1;
-- 
1.5.6.6

