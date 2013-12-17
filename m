From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Tue, 17 Dec 2013 16:17:22 +0100
Message-ID: <20131217151722.GF30592@pd.tnic>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
 <20131216141906.GC4922@pd.tnic>
 <20131216143934.GB8397@gchen.bj.intel.com>
 <20131216175551.GD9683@pd.tnic>
 <20131217053451.GB11278@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56526 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab3LQPR1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Dec 2013 10:17:27 -0500
Content-Disposition: inline
In-Reply-To: <20131217053451.GB11278@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Tue, Dec 17, 2013 at 12:34:52AM -0500, Chen, Gong wrote:
> It is a copy from one integer array to another one(from old ID array
> to new bigger ID array), so I can't use a simple evaluation to get
> this goal.

Ok, I see.

Please add this information I spent a couple of days asking you about to
the commit message. Something along the lines of this one:

"erst record id cache is implemented in the memory to increase the
access speed via caching ERST content, so it doesn't matter with
firmware access."

which would explain your last hunk changing the memcpy to a simple
assignment. It is obvious that it is not that trivial information so
documenting it for the future is very important.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
