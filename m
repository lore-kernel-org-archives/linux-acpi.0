From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Mon, 14 Apr 2014 16:05:14 +0200
Message-ID: <20140414140514.GD3663@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42833 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168AbaDNOF2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2014 10:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20140414133924.GC3663@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Mon, Apr 14, 2014 at 03:39:24PM +0200, Borislav Petkov wrote:
> Definitely a bad idea to export a spinlock. If all you need is to sync
> against multiple callers of cper_mem_err_location(), simply grab that
> spinlock in the function itself, without exporting it.
> 
> > +
> > +static char mem_location[CPER_REC_LEN];
> > +static char dimm_location[CPER_REC_LEN];

In thinking about this more, even with the proper synchronization,
cper_dimm_err_location() returns a pointer to this dimm_location string.
Now, imagine what happens if another caller grabs the lock and enters
cper_dimm_err_location() while dimm_location is still being accessed by
the tracepoint or the previous caller of cper_dimm_err_location...

IOW, you either need a synchronization at a higher level so that dumping
of dimm locations can be serialized or the higher callers (interrupt
handlers, etc) already give you that synchronization.

So you have to think about all possible call paths ending here and
*then* introduce proper sync.

Oh, and saying "No functional changes." in the commit message is a bit
misleading, don't you think?

:-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
