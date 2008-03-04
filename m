From: akpm@linux-foundation.org
Subject: [patch (for 2.6.25?) 2/3] drivers/acpi/asus_acpi.c: correct use of ! and &
Date: Tue, 04 Mar 2008 15:00:13 -0800
Message-ID: <200803042300.m24N0DBP001546@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43047 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765380AbYCDXBH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:01:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, julia@diku.dk, kronos.it@gmail.com, len.brown@intel.com, maxime@tralhalla.org, trenn@suse.de

From: Julia Lawall <julia@diku.dk>

In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
involved converting !x & y to !(x & y).  The code below shows the same
pattern, and thus should perhaps be fixed in the same way.

This is not tested and clearly changes the semantics, so it is only
something to consider.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@ expression E1,E2; @@
(
  !E1 & !E2
|
- !E1 & E2
+ !(E1 & E2)
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Luca Tettamanti <kronos.it@gmail.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Maxime Austruy <maxime@tralhalla.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/asus_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-correct-use-of-and drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-correct-use-of-and
+++ a/drivers/acpi/asus_acpi.c
@@ -610,7 +610,7 @@ write_led(const char __user * buffer, un
 	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
 
 	if (invert)		/* invert target value */
-		led_out = !led_out & 0x1;
+		led_out = !led_out;
 
 	if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
 		printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
_
