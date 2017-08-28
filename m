From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Mon, 28 Aug 2017 19:14:05 +0200
Message-ID: <20170828171405.2s4rlebloi5lyhga@pd.tnic>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <1503939660.25945.127.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51763 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbdH1ROU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 13:14:20 -0400
Content-Disposition: inline
In-Reply-To: <1503939660.25945.127.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 28, 2017 at 08:01:00PM +0300, Andy Shevchenko wrote:
> You can also do this here, like
> 	if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)

https://lkml.kernel.org/r/20170824081408.iwg7qyyr226btivo@pd.tnic

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
