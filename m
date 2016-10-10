From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 01:44:46 +0200
Message-ID: <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon> <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34925 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbcJJX6Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Oct 2016 19:58:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id x79so776349lff.2
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2016 16:58:23 -0700 (PDT)
In-Reply-To: <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 11:37 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 06, 2016 at 02:26:50PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 6, 2016 at 10:57 AM, Lorenzo Pieralisi
>
>> > I am trying to understand why x86 wants to do this, please understand
>> > our point of view too, we do not want to block progress we want to
>> > prevent a mess.
>
>> It is not "x86" who wants to do that.
>
>> It is people who work on support for boards with ACPI firmware and
>> containing devices that in Linux are handled by DT-centric code.
>
> Yes, it's important to remember that there's a whole world of other
> people using ACPI on x86 who are doing different things.  I have to say
> I'm not sure how DT centric we really are, there's a lot of things that
> have been around since before DT.

When I said "DT-centric" I really meant "full of of_* calls retrieving
data from a DT".

>> Of course, the reason why that code is DT-centric is because it was
>> developed on systems using DT and there were no uses on ACPI-based
>> systems for it back then.  Still, it is DT-centric as a matter of fact
>> and *something* has to be done in order to make it work with ACPI.
>
> Personally I don't have that big a concern around per device
> properties other than the need to go through yet another round of
> churn for them (though it is just mechanical which will make it less
> painful).  I do worry when it goes to generic things and inter-device
> relationships.

Well, that was my first reaction to this series, but then I thought
"Let's see what can go wrong with this specifically" and then I
couldn't find anything.

If you see something like that, please let me know, because I may be
overlooking it, but otherwise I would prefer to focus on the technical
side of things instead of wast^Hspending time on theoretical worries.

>> And it is not an option for those boards to use DT in the firmware.
>
> There's nothing stopping these systems defining a DSD that contains a
> DTB which overrides some or all of the ACPI if the system supports it
> (or otherwise providing both system descriptions).  The two can coexist
> happily enough as arm64 has shown

I'm not sure to what extent it has shown that and even so, it doesn't
mean this is a good idea.

> and it seems like it ought to save a
> whole lot of work especially around the bits that need inter device
> links and are hence need some new ACPI bindings defining.

There is at least one major problem with this approach.  If the ACPI
part needs to point to anything in the DTB or if the DTB part needs to
point to the ACPI part outside of it, there's no clean way that could
be done.  I actually am not aware of any way whatever, but if there
are some, I kind of don't expect them to be pretty.

> I can see that removing ACPI entirely would present serious difficulties
> but it's less clear to me how much is really gained by having an
> embedded Linux specific ACPI variant over having some Linux specific
> data in ACPI that happens to be parsable as DT.  The circumstances that
> the two platforms face appear to be very similar.

I'm not really sure what you mean here.

_DSD properties can convey the same information as DT in the same
layout.  The only difference is that DT uses phandles to point to
things and _DSD properties use ACPI namespace paths for this purpose.
That actually is where code changes need to be made, the rest is
already there.

Thanks,
Rafael
