From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS
 area
Date: Thu, 16 Feb 2017 11:32:15 +0100
Message-ID: <20170216103215.ppo2oe7byql5r6ve@pd.tnic>
References: <20170214020143.29713-1-ying.huang@intel.com>
 <4305135.N5b65JQej5@aspire.rjw.lan>
 <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
 <87fujea0wo.fsf@yhuang-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753785AbdBPKkI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Feb 2017 05:40:08 -0500
Content-Disposition: inline
In-Reply-To: <87fujea0wo.fsf@yhuang-dev.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 16, 2017 at 06:24:39PM +0800, Huang, Ying wrote:
> The NVS area is excluded when request the resources, because the NVS
> area has been marked as busy already.  But the whole BERT memory area is
> mapped, so we can read from it.

So you're saying the NVS area is part of the BERT area and we can access
the whole range?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
