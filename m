From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 18:22:04 +0200
Message-ID: <20170719162204.GE16124@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <20170718080836.GB8372@nazgul.tnic>
 <1500412288.2042.25.camel@hpe.com>
 <20170719055235.GD26030@nazgul.tnic>
 <1500480051.2042.27.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:60990 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753513AbdGSQWP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 12:22:15 -0400
Content-Disposition: inline
In-Reply-To: <1500480051.2042.27.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Jul 19, 2017 at 04:10:07PM +0000, Kani, Toshimitsu wrote:
> I do prefer to avoid any white / black listing.  But I do not see how
> it solves the buggy DMI/SMBIOS info as an example of firmware bugs we
> may have to deal with.

So how do you want to deal with this?

Maintain an evergrowing whitelist of platforms which are OK and then the
moment a new platform comes along, you send a patch to add it to that
whitelist?

I'm sure you can see the problems with that approach.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
