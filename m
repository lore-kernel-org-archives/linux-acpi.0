From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 7/7] edac drivers: add MC owner check in init
Date: Sat, 5 Aug 2017 07:49:06 +0200
Message-ID: <20170805054906.GF23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-8-toshi.kani@hpe.com>
 <20170804083922.GC15617@nazgul.tnic>
 <1501882730.2042.123.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdHEFtr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:49:47 -0400
Content-Disposition: inline
In-Reply-To: <1501882730.2042.123.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:48:23PM +0000, Kani, Toshimitsu wrote:
> Not sure if anyone cares, but I thought it should return with -ENODEV
> when this modules found no target, and -EBUSY when it found a target
> but it's busy.  Hence, this ordering.

You can still return -EBUSY. Just do the owner check first because if
we're going to return due to ghes_edac being loaded already, we might
just as well skip the other checks as they're a pointless waste of
cycles and energy.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
