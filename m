From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Tue, 02 Sep 2014 21:22:24 +0200
Message-ID: <2819816.9eneSBSqnQ@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eZVQL-2k1XgfFW1_QZb9G_S2d9YLo3PAH1VytvOhDnd-Q@mail.gmail.com> <CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52113 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbaIBTW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 15:22:29 -0400
In-Reply-To: <CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Brown <broonie@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tuesday 02 September 2014 14:16:42 Ashwin Chaugule wrote:
> On 28 August 2014 16:34, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> > On 28 August 2014 06:15, Mark Brown <broonie@kernel.org> wrote:
> >> On Thu, Aug 28, 2014 at 10:39:01AM +0200, Arnd Bergmann wrote:
> >>> On Wednesday 27 August 2014 20:09:02 Mark Brown wrote:
> >>
> >>> > That certainly looks like what it's doing.  Probably also make the name
> >>> > that gets passed in const while you're at it.
> >>
> >>> The mailbox API intentionally does not have an interface for
> >>> that: you are supposed to get a reference to an mbox controller
> >>> from a phandle or similar, not by knowing the name of the controller.
> >>
> >> Right, and what he's trying to work around here is that ACPI has chosen
> >> to provide a generic binding for some mailboxes which isn't associated
> >> with anything we represent as a device and he doesn't want to provide
> >> that device as a Linux virtual thing.
> >
> > Just the idea of a table as a device, when it doesn't do any power
> > management, hotplug or anything like a device seemed strange. But I'm
> > open to ideas if we find a good solution. Its highly possible that I'm
> > not seeing it the way you are because the driver subsystem internals
> > are fairly new to me. 
> >
> > Suppose we create a platform_device for the PCCT (mailbox controller)
> > and another one for the PCC client (mailbox client). How should the
> > PCC client(s) identify the mailbox controller without passing a name?
> > In DT, the "mboxes" field in the client DT entry is all strings with
> > mailbox controller names.

No, it's not a string at all, it's a phandle, which is more like a
pointer. We intentionally never match by a global string at all,
because those might not be unique.

> > The "index" in mbox_request_channel() picks
> > up one set of strings. How should this work with PCC? Should we use
> > the PCC client platform_device->dev->platform_data to store mailbox
> > controller strings?

I didn't think there was more than one PCC provider, why do you even
need a string?

For the general case in ACPI, there should be a similar way of looking
up mailbox providers to what we have in DT, but if I understand you
correctly, the PCC specification does not allow that.

Using platform_data would no be helpful, because there is no platform
code to fill that out on ACPI based systems.

> >>> Unfortunately, the three patches that Ashwin posted don't have a
> >>> caller for this function, so I don't know what it's actually used for.
> >>> Why do we need this function for pcc, and what are the names that
> >>> can be passed here?
> >>
> >> AFAICT the names he's interested in will be defined by the ACPI specs.
> >> It does seem like we should be providing a device for the controller and
> >> then either using references in ACPI to look it up if they exist or a
> >> lookup function for this particular namespace that goes and fetches the
> >> device we created and looks up in its context.
> >
> > What is the comparison in this lookup function? A string or a struct
> > device pointer? If it is the latter, how does the client get the
> > reference to the controller struct device? One way would be to
> > register the PCCT as a platform_device and the PCC client as its
> > platform_driver. But I think that will restrict the number of PCC
> > clients to who ever matches first. I suspect this is not what you're
> > implying, so I'd appreciate some more help.
> 
> I dont see a way to create a lookup table for PCC without storing the
> name of the controller somewhere. The suggestion of creating a
> platform device for the controller and client led to restricting only
> one client to the controller. Can you please suggest how to move this
> forward?

I've forgotten the details, but I thought we had already worked it
out when we discussed it the last time. What is the information available
to the client driver?

	Arnd
