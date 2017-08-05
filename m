From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Sat, 5 Aug 2017 07:16:15 +0200
Message-ID: <20170805051615.GC23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-5-toshi.kani@hpe.com>
 <20170804040525.GE12082@nazgul.tnic>
 <1501879964.2042.117.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdHEFQ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:16:56 -0400
Content-Disposition: inline
In-Reply-To: <1501879964.2042.117.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:02:17PM +0000, Kani, Toshimitsu wrote:
> GHES platform devices correspond to GHES entries, which define firmware
> interfaces to report generic memory errors to the OS, such as NMI and
> SCI.  These devices are associated with all DIMMs, not a particular
> DIMM.

And? Stating the obvious brings you what exactly?

IOW, you still haven't answered my question.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
