From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: [PATCH] Toshiba ACPI Extras 0.16
Date: Fri, 25 Jul 2003 19:28:17 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F21BD11.8060405@prairienet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040402020607080402020103"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040402020607080402020103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andy,

Recently there was a mass patch to the 2.5 kernel that tried to replace 
instances of strncpy with strlcpy.  In the case of my driver the 
substitution was not appropriate and causes end-user problems due to the 
resulting undefined memory access.  This change was made about 6 weeks 
ago without my knowledge, the result being that there are tainted copies 
of version 0.15 of the driver out there.

What I'd like to do is forget version 0.15 ever existed, so this patch 
reverts the change and increments the version.  I'd also like to 
increment the version in the 2.4 tree to keep things in sync, so I've 
got a patch ready for each tree.

Unfortunately I've complicated matters by already trying to submit a 
patch to Linus that reverts the change but doesn't increment the 
version.  I doubt he'll apply it, but if he does before you get to it 
then apply the 2.4 patch to the 2.5 tree to increment the version only.

Sorry for the trouble.

Regards,
-John


Changes:

     * Increment version because release 0.15 was tainted by a bad
       "strlcpy conversion" patch.




--------------040402020607080402020103
Content-Type: text/plain;
 name="toshiba_acpi_0.16-linux_2.6.0-test1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.16-linux_2.6.0-test1.patch"

--- toshiba_acpi.c.old	2003-07-25 18:40:52.000000000 -0400
+++ toshiba_acpi.c	2003-07-25 18:24:48.000000000 -0400
@@ -33,7 +33,7 @@
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.15"
+#define TOSHIBA_ACPI_VERSION	"0.16"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -108,7 +108,9 @@
 	int result;
 	char* str2 = kmalloc(n + 1, GFP_KERNEL);
 	if (str2 == 0) return 0;
-	strlcpy(str2, str, n);
+	/* NOTE: don't even _think_ about replacing this with strlcpy */
+	strncpy(str2, str, n);
+	str2[n] = 0;
 	va_start(args, format);
 	result = vsscanf(str2, format, args);
 	va_end(args);

--------------040402020607080402020103
Content-Type: text/plain;
 name="toshiba_acpi_0.16-linux_2.4.22-pre8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.16-linux_2.4.22-pre8.patch"

--- toshiba_acpi.c.old	2003-07-25 19:03:10.000000000 -0400
+++ toshiba_acpi.c	2003-07-25 18:24:48.000000000 -0400
@@ -33,7 +33,7 @@
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.15"
+#define TOSHIBA_ACPI_VERSION	"0.16"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -108,6 +108,7 @@
 	int result;
 	char* str2 = kmalloc(n + 1, GFP_KERNEL);
 	if (str2 == 0) return 0;
+	/* NOTE: don't even _think_ about replacing this with strlcpy */
 	strncpy(str2, str, n);
 	str2[n] = 0;
 	va_start(args, format);

--------------040402020607080402020103--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
