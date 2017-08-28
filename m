From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Mon, 28 Aug 2017 19:25:40 +0200
Message-ID: <20170828172539.5cl7baxdxxaixlri@pd.tnic>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <1503939660.25945.127.camel@linux.intel.com>
 <20170828171405.2s4rlebloi5lyhga@pd.tnic>
 <CAHp75Vdx2NG8yd-cr14hxQzEjy-V29de4nbiq0v9tWpXVxt+2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbdH1RZz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 13:25:55 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vdx2NG8yd-cr14hxQzEjy-V29de4nbiq0v9tWpXVxt+2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, james.morse@arm.com, shiju.jose@huawei.com, Geliang Tang <geliangtang@gmail.com>, Tony Luck <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Aug 28, 2017 at 08:20:37PM +0300, Andy Shevchenko wrote:
>        if (rc != -ENOENT && is_hest_type_generic_v2(ghes))
>  :-)
> 
> But again, your call to choose :-)

Slow down please.

What do you think is more readable: a compound if-statement or two
simple ones, the second one with an explanatory comment?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
