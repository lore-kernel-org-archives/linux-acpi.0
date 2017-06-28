From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 0/2] Fixes for ACPI BERT table
Date: Wed, 28 Jun 2017 18:38:36 +0200
Message-ID: <20170628163836.dwhbqq4ojxuwyo2y@pd.tnic>
References: <20170619155854.gtcowx3cityb3gqt@pd.tnic>
 <cover.1498065055.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbdF1QjH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 12:39:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1498065055.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

On Wed, Jun 21, 2017 at 10:20:40AM -0700, Luck, Tony wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> At Boris' suggestion I've split this into two parts for version 5.
> First one stops the driver from clearing the block_status field as:
>  1) it is unnecessary
>  2) not mentioned in the spec
>  3) may upset user mode tools that extract information from the BERT table.
> 
> Second is the code simplification that you've seen before in ealier
> versions of this patch.
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: linux-acpi@vger.kernel.org
> 
> Tony Luck (2):
>   ACPI / APEI / BERT: Don't clear "block_status" in header
>   ACPI / APEI: Boot Error Record Table processing was needlessly
>     complicated

Both:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
