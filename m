From: Pavel Machek <pavel@ucw.cz>
Subject: Re: slow susped to disk
Date: Mon, 3 Apr 2006 11:47:16 +0200
Message-ID: <20060403094716.GC12475@elf.ucw.cz>
References: <4430E44B.7070003@triumf.ca> <200604031128.02974.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61117 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751697AbWDCJr3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 05:47:29 -0400
Content-Disposition: inline
In-Reply-To: <200604031128.02974.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zaher Salman <zaher@triumf.ca>, linux-acpi@vger.kernel.org

Hi!

> > I upgraded the kernel from 2.6.15 to 2.6.16 on my presario 2100. Both 
> > kernels were compiled with the similar configuration files. Anyway I 
> > found that suspend to disk (and resume) is much slower on 2.6.16 
> > compared to 2.6.15. Any idea for why that might happen or how can I 
> > speed it up? There is also a big difference when suspending with the 
> > laptop plugged or not..
> 
> This is because the size of the suspend image is now greater than
> for 2.6.15.
> 
> There's the /sys/power/image_size knob that controls the size of the image.
> If you set it to 0 (eg. by echo 0 > /sys/power/image_size as root), the
> 2.6.15 behavior should be restored.  However, if you set image_size > 0
> it should improve the system responsiveness after resume.
> 
> Please refer to Documentation/power/interface.txt in the kernel tree for
> details.

If you don't mind, I have added it to the FAQ.

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 55e0006..3fcec52 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -396,4 +396,17 @@ mounted filesystem.  With USB that's tru
 The safest thing is to unmount all USB-based filesystems before suspending
 and remount them after resuming.
 
-
+Q: I upgraded the kernel from 2.6.15 to 2.6.16. Both kernels were
+compiled with the similar configuration files. Anyway I found that
+suspend to disk (and resume) is much slower on 2.6.16 compared to
+2.6.15. Any idea for why that might happen or how can I speed it up?
+
+A: This is because the size of the suspend image is now greater than
+for 2.6.15 (by saving more data we can get more responsive system
+after resume).
+
+There's the /sys/power/image_size knob that controls the size of the
+image.  If you set it to 0 (eg. by echo 0 > /sys/power/image_size as
+root), the 2.6.15 behavior should be restored.  If it is still too
+slow, take a look at suspend.sf.net -- userland suspend is faster and
+supports LZF compression to speed it up further.


-- 
Picture of sleeping (Linux) penguin wanted...
