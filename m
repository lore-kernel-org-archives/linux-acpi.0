From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Thu, 6 Mar 2014 12:18:52 +0100
Message-ID: <20140306111852.GA24629@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33371 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbaCFLS7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2014 06:18:59 -0500
Content-Disposition: inline
In-Reply-To: <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Tue, Mar 04, 2014 at 04:23:16AM -0500, Chen, Gong wrote:
> To avoid the confuision of usage for RAS related trace event, add
> an unified RAS trace event stub.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/edac/edac_mc.c    |  3 ---
>  kernel/trace/Makefile     |  1 +
>  kernel/trace/ras-traces.c | 12 ++++++++++++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/trace/ras-traces.c
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 33edd67..28c1695 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -33,9 +33,6 @@
>  #include <asm/edac.h>
>  #include "edac_core.h"
>  #include "edac_module.h"
> -
> -#define CREATE_TRACE_POINTS
> -#define TRACE_INCLUDE_PATH ../../include/ras
>  #include <ras/ras_event.h>
>  
>  /* lock to memory controller's control array */
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 1378e84..167193a 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -52,6 +52,7 @@ endif
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
>  obj-$(CONFIG_KPROBE_EVENT) += trace_kprobe.o
> +obj-$(CONFIG_TRACEPOINTS) += ras-traces.o

Actually I was thinking of slowly concentrating all the RAS stuff into
arch/x86/ras/.

Just add arch/x86/ras/trace.c instead please.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
