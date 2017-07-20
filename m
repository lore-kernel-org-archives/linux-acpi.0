From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 06:19:50 +0200
Message-ID: <20170720041950.GB14367@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <20170718080836.GB8372@nazgul.tnic>
 <1500412288.2042.25.camel@hpe.com>
 <20170719055235.GD26030@nazgul.tnic>
 <1500480051.2042.27.camel@hpe.com>
 <20170719162204.GE16124@nazgul.tnic>
 <20170719185508.GC16076@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:54672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbdGTETz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 00:19:55 -0400
Content-Disposition: inline
In-Reply-To: <20170719185508.GC16076@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aristeu Rozanski <aris@redhat.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Jul 19, 2017 at 02:55:08PM -0400, Aristeu Rozanski wrote:
> That would also need to keep an eye on versions. A newer version of BIOS
> on a whitelisted platform might be broken.

Yeah, that would be a nasty, back-stabbing SNAFU.

So I'm thinking of adding a bunch of FW_ERR sanity checks to that whole
ghes_edac and ghes init code to hopefully catch issues during platform
validation. I.e., early enough for them to get fixed.

But that's the same problem as with UEFI - vendors need to try to boot
Linux on their platforms early enough.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
