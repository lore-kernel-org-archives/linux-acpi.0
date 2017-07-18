From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 10:08:36 +0200
Message-ID: <20170718080836.GB8372@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718060007.GB8736@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, Tony Luck <tony.luck@intel.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 18, 2017 at 08:00:07AM +0200, Borislav Petkov wrote:
> And I think we should try this first: have the firmware disable
> detection methods so that the platform drivers don't load.

Btw, in looking at this more, what about the firmware-first thing?

I.e., the firmware-first detection with apei_osc_setup() at the end of
ghes_init().

Can we make ghes_edac loading dependent on that? I mean, that was *the*
predicate for exactly that - to have the firmware look at the errors
first. No need for platform whitelisting and so on.

I'd still decouple ghes_edac loading from ghes_probe() even though
loading the platform driver should've been done *after* the
firmware-first detection regardless.

So what we could do is make ghes_edac a normal module and have the
relevant x86 EDAC modules query FF mode and if enabled, fail loading.

Hmmm?

My gut feeling tells me I'm on the right track here but who knows...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
