From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 9/9] ACPI / trace: Add trace interface for eMCA driver
Date: Wed, 16 Oct 2013 19:29:20 +0200
Message-ID: <20131016172920.GN13608@pd.tnic>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <1381935366-11731-10-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381935366-11731-10-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2013 at 10:56:06AM -0400, Chen, Gong wrote:
> Use trace interface to elaborate all H/W error related
> information.
> 
> v2 -> v1: move trace interface into ras_event.h
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---

Just a nitpick below. Other than that:

Acked-by: Borislav Petkov <bp@suse.de>

> diff --git a/drivers/acpi/extlog_trace.h b/drivers/acpi/extlog_trace.h
> new file mode 100644
> index 0000000..67bb2c5
> --- /dev/null
> +++ b/drivers/acpi/extlog_trace.h
> @@ -0,0 +1,16 @@
> +#ifndef __DEBUG_EXTLOG_H
> +#define __DEBUG_EXTLOG_H
> +
> +#include <linux/cper.h>
> +
> +#ifdef CONFIG_EXTLOG_TRACE
> +extern void trace_mem_error(const uuid_le *fru_id, char *fru_text,
> +		u64 err_count, u32 severity, struct cper_sec_mem_err *mem);

Applying: ACPI / trace: Add trace interface for eMCA driver
CHECK: extern prototypes should be avoided in .h files
#265: FILE: drivers/acpi/extlog_trace.h:7:
+extern void trace_mem_error(const uuid_le *fru_id, char *fru_text,

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
