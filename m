From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI / blacklist: add acpi_match_oemlist() interface
Date: Tue, 18 Jul 2017 19:42:45 +0200
Message-ID: <20170718174245.GA22817@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-2-toshi.kani@hpe.com>
 <20170718053455.GA8736@nazgul.tnic>
 <1500392379.2042.13.camel@hpe.com>
 <20170718164350.GB22334@nazgul.tnic>
 <1500398136.2042.17.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdGRRm5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 13:42:57 -0400
Content-Disposition: inline
In-Reply-To: <1500398136.2042.17.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Tue, Jul 18, 2017 at 05:24:50PM +0000, Kani, Toshimitsu wrote:
> Well, a list does not need to be a black-list.

But this one *is* a blacklist.

> So, I tried to avoid putting any usage to the structure name.

So OEM is a usage. The moment you need to use it for something else
besides an OEM, it is not an OEM list anymore - it is a generic
blacklist which blacklists OEMs too.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
