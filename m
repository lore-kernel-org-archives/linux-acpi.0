From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 20:30:14 +0200
Message-ID: <20170724183014.GB20501@nazgul.tnic>
References: <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
 <20170722062853.GA2050@nazgul.tnic>
 <1500907209.2042.55.camel@hpe.com>
 <20170724150432.GA31295@nazgul.tnic>
 <1500909372.2042.58.camel@hpe.com>
 <20170724153716.GA17708@nazgul.tnic>
 <20170724130402.0f05c0ba@vento.lan>
 <20170724164400.GB18184@nazgul.tnic>
 <20170724151013.513d5fc8@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:37628 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbdGXSat (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 14:30:49 -0400
Content-Disposition: inline
In-Reply-To: <20170724151013.513d5fc8@vento.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

(Sending to your other mail address because there's some temporary resolution
 issue:

msmtp: recipient address mchehab@s-opensource.com not accepted by the server
msmtp: server message: 451 4.3.0 <mchehab@s-opensource.com>: Temporary lookup failure
msmtp: could not send mail (account alien8.de from /home/boris/.msmtprc)

Maybe the problem is on my end.)

On Mon, Jul 24, 2017 at 03:10:13PM -0300, Mauro Carvalho Chehab wrote:
> Yeah, having a whitelist is a maintainership's burden, but, on
> the other hand, I suspect that there aren't many systems that
> implement FF, have a reliable BIOS mapping of MB's silkscreen
> and doesn't filters out corrected errors using some sort of
> undocumented mechanism.
> 
> So, I guess it is doable.

Right, let's hope.

> Another alternative, with, IMO, is better would be to add a parameter like:
> 
> 	edac=FF - firmware first;
> 	edac=hw	 - hardware first;
> 	edac=auto - honors FF if set in BIOS. Otherwise, hardware first.

Or maybe edac=try_FF or so. But yeah, I guess we'll need something to
tell the EDAC core to try FF first.

> In order to avoid regressions, and to avoid the need of a whitelist,
> I would keep "edac=hw" as default.

So I don't want to break existing users and thus make only explicitly
known platforms load ghes_edac. In the current case, the HPE machines.
All the rest will simply use the platform drivers and nothing will
change for them.

Later we'll probably need to revisit this decision but right now and
with all things considered, the whitelist seems - as ugly as it is - the
most workable solution for all the different use cases and machines...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
