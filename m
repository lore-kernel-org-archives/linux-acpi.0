From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 1/1] acpi: apei: Enable APEI multiple GHES source to
 share an single external IRQ
Date: Fri, 21 Jul 2017 08:00:07 +0200
Message-ID: <20170721060007.GA26714@nazgul.tnic>
References: <1500586563-7088-1-git-send-email-lho@apm.com>
 <1500586563-7088-2-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44773 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbdGUGAS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 02:00:18 -0400
Content-Disposition: inline
In-Reply-To: <1500586563-7088-2-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: msalter@redhat.com, rafael@kernel.org, tbaicar@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@apm.com

On Thu, Jul 20, 2017 at 02:36:03PM -0700, Loc Ho wrote:
> This patch allows APEI generic error source table with external

"This patch" in a commit message is tautologically redundant.

> IRQ to share a single IRQ.

Because? More background please.

> Co-authored-by: Tuan Phan <tphan@apm.com>

I guess an invented tag is fine. What you can also do is say in free
text in the commit message that Tuan has helped.

> Signed-off-by: Loc Ho <lho@apm.com>
> ---

...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
