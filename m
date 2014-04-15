From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Tue, 15 Apr 2014 20:02:59 +0200
Message-ID: <20140415180259.GE4826@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140414140514.GD3663@pd.tnic>
 <20140415092442.GC29868@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51463 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbaDOSDB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2014 14:03:01 -0400
Content-Disposition: inline
In-Reply-To: <20140415092442.GC29868@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Tue, Apr 15, 2014 at 05:24:42AM -0400, Chen, Gong wrote:
> That's why I export this spinlock because in another patch(3/5) I use
> this spinlock to surround whole handling procedure of tracepoint.
>
> If exporting this spinlock directly is too ugly, I can use an inline
> function to get the same purpose.

You still haven't answered...

> > So you have to think about all possible call paths ending here and
> > *then* introduce proper sync.
^^^^^^^^^^^^^

this question. Do we even *need* the locking? If so, why? What paths are
going to end there?

The answers to those questions will give you the correct synchronization.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
