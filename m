From: akpm@linux-foundation.org
Subject: [patch 04/26] acerhdf: driver didn't verify the pointers in which it got product information
Date: Tue, 20 Jul 2010 15:19:33 -0700
Message-ID: <201007202219.o6KMJXVC021003@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rkc@chromium.org, andi@lisas.de, lenb@kernel.org, mjg@redhat.com, peter@piie.net, petkovbb@gmail.com
List-Id: linux-acpi@vger.kernel.org

From: Rahul Chaturvedi <rkc@chromium.org>

Driver didn't verify the pointers in which it got product information back
from DMI; on QEMU one of the pointers came back null, which made the
driver crash and subsequently caused a kernel panic.

Signed-off-by: Rahul Chaturvedi <rkc@chromium.org>
Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-driver-didnt-verify-the-pointers-in-which-it-got-product-information drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-driver-didnt-verify-the-pointers-in-which-it-got-product-information
+++ a/drivers/platform/x86/acerhdf.c
@@ -524,6 +524,10 @@ static int acerhdf_check_hardware(void)
 	version = dmi_get_system_info(DMI_BIOS_VERSION);
 	product = dmi_get_system_info(DMI_PRODUCT_NAME);
 
+	if (!vendor || !version || !product) {
+		pr_err("error getting hardware information\n");
+		return -EINVAL;
+	}
 
 	pr_info("Acer Aspire One Fan driver, v.%s\n", DRV_VER);
 
_
