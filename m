From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/7 v3] trace, AER: Move trace into unified interface
Date: Wed, 21 May 2014 12:19:03 +0200
Message-ID: <20140521101903.GC21205@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-3-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58728 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbaEUKTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 06:19:25 -0400
Content-Disposition: inline
In-Reply-To: <1400142646-10127-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, May 15, 2014 at 04:30:41AM -0400, Chen, Gong wrote:
> AER uses a separate trace interface by now. To make it
> consistent, move it into unified RAS trace interface.
> 
> v3 -> v2: change dependency rule of RAS_TRACE.
> v2 -> v1: remove unnecessary dependency in drivers/ras/Kconfig.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/pci/pcie/aer/Kconfig           |  1 +
>  drivers/pci/pcie/aer/aerdrv_errprint.c |  4 +-
>  include/ras/ras_event.h                | 64 ++++++++++++++++++++++++++++
>  include/trace/events/ras.h             | 77 ----------------------------------

Ok, I don't understand: all the rest of the kernel holds tracepoints in
include/trace/events/. Why are you moving this at all?

Why can't the new extlog tracepoint in patch 5 be added to
include/trace/events/ras.h too?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
