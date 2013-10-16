From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 0/9] Extended H/W error log driver
Date: Wed, 16 Oct 2013 20:11:17 +0200
Message-ID: <20131016181117.GP13608@pd.tnic>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <20131016160550.GG13608@pd.tnic>
 <20131016125646.7141b580@gandalf.local.home>
 <20131016180038.GO13608@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131016180038.GO13608@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2013 at 08:00:38PM +0200, Borislav Petkov wrote:
> Right, the only difference I can see is that include/ras/ras_event.h
> doesn't have those below:
> 
> #undef TRACE_INCLUDE_PATH
> #undef TRACE_INCLUDE_FILE
> #define TRACE_INCLUDE_PATH .
> 
> Perhaps that is the problem?
> 
> Gong, what is exactly the issue you're observing?

Ok, I think I know what the issue is:

Gong has

diff --git a/drivers/acpi/extlog_trace.c b/drivers/acpi/extlog_trace.c
new file mode 100644
index 000000000000..28640807fb09
--- /dev/null
+++ b/drivers/acpi/extlog_trace.c
@@ -0,0 +1,107 @@
+#include <linux/export.h>
+#include <linux/dmi.h>
+#include "extlog_trace.h"
+
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH ../../include/ras
+#include <ras/ras_event.h>

for the ras tracepoint although this is done already in
drivers/edac/edac_mc.c

Gong, can you try moving the CREATE_TRACE_POINTS line to a new file -
arch/x86/ras/ras.c and define it there and not anywhere else, i.e. move
it away from edac_mc.c. Does that help?

Also, see Documentation/trace/tracepoints.txt for more info.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
