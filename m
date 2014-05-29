From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7 v6] trace, RAS: Add eMCA trace event interface
Date: Thu, 29 May 2014 12:35:39 +0200
Message-ID: <20140529103539.GB21718@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1401247938-22125-1-git-send-email-gong.chen@linux.intel.com>
 <1401247938-22125-2-git-send-email-gong.chen@linux.intel.com>
 <20140528112832.5f83c66b@gandalf.local.home>
 <20140528163452.GF17196@pd.tnic>
 <20140528125625.6f6dcf7f@gandalf.local.home>
 <20140529074345.GA23484@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55797 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbaE2Kfq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 May 2014 06:35:46 -0400
Content-Disposition: inline
In-Reply-To: <20140529074345.GA23484@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, May 29, 2014 at 03:43:45AM -0400, Chen, Gong wrote:
> On Wed, May 28, 2014 at 12:56:25PM -0400, Steven Rostedt wrote:
> > My concern is passing in a large string and wasting a lot of the ring
> > buffer space. The max you can hold per event is just under a page size
> > (4k). And all these strings add up. If it happens to be 512bytes, then
> > you end up with one event per page.
> I just don't understand why you say wasting memory. I just pass
> a char * not a string array.

And this char * points to where?

+               __string(dimm_info, dimm_info)
+               __string(mem_loc, mem_loc)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
