From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 06:33:44 +0200
Message-ID: <20170720043344.GC14367@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <1500481869.2042.29.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500481869.2042.29.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2017 at 04:40:25PM +0000, Kani, Toshimitsu wrote:
>  ghes_edac allows to report errors to OS management tools like
> rasdaemon in addition to platform- specific managements.

So ghes_edac *is* a poor man's driver in the sense that it doesn't do
anything fancy but repeat like a parrot data it has gotten from the
firmware and shoving it into the EDAC counters. At least that's the
intention. Nothing more. All the action stuff like error detection and
recovery should be done by the firmware.

But considering how SNAFU'd firmware is, I wouldn't expect any great RAS
functionality there. Of course, I'd be delighted to be proven wrong.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
