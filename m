From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS area
Date: Fri, 17 Feb 2017 08:31:12 +0800
Message-ID: <8737fdaca7.fsf@yhuang-dev.intel.com>
References: <20170214020143.29713-1-ying.huang@intel.com>
        <4305135.N5b65JQej5@aspire.rjw.lan>
        <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
        <87fujea0wo.fsf@yhuang-dev.intel.com>
        <20170216103215.ppo2oe7byql5r6ve@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33630 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdBQAbQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Feb 2017 19:31:16 -0500
In-Reply-To: <20170216103215.ppo2oe7byql5r6ve@pd.tnic> (Borislav Petkov's
        message of "Thu, 16 Feb 2017 11:32:15 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Huang, Ying" <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:

> On Thu, Feb 16, 2017 at 06:24:39PM +0800, Huang, Ying wrote:
>> The NVS area is excluded when request the resources, because the NVS
>> area has been marked as busy already.  But the whole BERT memory area is
>> mapped, so we can read from it.
>
> So you're saying the NVS area is part of the BERT area and we can access
> the whole range?

I am not sure whether the NVS area is a part of the BERT area, but
apparently they are overlapped in some way.  We will access the whole
BERT area here via ioremap the whole range.

Best Regards,
Huang, Ying
