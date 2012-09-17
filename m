From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] x86, acpi: Make acpi_processor_ffh_cstate_probe() use
 a work item instead of work_on_cpu()
Date: Mon, 17 Sep 2012 14:37:38 -0700
Message-ID: <20120917213738.GM18677@google.com>
References: <20120824002643.GA21325@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62848 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab2IQVhn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Sep 2012 17:37:43 -0400
Content-Disposition: inline
In-Reply-To: <20120824002643.GA21325@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 23, 2012 at 05:26:43PM -0700, Tejun Heo wrote:
> Workqueue is guaranteed to be available on the target CPU by the time
> acpi_processor_ffh_cstate_probe() is invoked for it.  There's no
> reason to use costly work_on_cpu() which involves creating and tearing
> down a full kthread on each invocation to execute the probing function
> on the target CPU.  Use a work item instead.
> 
> Tested and works as expected.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Please forget about this patch (doesn't seem like it has been applied
yet).  Planning on reimplementing work_on_cpu() using system_wq
instead.

Thanks.

-- 
tejun
