From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Mon, 27 Apr 2015 22:23:50 +0200
Message-ID: <20150427202349.GM28871@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150401134913.GB18523@pd.tnic>
 <alpine.LNX.2.00.1504231038470.3695@pobox.suse.cz>
 <20150423085939.GC28340@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F32A6446B@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32A6446B@ORSMSX114.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>, Jiri Kosina <jkosina@suse.cz>, linux-edac <linux-edac@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Zheng, Lv" <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 23, 2015 at 06:00:15PM +0000, Luck, Tony wrote:
> > I think we should apply this.
> >
> > Here's why: nothing in the ghes_notify_nmi() handler does CPU-specific
> > accesses
> 
> This looks to be true.
> 
> > Tony, objections?
> 
> No objections.

Thanks, queued for 4.2, pending one last test I'm doing on a machine
which says

[   24.332560] INFO: NMI handler (ghes_notify_nmi) took too long to run: 3.265 msecs
[   24.332567] INFO: NMI handler (ghes_notify_nmi) took too long to run: 5.946 msecs
[   24.332568] INFO: NMI handler (ghes_notify_nmi) took too long to run: 5.948 msecs

during boot.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
