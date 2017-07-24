From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 18:44:00 +0200
Message-ID: <20170724164400.GB18184@nazgul.tnic>
References: <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
 <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
 <20170722062853.GA2050@nazgul.tnic>
 <1500907209.2042.55.camel@hpe.com>
 <20170724150432.GA31295@nazgul.tnic>
 <1500909372.2042.58.camel@hpe.com>
 <20170724153716.GA17708@nazgul.tnic>
 <20170724130402.0f05c0ba@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753475AbdGXQoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 12:44:34 -0400
Content-Disposition: inline
In-Reply-To: <20170724130402.0f05c0ba@vento.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Mon, Jul 24, 2017 at 01:04:13PM -0300, Mauro Carvalho Chehab wrote:
> If the Kernel force those users to use ghes_edac by default,
> they they won't see the error counts anymore, but, instead,
> hardware reports that the memories need to be replaced.

This is exactly why I'm trying to load ghes_edac only on those platforms
which would really want it.

> So, the right solution would be to keep hardware first, but
> providing a modprobe parameter to let them switch to software
> first.

That's exactly the issue: if we make it spec-conform and adhere to FF
setting, then it'll be clean. BUT(!), we will force ghes_edac on those
platforms which potentially are using the platform-specific drivers
until now. Not good.

If we do the whitelisting, then we're stuck with maintaining a yucky
whitelist and have to keep updating ghes_edac with it.

So we're basically between a rock and a hard place.

If I had to choose *right* *now*, I'd probably lean slightly towards the
whitelist as it won't break existing users.

A big grumpfy-grumbly hmmm. :-\

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
