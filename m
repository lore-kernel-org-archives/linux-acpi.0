From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Tue, 15 Apr 2014 20:05:54 +0200
Message-ID: <20140415180553.GF4826@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140415091944.GB29868@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51509 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbaDOSF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2014 14:05:56 -0400
Content-Disposition: inline
In-Reply-To: <20140415091944.GB29868@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Tue, Apr 15, 2014 at 05:19:44AM -0400, Chen, Gong wrote:
> > Why the DMI handle? Why not say: "unable to find location" or "location
> > not present in DMI" or something more user-friendly.
> In essential, I use the suggestion from Tony Luck. DMI handle can't be found
> so I just list the original info for it. Maybe I can merge them into one.

Yep. Make it user-friendly while showing the original info pls.

> > > +#define CPER_REC_LEN				512
> > 
> > How did we come up with this? Some spec? 512 chars for an error record?
> > That's a bit too much in my book.
> > 
> Because 128 is not enough once all fields in error record exist, and 256 looks
> a little bit tough so I choose a bigger value. No spec for it. I just hope

Tough? How? Not enough?

> it can contain everything.

Pls add a comment over this definition to state why we've chosen this
number exactly.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
