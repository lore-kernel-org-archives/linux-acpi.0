From: Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 14:55:08 -0400
Message-ID: <20170719185508.GC16076@redhat.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <20170718080836.GB8372@nazgul.tnic>
 <1500412288.2042.25.camel@hpe.com>
 <20170719055235.GD26030@nazgul.tnic>
 <1500480051.2042.27.camel@hpe.com>
 <20170719162204.GE16124@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755385AbdGSSzK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 14:55:10 -0400
Content-Disposition: inline
In-Reply-To: <20170719162204.GE16124@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Jul 19, 2017 at 06:22:04PM +0200, Borislav Petkov wrote:
> On Wed, Jul 19, 2017 at 04:10:07PM +0000, Kani, Toshimitsu wrote:
> > I do prefer to avoid any white / black listing.  But I do not see how
> > it solves the buggy DMI/SMBIOS info as an example of firmware bugs we
> > may have to deal with.
> 
> So how do you want to deal with this?
> 
> Maintain an evergrowing whitelist of platforms which are OK and then the
> moment a new platform comes along, you send a patch to add it to that
> whitelist?

That would also need to keep an eye on versions. A newer version of BIOS
on a whitelisted platform might be broken.

-- 
Aristeu

