From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Mon, 4 May 2015 17:40:37 +0200
Message-ID: <20150504154037.GE3829@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150428143009.GA98296@redhat.com>
 <20150428145548.GE19025@pd.tnic>
 <20150428153521.GE98296@redhat.com>
 <20150428162229.GH19025@pd.tnic>
 <20150428184428.GF98296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43290 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbbEDPkv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 May 2015 11:40:51 -0400
Content-Disposition: inline
In-Reply-To: <20150428184428.GF98296@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-edac <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Tue, Apr 28, 2015 at 02:44:28PM -0400, Don Zickus wrote:
> RAS doesn't go through the legacy ports (ie get_nmi_reason()).  Instead it
> triggers the external NMI through a different bit (ioapic I think).

Well, I see it getting registered with __register_nmi_handler() which
adds it to the NMI_LOCAL type, i.e., ghes_notify_nmi() gets called by

default_do_nmi
|-> nmi_handle(NMI_LOCAL, regs, b2b);

AFAICT.

Which explains also the issue we were seeing as that handler is called
on each NMI, even when the machine is running a perf workload.

> The nmi code has no idea what io_remap'ed address apei is using to map its
> error handling register that GHES uses.  Unlike the legacy port which is
> always port 0x61.
> 
> So, with NMI being basically a shared interrupt, with no ability to discern
> who sent the interrupt (and even worse no ability to know how _many_ were sent as
> the NMI is edge triggered instead of level triggered).  As a result we rely
> on the NMI handlers to talk to their address space/registers to determine if
> they were they source of the interrupt.

I was afraid it would be something like that. We probably should poke hw
people to extend that NMI fun so that we can know who caused it.

<snip stuff I agree with>

> Anyway, any ideas or thoughts for improvement are always welcomed. :-)

Yeah, I'm afraid without hw support, that won't be doable. We need the
hw to tell us who caused the NMI. Otherwise we'll be round-robining
(:-)) through handlers like nuts.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
