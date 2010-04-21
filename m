From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Wed, 21 Apr 2010 15:32:39 +0100
Message-ID: <20100421143239.GA484@srcf.ucam.org>
References: <1271687130.26267.147.camel@pancake> <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com> <1271746353.16585.9.camel@flunder> <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com> <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com> <1271762498.1537.215.camel@pancake> <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com> <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org> <1271860206.1537.1914.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1271860206.1537.1914.camel@pancake>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2010 at 04:30:06PM +0200, Florian Echtler wrote:
> Thanks - now let me try to sum this up in order to get it straight (I've been
> reading the ACPI spec and had to fight sleep really hard :-).
> 
> 1. EC detects an event (hotkey), raises an SCI.
> 
> 2. Linux ec.c driver services the SCI, queries the EC for event code.

Yup. The ec driver is a special case of a GPE going directly to a driver 
rather than being handled by the ACPI core.

> 3. If available, ec.c calls ACPI _Qxx method for received event code.
> 
> 4. _Qxx method changes some internal state and MAY again call
>    Notify(...) to pass the event to some other ACPI device.
> 
> 5. If Notify() was called, second-level ACPI driver (e.g. battery.c,
>    thermal.c, ...) gets event and handles it accordingly.

That's all correct.

> If that's correct so far, couldn't I just print the EC event code in
> acpi_ec_sync_query and see what it's spitting out on hotkey press?

Yes, that should work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
