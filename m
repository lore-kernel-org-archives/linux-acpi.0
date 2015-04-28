From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 18:22:29 +0200
Message-ID: <20150428162229.GH19025@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150428143009.GA98296@redhat.com>
 <20150428145548.GE19025@pd.tnic>
 <20150428153521.GE98296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46103 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965916AbbD1QWs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 12:22:48 -0400
Content-Disposition: inline
In-Reply-To: <20150428153521.GE98296@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-edac <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Tue, Apr 28, 2015 at 11:35:21AM -0400, Don Zickus wrote:
> Your solution seems much simpler. :-)

... and I love simpler :-)

> I followed up in another email stating I mis-spoke.  I forgot this still
> uses the NMI_LOCAL shared NMI.  So every perf NMI, will also call the GHES
> handler to make sure NMIs did not piggy back each other.  So I don't believe

And this is something we should really fix - perf and RAS should
not have anything to do with each other. But I don't know the NMI
code to even have an idea how. I don't even know whether we can
differentiate NMIs, hell, I can't imagine the hardware giving us a
different NMI reason through get_nmi_reason(). Maybe that byte returned
from NMI_REASON_PORT is too small and hangs on too much legacy crap to
even be usable. Questions over questions...

> the NMI reason lock is called a majority of the time (except when the NMI is
> swallowed, but that is under heavy perf load...).

..

> We both agree the mechanics of the spinlock are overkill here and cause much
> cache contention.  Simplifying it to just 'reads' and return removes most of
> the problem.

Right.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
