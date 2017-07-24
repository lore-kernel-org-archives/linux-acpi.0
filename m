From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 15:10:13 -0300
Message-ID: <20170724151013.513d5fc8@vento.lan>
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
        <20170724164400.GB18184@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724164400.GB18184@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Em Mon, 24 Jul 2017 18:44:00 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Jul 24, 2017 at 01:04:13PM -0300, Mauro Carvalho Chehab wrote:
> > If the Kernel force those users to use ghes_edac by default,
> > they they won't see the error counts anymore, but, instead,
> > hardware reports that the memories need to be replaced.  
> 
> This is exactly why I'm trying to load ghes_edac only on those platforms
> which would really want it.
> 
> > So, the right solution would be to keep hardware first, but
> > providing a modprobe parameter to let them switch to software
> > first.  
> 
> That's exactly the issue: if we make it spec-conform and adhere to FF
> setting, then it'll be clean. BUT(!), we will force ghes_edac on those
> platforms which potentially are using the platform-specific drivers
> until now. Not good.
> 
> If we do the whitelisting, then we're stuck with maintaining a yucky
> whitelist and have to keep updating ghes_edac with it.

Yeah, having a whitelist is a maintainership's burden, but, on
the other hand, I suspect that there aren't many systems that
implement FF, have a reliable BIOS mapping of MB's silkscreen
and doesn't filters out corrected errors using some sort of
undocumented mechanism.

So, I guess it is doable.

Another alternative, with, IMO, is better would be to add a parameter like:

	edac=FF - firmware first;
	edac=hw	 - hardware first;
	edac=auto - honors FF if set in BIOS. Otherwise, hardware first.

In order to avoid regressions, and to avoid the need of a whitelist,
I would keep "edac=hw" as default.

Thanks,
Mauro
