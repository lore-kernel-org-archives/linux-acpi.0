From: Pavel Machek <pavel@ucw.cz>
Subject: suspend_s4bios needs asmlinkage, too
Date: Fri, 2 Apr 2004 14:46:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040402124642.GA1005@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: Andrew Morton <akpm@zip.com.au>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

Subject says it pretty much all, otherwise it will crash during S4bios
suspend with regparm=3. Please apply,

								Pavel
--- tmp/linux/drivers/acpi/hardware/hwsleep.c	2004-03-11 18:10:48.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-03-11 18:16:06.000000000 +0100
@@ -394,7 +394,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status asmlinkage
 acpi_enter_sleep_state_s4bios (
 	void)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
