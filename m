From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: build failure after merge of the acpi tree
Date: Sat, 4 Dec 2010 00:51:23 +0100
Message-ID: <201012040051.23769.rjw@sisk.pl>
References: <20101202112239.c7d05518.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101202112239.c7d05518.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Len Brown <lenb@kernel.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 02, 2010, Stephen Rothwell wrote:
> Hi Len,
> 
> After merging the acpi tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from drivers/video/output.c:25:
> include/linux/video_output.h: In function 'video_output_register':
> include/linux/video_output.h:49: error: implicit declaration of function 'ERR_PTR'
> include/linux/video_output.h:49: warning: return makes pointer from integer without a cast
> In file included from drivers/video/output.c:27:
> include/linux/err.h: At top level:
> include/linux/err.h:22: error: conflicting types for 'ERR_PTR'
> include/linux/video_output.h:49: note: previous implicit declaration of 'ERR_PTR' was here
> drivers/video/output.c:84: error: redefinition of 'video_output_register'
> include/linux/video_output.h:44: note: previous definition of 'video_output_register' was here
> drivers/video/output.c:114: error: redefinition of 'video_output_unregister'
> include/linux/video_output.h:51: note: previous definition of 'video_output_unregister' was here
> 
> Caused by commit 16d21716c8849c3283d1b9e590e6fe8d1966f4b7 ("ACPI: video:
> fix build for VIDEO_OUTPUT_CONTROL=n").  See Rule 1 in
> Documentation/SubmitChecklist.
> 
> I have used the version of the acpi tree from next-20101201 for today.

Something like this will help, perhaps:

---
 include/linux/video_output.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/include/linux/video_output.h
===================================================================
--- linux-2.6.orig/include/linux/video_output.h
+++ linux-2.6/include/linux/video_output.h
@@ -23,6 +23,7 @@
 #ifndef _LINUX_VIDEO_OUTPUT_H
 #define _LINUX_VIDEO_OUTPUT_H
 #include <linux/device.h>
+#include <linux/err.h>
 struct output_device;
 struct output_properties {
 	int (*set_state)(struct output_device *);
