From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI / blacklist: add acpi_match_oemlist() interface
Date: Tue, 18 Jul 2017 18:43:50 +0200
Message-ID: <20170718164350.GB22334@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-2-toshi.kani@hpe.com>
 <20170718053455.GA8736@nazgul.tnic>
 <1500392379.2042.13.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500392379.2042.13.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 18, 2017 at 03:48:54PM +0000, Kani, Toshimitsu wrote:
> This patch defines 'struct acpi_oemlist' in "include/linux/acpi.h" as a

I see that.

> common structure, and replaces this specific 'struct acpi_blacklist'.

And what makes acpi_oemlist "common" and acpi_blacklist "specific"?

So let me save you some time - "oemlist" is more specific than
"blacklist" and I can imagine a blacklist item not always being
oem-specific.

What I'm hinting at is, don't change that name. acpi_blacklist is just
fine.

> Agreed.  Will change to a shorter name like below. 
> 
> 	enum acpi_oemlist_pred predicate;

	enum acpi_predicate pred;

is even better.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
