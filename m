From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 4/33 v2] drivers/acpi: Make static
Date: Tue, 09 Dec 2008 20:45:30 +0100
Message-ID: <493ECADA.6040001@gmail.com>
References: <493EA286.7080500@gmail.com> <493EA48A.1080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:42431 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbYLITpc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Dec 2008 14:45:32 -0500
Received: by ey-out-2122.google.com with SMTP id 6so28400eyi.37
        for <linux-acpi@vger.kernel.org>; Tue, 09 Dec 2008 11:45:30 -0800 (PST)
In-Reply-To: <493EA48A.1080702@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/acpi/ec.c           |    4 ++--
 drivers/acpi/pci_link.c     |    2 +-
 drivers/acpi/video_detect.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

please ignore previous patch (ec_burst_enable and ec_burst_disable were exported)

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
