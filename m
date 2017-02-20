From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS area
Date: Mon, 20 Feb 2017 08:56:12 +0800
Message-ID: <87h93pvfwz.fsf@yhuang-dev.intel.com>
References: <20170214020143.29713-1-ying.huang@intel.com>
        <4305135.N5b65JQej5@aspire.rjw.lan>
        <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
        <87fujea0wo.fsf@yhuang-dev.intel.com>
        <20170216103215.ppo2oe7byql5r6ve@pd.tnic>
        <8737fdaca7.fsf@yhuang-dev.intel.com>
        <20170217100202.xi5x4lqdk6gqtfd5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbdBTA5A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Feb 2017 19:57:00 -0500
In-Reply-To: <20170217100202.xi5x4lqdk6gqtfd5@pd.tnic> (Borislav Petkov's
        message of "Fri, 17 Feb 2017 11:02:02 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Huang, Ying" <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:

> On Fri, Feb 17, 2017 at 08:31:12AM +0800, Huang, Ying wrote:
>> I am not sure whether the NVS area is a part of the BERT area, but
>> apparently they are overlapped in some way.  We will access the whole
>> BERT area here via ioremap the whole range.
>
> This is the part that was missing from the commit message - explaining
> *why* we need this fix.

OK.  I will revise the patch description accordingly.

Best Regards,
Huang, Ying
