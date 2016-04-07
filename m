From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Thu, 07 Apr 2016 23:24 +0200
Message-ID: <2161127.3msi2j0Rxi@vostro.rjw.lan>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com> <CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com> <20160406103925.GA31110@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45681 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757462AbcDGVV3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2016 17:21:29 -0400
In-Reply-To: <20160406103925.GA31110@svinekod>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>, "Tirdea, Irina" <irina.tirdea@intel.com>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>

On Wednesday, April 06, 2016 11:39:27 AM Mark Rutland wrote:
> On Thu, Apr 07, 2016 at 03:11:53PM +0300, Octavian Purdila wrote:
> > On Wed, Apr 6, 2016 at 3:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, Apr 05, 2016 at 11:09:34PM +0300, Octavian Purdila wrote:
> > >> On Tue, Apr 5, 2016 at 9:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > >> > * The firmware is to some extent expected to manage pinctrl today (for power
> > >> >   management of devices it does know about), and hence a pinctrl device is
> > >> >   potentially under shared management of ACPI and the OS.
> > >> >
> > >> > * The ACPI specification says nothing about this style of pinctrl management,
> > >> >   so it is unclear what the expectations are:
> > >>
> > >> Does it say anything at all about pinctrl management?
> > >
> > > To the best of my knowledge the ACPI spec does not explicitly mention pinctrl.
> > > In another reply it was mentioned that there is work in progress for pinmuxing,
> > > so evidently it is on the ASWG radar and within the scope of ACPI.
> > >
> > > I was trying to point out that it is _implicitly_ firmware's responsibility to
> > > do any pinctrl today, due to the ACPI model for power management, and the lack
> > > of an existing ACPI mechanisms to provide pinctrl data.
> > >
> > > In practice, firmware configures pinctrl at boot, and may modify pinctrl as
> > > part of the runtime power management firmware is put in charge of.
> > >
> > 
> > AFAIK the firmware only uses the pinctrl at boot to set the initial
> > values and the OS owns it after boot. The only interaction I know of
> > after boot are GPIO signaled events, but those are executed under the
> > control of the OS.
> > 
> > I don't understand the part about firmware being put in charge of
> > runtime power management. Do you mean that the firmware directly
> > accesses the pinctrl registers? Doesn't this contradict the ACPI goal
> > of having the OS control power management? Or do you mean accessing
> > pinctrl registers via _PSx and PowerResource._On/_Off?
> 
> I mostly mean the latter. Even if the OS is in charge of _when_ those happen,
> that only solves mutual exclusion over the pinctrl registers. That does not
> handle expectations regarding the current _state_ of the pinctrl configuation,
> or the configurations the OS/FW can permit and/or require (e.g. there's no
> refcounting between OS and FW for the state of shared pins).
> 
> It may also be that pinctrl gets altered in the background (e.g. in SMM),
> outside of the OS's control also, but that's probably a rare/extreme case.
> 
> > > The lack of any statement about pinctrl would mean that there is effectively no
> > > reasonable limitation on what firmware might do with pinctrl, and we cannot
> > > assume specific behaviour from the firmware.
> > 
> > There is noting specified in the spec about other controllers, why is
> > pinctrl special in this regard?
> 
> Because there are clear demonstrable cases why FW would want to touch pinctrl
> today, that may clash with the pinctrl model you are importing from DT (where
> the OS is assumed to have complete ownership and control over pinctrl).
> 
> The ACPI model implies FW-driven pinctrl management, so if we're going to put
> the OS in direct control of pinctrl, we have to make clear what expectation FW
> and OS can have.

Well, orthodox ACPI people from the Windows camp would definitely agree with you,
but I'm not one of them, so let me play a devil's advocate for a while. :-)

IMO, exposing anything in the ACPI tables without explicitly saying "but you
should not touch that", eg by defining an operation region covering it or similar,
is equivalent to giving the OS a license to play with that thing as it wishes.

Therefore I would regard exposing pin control information in cases when the
OS is not allowed to use it to its fit as a firmware bug.

Now, the question in this patch series is how to expose things and not when to
do that.  It adds support for a specific method of exposing information to the
OS, but should it be concerned about the possible consequences of inappropriate
use of that method by firmware?

Thanks,
Rafael

