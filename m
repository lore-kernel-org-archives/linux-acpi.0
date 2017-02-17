From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS
 area
Date: Fri, 17 Feb 2017 11:02:02 +0100
Message-ID: <20170217100202.xi5x4lqdk6gqtfd5@pd.tnic>
References: <20170214020143.29713-1-ying.huang@intel.com>
 <4305135.N5b65JQej5@aspire.rjw.lan>
 <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
 <87fujea0wo.fsf@yhuang-dev.intel.com>
 <20170216103215.ppo2oe7byql5r6ve@pd.tnic>
 <8737fdaca7.fsf@yhuang-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737fdaca7.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 17, 2017 at 08:31:12AM +0800, Huang, Ying wrote:
> I am not sure whether the NVS area is a part of the BERT area, but
> apparently they are overlapped in some way.  We will access the whole
> BERT area here via ioremap the whole range.

This is the part that was missing from the commit message - explaining
*why* we need this fix.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
