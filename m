From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 22:39:42 +0200
Message-ID: <20170814203942.6t3mrq3hc324blab@pd.tnic>
References: <20170814162436.lta5xm742hh6g7yk@pd.tnic>
 <1502728754.2042.139.camel@hpe.com>
 <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
 <1502732561.2042.141.camel@hpe.com>
 <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
 <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
 <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49862 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752464AbdHNUjv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Aug 2017 16:39:51 -0400
Content-Disposition: inline
In-Reply-To: <1502741290.2042.147.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On Mon, Aug 14, 2017 at 08:17:54PM +0000, Kani, Toshimitsu wrote:
> I think the current code design of allocating mci & ghes_edac_pvt for
> each GHES source entry makes sense.

And I don't.

> edac_raw_mc_handle_error() also has the same expectation that the call
> is serialized per mci.

There's no such thing as "per mci" if the driver scans *all DIMMs* per
register call. If it does it this way, then it is only one mci.

It is actually wrong right now because if you register more than one
mci and you do edac_inc_ce_error()/edac_inc_ue_error(), potentially
different counters get incremented for the same errors. Exactly because
each instance registered is *wrongly* responsible for all DIMMs on the
system.

So you either need to partition the DIMMs per mci (which I can't imagine
how it would work) or introduce locking when incrementing the mci->
counters.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
