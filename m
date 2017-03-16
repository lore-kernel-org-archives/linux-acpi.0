From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] acpi: fix incompatibility with mcount-based function graph tracing
Date: Thu, 16 Mar 2017 08:56:28 -0500
Message-ID: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdCPOUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 10:20:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>

Paul Menzel reported a warning:

  WARNING: CPU: 0 PID: 774 at /build/linux-ROBWaj/linux-4.9.13/kernel/trace/trace_functions_graph.c:233 ftrace_return_to_handler+0x1aa/0x1e0
  Bad frame pointer: expected f6919d98, received f6919db0
    from func acpi_pm_device_sleep_wake return to c43b6f9d

The warning means that function graph tracing is broken for the
acpi_pm_device_sleep_wake() function.  That's because the acpi Makefile
unconditionally sets the '-Os' gcc flag to optimize for size.  That's an
issue because mcount-based function graph tracing is incompatible with
'-Os' on x86, thanks to the following gcc bug:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42109

I have another patch pending which will ensure that mcount-based
function graph tracing is never used with CONFIG_CC_OPTIMIZE_FOR_SIZE on
x86.

But this patch is needed in addition to that one because the ACPI
Makefile overrides that config option for no apparent reason.  It has
had this flag since the beginning of git history, and there's no related
comment, so I don't know why it's there.  As far as I can tell, there's
no reason for it to be there.  The appropriate behavior is for it to
honor CONFIG_CC_OPTIMIZE_FOR_{SIZE,PERFORMANCE} like the rest of the
kernel.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 drivers/acpi/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index a391bbc..d94f92f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the Linux ACPI interpreter
 #
 
-ccflags-y			:= -Os
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 #
-- 
2.7.4

