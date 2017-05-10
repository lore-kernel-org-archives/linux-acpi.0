From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Wed, 10 May 2017 23:57:07 +0200
Message-ID: <20170510215707.v7zywrslma4o7jao@pd.tnic>
References: <CAPcyv4jAkCE2QBuxfxxmZfQZLCVOGLrLXqDu5TyGCVA+xJMEVg@mail.gmail.com>
 <20170421202741.GA16423@intel.com>
 <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
 <20170424113620.6iq2466yhkhb33rp@pd.tnic>
 <20170425210740.GA15722@omniknight.lm.intel.com>
 <1494444606.20330.2.camel@intel.com>
 <20170510200406.mphusoidfuyq24ee@pd.tnic>
 <1494446729.20330.4.camel@intel.com>
 <20170510200851.mhz3434jauxdq2u5@pd.tnic>
 <1494450649.20330.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:38146 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754181AbdEJV5U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 May 2017 17:57:20 -0400
Content-Disposition: inline
In-Reply-To: <1494450649.20330.6.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 10, 2017 at 09:12:12PM +0000, Verma, Vishal L wrote:
> The memory error check in the nfit handler is a valid, and simple fix.

I need the big picture here: "Without this fix, the nfit handler ...".

Then, if the stable rules apply, we can always expedite it through
urgent/stable.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
