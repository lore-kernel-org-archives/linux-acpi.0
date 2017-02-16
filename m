From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS
 area
Date: Thu, 16 Feb 2017 10:52:30 +0100
Message-ID: <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
References: <20170214020143.29713-1-ying.huang@intel.com>
 <4305135.N5b65JQej5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40055 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753403AbdBPJwu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Feb 2017 04:52:50 -0500
Content-Disposition: inline
In-Reply-To: <4305135.N5b65JQej5@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Huang, Ying" <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 16, 2017 at 12:42:00AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 14, 2017 10:01:13 AM Huang, Ying wrote:
> > From: Huang Ying <ying.huang@intel.com>
> > 
> > It was reported that some firmware will use ACPI NVS area for BERT
> > address range.  This will cause resources conflict because the ACPI
> > NVS area is marked as busy already.  Fix this via excluding ACPI NVS
> > area when requesting IO resources for BERT.
> > 
> > Reported-and-tested-by: Hans Kristian Rosbach <hansr@raskesider.no>
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Boris, what do you think?

Lemme see, so the BERT is for hw errors which have happened during the
previous boot and the machine couldn't handle them. So they do get saved
in some mem in the fw for inspection during the next boot.

And "some firmware" has decided to write them into non-volatile storage
- because you should never ever forget those errors! :-)

And I don't understand the "fix" here: we're excluding the NVS area when
mapping the BERT table but then how are we supposed to read those errors
from there?

Or am I missing something obvious?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
