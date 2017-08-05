From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/7] ACPI / blacklist: add acpi_match_oemlist()
 interface
Date: Sat, 5 Aug 2017 07:12:15 +0200
Message-ID: <20170805051215.GA23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-2-toshi.kani@hpe.com>
 <20170804034206.GB12082@nazgul.tnic>
 <1501878602.2042.113.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33380 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdHEFNB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:13:01 -0400
Content-Disposition: inline
In-Reply-To: <1501878602.2042.113.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 08:39:35PM +0000, Kani, Toshimitsu wrote:
> Well, we did talk a lot about your suggested name, "acpi_blacklist",
> and I explained that it did not work since it'd be used for both black
> and white-list.  We've agreed on that.
> 
> You then suggested it's "platform", not "OEM".  Since this is an ACPI
> structure defined in "acpi.h", its terminology generally follows ACPI
> spec, which I did.
> 
> I understand that you feel strongly against "OEM" (sorry about that). 
> How about "acpi_platform_list"?  Does it work for you?

Yes, I thought we agreed on all that.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
