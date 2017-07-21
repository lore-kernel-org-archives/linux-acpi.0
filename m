From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 19:23:45 +0200
Message-ID: <20170721172344.GA11316@nazgul.tnic>
References: <1500579646.2042.37.camel@hpe.com>
 <20170721133441.GB5036@nazgul.tnic>
 <20170721104001.3cd2b884@vento.lan>
 <20170721134715.GC5036@nazgul.tnic>
 <1500649162.2042.43.camel@hpe.com>
 <20170721151317.GA13424@nazgul.tnic>
 <1500650732.2042.45.camel@hpe.com>
 <20170721124401.5f94aba9@vento.lan>
 <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170721140131.40079805@vento.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2017 at 02:01:31PM -0300, Mauro Carvalho Chehab wrote:
> I see the value of having a threshold in BIOS, provided that it is
> well documented, and whose value can be adjusted, if needed.
> 
> One of the things I wanted to implement in ras-daemon were an
> algorithm that would be doing such threshold in software.

We have that now in the kernel: drivers/ras/cec.c

We did it exactly for that purpose - not upsetting users unnecessarily.

> The thing with a BIOS threshold is that the user has no way to
> audit the algorithm. So, when BIOS start reporting such errors,
> it may be already too late: the systems may be in the verge of 
> losing data (or some data was already lost).

Not only that: thresholds depend on the DIMM types which means, BIOS
must know what DIMM types are in there which I doubt. So exposing that
to configuration instead of "deciding" for people would be better.

> That's critical on cluster systems with thousands of machines:
> while the impact of disabling a cluster node to do some maintainance
> is marginal, the impact of an uncorrected error on a single
> machine may compromise weeks of expensive processing.
> 
> That's why some users prefer to monitor every single corrected
> error, and compare with the probability distribution they
> know that the risk of uncorrected errors is acceptable.

Yap, you need to have stuff like that configurable - BIOS can't predict
all possible use cases.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
