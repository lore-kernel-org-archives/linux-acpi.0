From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Wed, 13 Apr 2016 07:08:42 +0200
Message-ID: <CAJZ5v0hFBkH6B0rA+x4h67sCgUax_8N_ZHGQGPu-=L3HUVNA9g@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com>
	<20160406103925.GA31110@svinekod>
	<2161127.3msi2j0Rxi@vostro.rjw.lan>
	<20160412121533.GB14664@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160412121533.GB14664@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, "Tirdea, Irina" <irina.tirdea@intel.com>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 12, 2016 at 2:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 07, 2016 at 11:24:00PM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, April 06, 2016 11:39:27 AM Mark Rutland wrote:
>
>> > The ACPI model implies FW-driven pinctrl management, so if we're going to put
>> > the OS in direct control of pinctrl, we have to make clear what expectation FW
>> > and OS can have.
>
>> Well, orthodox ACPI people from the Windows camp would definitely agree with you,
>> but I'm not one of them, so let me play a devil's advocate for a while. :-)
>
>> IMO, exposing anything in the ACPI tables without explicitly saying "but you
>> should not touch that", eg by defining an operation region covering it or similar,
>> is equivalent to giving the OS a license to play with that thing as it wishes.
>
>> Therefore I would regard exposing pin control information in cases when the
>> OS is not allowed to use it to its fit as a firmware bug.
>
> This is something where it seems like it would be very easy for people
> to end up relying on current OS behaviour even if that only happened
> through accident rather than design.  You might assume that such
> behaviour is a bug but that may not be obvious to the firmware author if
> the OS behaviour makes sense to them.

If the OS started to support that interface, it would need to
guarantee consistent behavior with respect to it going forward.

It would be an interface for interacting with firmware, so it is not
much different from an interface to user space as far as the stability
rules go.  Which may be a reason for refusing to support it in the
first place if the OS is not willing to make such a guarantee.

> There may also be some expectation on the part of firmware that the OS
> will do some management of the pins even for devices that it's not
> actively working with (put them in an idle mode for example).
>
>> Now, the question in this patch series is how to expose things and not when to
>> do that.  It adds support for a specific method of exposing information to the
>> OS, but should it be concerned about the possible consequences of inappropriate
>> use of that method by firmware?
>
> The other issue here is that if (as Octavian mentioned) there are
> ongoing discussions within ASWG on producing an actual spec for this it
> doesn't seem great that we'd just go and do something completely
> different rather than trying to make sure that the spec works well.  Or
> if there isn't any spec work then writing one there for other OSs to
> pick up if they like.  This seems like it'd make us much better
> community players.

Agreed.  I actually asked Octavian to look at the other proposal and
see if/how that could be used to address the use case in question
and/or possibly extended to cover it.

Thanks,
Rafael
