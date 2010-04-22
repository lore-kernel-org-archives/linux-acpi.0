From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Thu, 22 Apr 2010 14:36:05 +0100
Message-ID: <20100422133605.GA31680@srcf.ucam.org>
References: <1271746353.16585.9.camel@flunder> <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com> <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com> <1271762498.1537.215.camel@pancake> <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com> <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org> <1271860206.1537.1914.camel@pancake> <20100421143239.GA484@srcf.ucam.org> <1271924488.3790.25.camel@flunder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1271924488.3790.25.camel@flunder>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2010 at 10:21:28AM +0200, Florian Echtler wrote:

> So it would be all joy and happiness if it weren't for the fact that
> ERQ0 is initialized to zero and is never changed anywhere else.. I'll
> give the VPC0._CFG method a try later today and see if that changes
> anything.

Hm. Maybe there's some side-effect that's intended to result in that. 
Can you send me the DSDT? It didn't seem to turn up on the mailing list 
for some reason.

> What's also confusing is that while there's an EC register (0xE6) which
> nicely reflects all of the hotkeys' state as a bitmask, one of them
> doesn't trigger an EC event. I'm reluctant to just write stuff to the EC
> registers, but maybe one of you can make some sense of the attached
> hexdump - it says "SANYO" somewhere in there, does that ring a bell?

Probably the vendor? Which hotkey doesn't generate an event?

> Since I've seen that lenovo-sl-laptop also just uses polling at 5 Hz to
> handle the hotkeys, I'm sort of leaning towards that solution now..

Mm. Would be preferable to avoid that. We had polling in the Toshiba 
driver for some time until we worked out that there was a method that 
triggered notifications.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
