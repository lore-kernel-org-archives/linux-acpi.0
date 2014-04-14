From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Mon, 14 Apr 2014 12:46:46 +0200
Message-ID: <20140414104646.GB3663@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
 <20140409194654.GR6529@pd.tnic>
 <20140414032058.GA22584@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55641 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbaDNKrA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2014 06:47:00 -0400
Content-Disposition: inline
In-Reply-To: <20140414032058.GA22584@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Sun, Apr 13, 2014 at 11:20:58PM -0400, Chen, Gong wrote:
> I don't use a explicit menu for RAS because I'm not sure if it is
> worth to add such a *heavy hammer* in the kernel tree.

We're going to be adding more stuff to it so a full menu will come
sooner rather than later.

> Maybe some drivers don't call trace_mc_event directly/indirectly, but
> edac_mc.c is the core of EDAC and must exist before any other drivers
> are loaded, which means whether the drivers call trace_mc_event or
> not, the trace interface in edac_mc should be there in advance. Do I
> miss something?

No, you're fine. I missed the fact that you've moved the mc_event
tracepoint, sorry.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
