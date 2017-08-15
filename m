From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Tue, 15 Aug 2017 17:50:00 +0200
Message-ID: <20170815155000.d57hwki5jbixjuj6@pd.tnic>
References: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
 <1502732561.2042.141.camel@hpe.com>
 <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
 <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
 <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
 <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbdHOPuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 11:50:07 -0400
Content-Disposition: inline
In-Reply-To: <1502810766.2042.149.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Tue, Aug 15, 2017 at 03:35:51PM +0000, Kani, Toshimitsu wrote:
> ghes_edac instantiates an mci as a pseudo device representing a GHES
> error source.  Each error source associates with all DIMMs, and may
> report errors independently.  As ghes_edac is an GHES error-reporting
> wrapper to edac, this abstraction makes sense.

Bullshit.

An MCI is a memory controller descriptor. That doesn't fit the GHES
platform devices that get probed. GHES platform device != MCI. How many
times do I need to say this for it to get through to you?

> I do not see a problem in having counters for each GHES error source.

And the error counters of that "simulated" mci get incremented depending
on which pointer gets passed in from GHES? More bullshit.

> This is just statistics info, and ghes_edac does not expect any OS
> action from the counters.

So let me know if you don't want to do it and rather would prefer to
pointlessly debate. I certainly don't want to waste my time debating.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
