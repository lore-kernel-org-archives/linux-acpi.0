From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI / blacklist: add acpi_match_oemlist() interface
Date: Tue, 18 Jul 2017 21:32:08 +0200
Message-ID: <20170718193208.GA23126@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-2-toshi.kani@hpe.com>
 <20170718053455.GA8736@nazgul.tnic>
 <1500392379.2042.13.camel@hpe.com>
 <20170718164350.GB22334@nazgul.tnic>
 <1500398136.2042.17.camel@hpe.com>
 <20170718174245.GA22817@nazgul.tnic>
 <1500403237.2042.19.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:43040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbdGRTc0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 15:32:26 -0400
Content-Disposition: inline
In-Reply-To: <1500403237.2042.19.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Tue, Jul 18, 2017 at 06:49:51PM +0000, Kani, Toshimitsu wrote:
> ghes_edac uses this structure as a while-list, so the term backlist is
> misleading.

So this matching function gets both blacklists and whitelists. No wonder
it is confusing. Now I finally understand what you wanna do: you want to
call all those lists something agnostic as platform_list or so because
they contain exactly that: platforms - not OEMs.

And then you want to match *platforms*. *Not* OEMs.

*Now* I understand what you're trying to tell me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
