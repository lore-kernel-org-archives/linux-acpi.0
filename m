From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 17:37:16 +0200
Message-ID: <20170724153716.GA17708@nazgul.tnic>
References: <1500650732.2042.45.camel@hpe.com>
 <20170721124401.5f94aba9@vento.lan>
 <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
 <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
 <20170722062853.GA2050@nazgul.tnic>
 <1500907209.2042.55.camel@hpe.com>
 <20170724150432.GA31295@nazgul.tnic>
 <1500909372.2042.58.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:59474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbdGXPh6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 11:37:58 -0400
Content-Disposition: inline
In-Reply-To: <1500909372.2042.58.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Mon, Jul 24, 2017 at 03:25:34PM +0000, Kani, Toshimitsu wrote:
> Customers do not see error counts.  I do not think it's bogus.

Not showing the real error error counts but something contrived is the
definition of bogus numbers. But you're not showing anything - only when
some thresholds are being hit.

> This model is basically the same as your car.  You do not see error

Oh jeez, we're talking about cars now.

> We've been providing this model for many years now.

Dude, relax, I'm only trying to point out to you that there are
customers who want to see *every* error and thus track how their
hardware behaves. And that for those customers it is probably worth
considering exposing that info and providing a switch to disable that
dumbing of the RAS functionality in the BIOS so that people can decide
for themselves. That's all.

I'm not questioning your model - I'm just saying that it could be
improved for certain customers. Do me a favor and this time *actually*
*read* my reply.

> I am just trying to enable OS error reporting with ghes_edac.

I know, you don't have to state the obvious constantly.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
