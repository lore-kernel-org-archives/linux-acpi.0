From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Thu, 23 Apr 2015 10:59:39 +0200
Message-ID: <20150423085939.GC28340@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150401134913.GB18523@pd.tnic>
 <alpine.LNX.2.00.1504231038470.3695@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42269 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbbDWI7t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2015 04:59:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1504231038470.3695@pobox.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Thu, Apr 23, 2015 at 10:39:58AM +0200, Jiri Kosina wrote:
> Three weeks have passed, therefore I find this an appropriate time for a 
> friendly ping :)
> 
> Rafael? Naoya? Huang?
> 
> This fixes a contention spinlock problem in NMI observed on a real HW, so 
> it would be really nice to have it fixed.

I think we should apply this.

Here's why: nothing in the ghes_notify_nmi() handler does CPU-specific
accesses. It iterates over the list of ghes sources which do NMI
notification but those sources are the *same* regardless of which core
does the access as their addresses are per-source, i.e. in that

	struct acpi_generic_address error_status_address;

thing.

And it is a safe bet to say that all that error information is
serialized in the firmware for the error source to consume.

So I'm going to route this through the RAS tree unless Rafael wants to
take it.

Ok?

Tony, objections?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
