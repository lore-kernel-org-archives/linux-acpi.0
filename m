From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 1 Jun 2017 17:20:54 +0200
Message-ID: <9fae1e2f-9d5b-2ba8-3bf5-4e1516e06332@redhat.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
 <CACRpkdan9Ayd6qGioQc2N+x9S2WxfXs2WGg4imAApLRxOwrfmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdFAPU6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Jun 2017 11:20:58 -0400
In-Reply-To: <CACRpkdan9Ayd6qGioQc2N+x9S2WxfXs2WGg4imAApLRxOwrfmQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

Hi,

On 01-06-17 17:11, Linus Walleij wrote:
> On Wed, May 24, 2017 at 12:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
>> PMC to wakeup the system. When this happens software needs to clear the
>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> 
> Spell out these acronyms so I have at least a faint chance of understanding
> what is going on here.

Sorry, I cannot spell them out without guessing myself, there is no
documentation this commit message is based on the explanation found
in the patches from here:

https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches

Warning there are over 5000 patches there (yes really that seems to
be how android on x86 gets shipped).

Well I guess I could go over the PDF with the register documentation
that may if we're lucky explain the acronyms, but often it just uses
the acronyms and that's it.

>> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.
> 
> So are you saying that some firmware dork has modeled something that
> *is* *actually* a port to a PMC (I guess power management controller) to
> send a PME (I guess power managment enable signal?) by shoehorning that
> into something purporting to be a GPIO (general purpose input/output)
> controller?

Yes, you've got the gist of it right this has nothing to do with GPIOs
at all, but the ACPI firmware representation of the AML event handler
which needs to be called when the PME_B0 interrupt fires is in the
form of a GpioInt and the ACPI node has _AEI and _L02 methods to
match.

> Well I've been approached before by people all over that just wanna stick
> something quick and dirty into the GPIO subsystem because it's so
> convenient. ("Come on, just take it", etc.)
> 
> I usually just say no. General purpose I/O is not special-purpose I/O.
> I bet a million to one these are just a few bits in a register, right?

Right.

> And someone chose to model that as a "GPIO"?

Right.

> 
> This takes the price.
> 
> Now we have not just lazy kernel programmers but lazy ACPI firmware
> authors having to have their sloppy stuff cleaned up by Hans in kernelspace. >
> And I bet the resource resolution for this thing is completely dependent on
> dirvers/gpio/gpiolib-acpi.c so it must be a using GPIO for that reason?

Actually I started out with a stand-alone platform driver which duplicated
some code from gpiolib-acpi.c (not copy pasted but I ended up writing more
or less the same code) you never saw that version as it was not send to
you but to the platform/x86 maintainers.

That version got review comments asking me to redo it in a way which avoided
the duplication and the version you are seeing now is the result of that.

> I guess that just force me to not NACK this because I don't want to screw
> up all the worlds Intel cherryviews etc.
> 
> :(
> 
>> +static const struct acpi_device_id int0002_acpi_ids[] = {
>> +       { "INT0002", 0 },
>> +       { },
> 
> So again, the reason this - which is not a GPIO controller at all -
> should anyways
> be in drivers/gpio/ is that some firmware person think it's convenien >
> Shouldn't this rather be in drivers/platform/x86?

That is where it started, I'm fine with putting it back there.

> You can still use the gpio driver abstraction.

Ack, if you're ok with using the gpio driver abstraction while
putting the driver in drivers/platform/x86 that might be the
best way to deal with this.

Regards,

Hans
