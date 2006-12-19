From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 7/22] Remove useless casts
Date: Tue, 19 Dec 2006 22:19:22 +0100
Message-ID: <200612192219.22871.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50181 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933020AbWLSVZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Only remove some useless cast ...

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:05:46.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:06:38.000000000 +0100
@@ -1134,7 +1134,7 @@
        if (ACPI_FAILURE(status))
                printk(KERN_WARNING "  Couldn't get the DSDT table header\n");
        else
-               asus_info = (struct acpi_table_header *)dsdt.pointer;
+               asus_info = dsdt.pointer;

        /* We have to write 0 on init this far for all ASUS models */
        if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
@@ -1156,7 +1156,7 @@
         * asus_model_match() and try something completely different.
         */
        if (buffer.pointer) {
-               model = (union acpi_object *)buffer.pointer;
+               model = buffer.pointer;
                switch (model->type) {
                case ACPI_TYPE_STRING:
                        string = model->string.pointer;
@@ -1252,8 +1252,7 @@
        printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
               ASUS_ACPI_VERSION);

-       hotk =
-           (struct asus_hotk *)kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
+       hotk = kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
        if (!hotk)
                return -ENOMEM;
        memset(hotk, 0, sizeof(struct asus_hotk));

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
