From: akpm@linux-foundation.org
Subject: [patch 24/26] acer-wmi: remove non-used acer_quirks struct definition
Date: Tue, 20 Jul 2010 15:19:54 -0700
Message-ID: <201007202219.o6KMJsrC021095@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, carlos@strangeworlds.co.uk, mjg@redhat.com, trenn@suse.de
List-Id: linux-acpi@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>

Remove non-used acer_quirks struct definition.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acer-wmi.c |   11 -----------
 1 file changed, 11 deletions(-)

diff -puN drivers/platform/x86/acer-wmi.c~acer-wmi-remove-non-used-acer_quirks-struct-definition drivers/platform/x86/acer-wmi.c
--- a/drivers/platform/x86/acer-wmi.c~acer-wmi-remove-non-used-acer_quirks-struct-definition
+++ a/drivers/platform/x86/acer-wmi.c
@@ -50,17 +50,6 @@ MODULE_LICENSE("GPL");
 #define ACER_INFO KERN_INFO ACER_LOGPREFIX
 
 /*
- * The following defines quirks to get some specific functions to work
- * which are known to not be supported over ACPI-WMI (such as the mail LED
- * on WMID based Acer's)
- */
-struct acer_quirks {
-	const char *vendor;
-	const char *model;
-	u16 quirks;
-};
-
-/*
  * Magic Number
  * Meaning is unknown - this number is required for writing to ACPI for AMW0
  * (it's also used in acerhk when directly accessing the BIOS)
_
