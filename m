From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 17:15:23 -0300
Message-ID: <20170720171523.4812a8b4@vento.lan>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>
        <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>
        <1500481869.2042.29.camel@hpe.com>
        <20170720043344.GC14367@nazgul.tnic>
        <1500579646.2042.37.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:38892
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965009AbdGTUPd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 16:15:33 -0400
In-Reply-To: <1500579646.2042.37.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Thu, 20 Jul 2017 19:50:03 +0000
"Kani, Toshimitsu" <toshi.kani@hpe.com> escreveu:

> On Thu, 2017-07-20 at 06:33 +0200, Borislav Petkov wrote:
> > On Wed, Jul 19, 2017 at 04:40:25PM +0000, Kani, Toshimitsu wrote:  
> > >  ghes_edac allows to report errors to OS management tools like
> > > rasdaemon in addition to platform- specific managements.  
> > 
> > So ghes_edac *is* a poor man's driver in the sense that it doesn't do
> > anything fancy but repeat like a parrot data it has gotten from the
> > firmware and shoving it into the EDAC counters. At least that's the
> > intention. Nothing more.   
> 
> Right for ghes_edac.
> 
> > All the action stuff like error detection and recovery should be done
> > by the firmware.  
> 
> GHES / firmware-first still requires OS recovery actions when an error
> cannot be corrected by the platform.  They are handled by ghes_proc(),
> and ghes_edac remains its error-reporting wrapper.
> 
> > But considering how SNAFU'd firmware is, I wouldn't expect any great
> > RAS functionality there. Of course, I'd be delighted to be proven
> > wrong.  
> 
> Firmware has better knowledge about the platform and can provide better
> RAS when implemented properly.  I agree that user experiences may vary
> on platforms.

It may have a better knowledge, when the vendor ships different BIOS
for platforms with different motherboard silkscreens, but a lot of
vendors just use the same BIOS on different models, with the same
information at "Locator" and "Bank Locator" data at DMI tables,
that don't match what's printed at the board's silkscreen.

So, GHES ends by exposing wrong data. Also, such BIOS fail
to properly expose such knowledge to drivers/userspace.

On the discussions I had with HP, back in 2012, the idea was to try 
to have some sort of way for the GHES driver to query the BIOS
on a reliable way, in order to get its layout, in a way
that tools like ras-mc-ctl would properly report the memory
configuration (with --layout) and the motherboard silkscreen
labels (with --print-labels). Unfortunately, at least on that
time, the discussions with HP didn't proceed.

Thanks,
Mauro
