From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Wed, 29 Apr 2015 10:13:55 +0200
Message-ID: <20150429081355.GA5498@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
 <20150428135913.GD19025@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E880270FB3B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46820 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031044AbbD2IOP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 04:14:15 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880270FB3B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 29, 2015 at 12:49:59AM +0000, Zheng, Lv wrote:
> > > We absolutely want to use atomic_add_unless() because we get to save us
> > > the expensive
> > >
> > > 	LOCK; CMPXCHG
> > >
> > > if the value was already 1. Which is exactly what this patch is trying
> > > to avoid - a thundering herd of cores CMPXCHGing a global variable.
> > 
> > IMO, on most architectures, the "cmp" part should work just like what you've done with "if".
> > And on some architectures, if the "xchg" doesn't happen, the "cmp" part even won't cause a pipe line hazard.

Even if CMPXCHG is being split into several microops, they all still
need to flow down the pipe and require resources and tracking. And you
only know at retire time what the CMP result is and can "discard" the
XCHG part. Provided the uarch is smart enough to do that.

This is probably why CMPXCHG needs 5,6,7,10,22,... cycles depending on
uarch and vendor, if I can trust Agner Fog's tables. And I bet those
numbers are best-case only and in real-life they probably tend to fall
out even worse.

CMP needs only 1. On almost every uarch and vendor. And even that cycle
probably gets hidden with a good branch predictor.

> If you man the LOCK prefix, I understand now.

And that makes several times worse: 22, 40, 80, ... cycles.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
