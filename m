From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Date: Fri, 25 Jul 2003 10:46:38 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F2142CE.4090608@prairienet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Wawrzyniak <gan-28sE0Wxkf/LCXR85Y8Hu3Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Please revert the following item from Ben Collins' "drivers/* strlcpy 
conversions" patch dated 2003-May-26.

The strlcpy function requires a zero-terminated string, which is not a 
valid assumption for the code in question.  I suggest that Ben review 
all such modifications he made to the kernel for similar errors.  It's 
quite annoying to have someone add bugs to your driver while you're not 
looking.  Either notify the maintainer of your patch or don't make mistakes.

Another gripe I have is that bitkeeper user "bcollins" does not have a 
valid email address.

-John Belmonte


Item to be REVERTED:

--- 1.9/drivers/acpi/toshiba_acpi.c	Mon May 19 10:57:16 2003
+++ 1.10/drivers/acpi/toshiba_acpi.c	Sun May 25 17:00:00 2003
@@ -108,8 +108,7 @@
  	int result;
  	char* str2 = kmalloc(n + 1, GFP_KERNEL);
  	if (str2 == 0) return 0;
-	strncpy(str2, str, n);
-	str2[n] = 0;
+	strlcpy(str2, str, n);
  	va_start(args, format);
  	result = vsscanf(str2, format, args);
  	va_end(args);


References:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0267.html
http://linux-acpi.bkbits.net:8080/linux-acpi/diffs/drivers/acpi/toshiba_acpi.c-6aIl+mEMC3M@public.gmane.org?nav=index.html|src/|src/drivers|src/drivers/acpi|hist/drivers/acpi/toshiba_acpi.c


-- 
http:// if   l .o  /
