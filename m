From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 9/9] asus_acpi: Invert read of wled proc file to show correct state of LED
Date: Thu, 05 Jan 2006 22:31:01 -0800
Message-ID: <200601060631.k066VEgJ008147@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>

User with this equipment stated that writes to this file worked correctly,
but that reads were showing inverted state (1 for off, 0 for on). 
Following the same style for reads, introduced an invert flag to read_led,
and used it for wled.

Signed-off-by: Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/asus_acpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-invert-read-of-wled-proc-file-to-show-correct drivers/acpi/asus_acpi.c
--- devel/drivers/acpi/asus_acpi.c~asus_acpi-invert-read-of-wled-proc-file-to-show-correct	2006-01-05 22:28:55.000000000 -0800
+++ devel-akpm/drivers/acpi/asus_acpi.c	2006-01-05 22:28:55.000000000 -0800
@@ -490,13 +490,13 @@ proc_read_info(char *page, char **start,
  */
 
 /* Generic LED functions */
-static int read_led(const char *ledname, int ledmask)
+static int read_led(const char *ledname, int ledmask, int invert)
 {
 	if (ledname) {
 		int led_status;
 
 		if (read_acpi_int(NULL, ledname, &led_status))
-			return led_status;
+			return (invert) ? !led_status : led_status;
 		else
 			printk(KERN_WARNING "Asus ACPI: Error reading LED "
 			       "status\n");
@@ -552,7 +552,7 @@ proc_read_mled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->mled_status, MLED_ON));
+		       read_led(hotk->methods->mled_status, MLED_ON, 0));
 }
 
 static int
@@ -570,7 +570,7 @@ proc_read_wled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->wled_status, WLED_ON));
+		       read_led(hotk->methods->wled_status, WLED_ON, 1));
 }
 
 static int
@@ -588,7 +588,7 @@ proc_read_tled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->tled_status, TLED_ON));
+		       read_led(hotk->methods->tled_status, TLED_ON, 0));
 }
 
 static int
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
