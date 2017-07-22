From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Sat, 22 Jul 2017 08:28:53 +0200
Message-ID: <20170722062853.GA2050@nazgul.tnic>
References: <20170721104001.3cd2b884@vento.lan>
 <20170721134715.GC5036@nazgul.tnic>
 <1500649162.2042.43.camel@hpe.com>
 <20170721151317.GA13424@nazgul.tnic>
 <1500650732.2042.45.camel@hpe.com>
 <20170721124401.5f94aba9@vento.lan>
 <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
 <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:58954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdGVG3D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Jul 2017 02:29:03 -0400
Content-Disposition: inline
In-Reply-To: <1500661773.2042.53.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Fri, Jul 21, 2017 at 06:38:52PM +0000, Kani, Toshimitsu wrote:
> Enterprise platforms have very different model (I do not say it's
> better for everyone from the cost perspective).  Typically, such

But you do tell your customers that the error counts they see are not
really what *actually* happens, right?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
