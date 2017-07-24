From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 17:04:32 +0200
Message-ID: <20170724150432.GA31295@nazgul.tnic>
References: <1500649162.2042.43.camel@hpe.com>
 <20170721151317.GA13424@nazgul.tnic>
 <1500650732.2042.45.camel@hpe.com>
 <20170721124401.5f94aba9@vento.lan>
 <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
 <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
 <20170722062853.GA2050@nazgul.tnic>
 <1500907209.2042.55.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:58030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbdGXPFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 11:05:05 -0400
Content-Disposition: inline
In-Reply-To: <1500907209.2042.55.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Mon, Jul 24, 2017 at 02:49:30PM +0000, Kani, Toshimitsu wrote:
> We do not tell the error counts to customers.

Please read what I said: do you tell your customers that the error
counts they're seeing (or are *not* seeing) is bogus because the BIOS is
hiding them? Not the *actual* numbers!

> We tell customers when they need attention and have actionable items,
> and we provide support for that. Support gets all info necessary.

Ok, good to know. I'll make sure to bounce such issues to you guys in
the future.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
