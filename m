From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 07:52:35 +0200
Message-ID: <20170719055235.GD26030@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <20170718080836.GB8372@nazgul.tnic>
 <1500412288.2042.25.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdGSFwl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 01:52:41 -0400
Content-Disposition: inline
In-Reply-To: <1500412288.2042.25.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Tue, Jul 18, 2017 at 09:20:44PM +0000, Kani, Toshimitsu wrote:
> I agree that 'osc_sb_apei_support_acked' should be checked when
> enabling ghes_edac.  I do not know the details of existing issues, but
> it sounds unlikely that this will address all of them since bugs can be
> everywhere.

No, see below.

> For instance, ghes_edac relies on DMI/SMBIOS info, unlike
> other EDAC drivers, which can be buggy regardless of this _OSC info.

That's the problem with firmware. You can't really fix it and it is
buggy as hell.

> I agree that making ghes_edac as a normal module is a good thing, but I
> do not think it's going to solve this issue.

Of course it will - if the firmware says it wants to look at the errors
first, then it gets to do so. This is the whole handling of hardware
errors in the firmware deal. I admit, sometimes it makes sense because
the firmware has the most intimate knowledge of the platform and, in
a perfect world, we won't ever need to have platform-specific EDAC
drivers.

But, we don't live in a perfect world. And the vendor execution of the
whole firmware-error-handling deal is an abomination at best.

So, if we realize that the firmware is buggy, we can use a platform list
to blacklist it (^hint hint^) and have a parameter to disable ghes_edac
from loading.

But we'll deal with that when we get to cross that bridge. Right now,
I'd like to do the loading spec-conform and not fiddle with white-,
black-, or any-other-color lists.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
