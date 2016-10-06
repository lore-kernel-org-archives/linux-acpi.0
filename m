From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 15:15:36 +0200
Message-ID: <CAJZ5v0htdbUpqZNPi00ieNJ5WWiAczK+LbKLYobNGAr3Sr+HWw@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon> <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <20161006091133.GF30800@lahna.fi.intel.com> <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36308 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbcJFNPj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 09:15:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id 123so3488044wmb.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 06:15:38 -0700 (PDT)
In-Reply-To: <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 12:40 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 06, 2016 at 12:11:33PM +0300, Mika Westerberg wrote:
>
>> One reason is that we have boards like Joule where developers are
>> allowed to connect different peripherals using buses such as I2C and SPI
>> where there is no native enumeration mechanism. This includes camera
>> sensors and related so there needs to be a way for a developer to
>> describe this in ACPI. Just as can be done when using ARM and DT.
>
> One of my biggest concerns with this approach is that I'm really not
> clear to me that that this has broad buy in from the x86/ACPI community
> and therefore that we might end up needing to support several different
> styles of ACPI bindings.  Reuse would be great but it can be confusing
> if there's multiple different styles of bindings in use at the same
> time.

My view on that is a bit different.

Even if there's more than one style in use, they all can be supported
at the same time.  Avoiding confusion is only a matter of prioritizing
them, then.

It should be clear which style is the default one, which is going to
be taken into consideration next and so on.  If that is made clear, I
don't see a big problem here, at least in principle.

> The audio systems that have this issue (which include production laptops
> and tablets with both Windows and ChromeOS) don't seem to be showing
> much interest in reusing any of the DT work beyond the device level
> properties and I didn't think the OS level support for using _DSD in
> Windows was great.  There were also the pinctrl bindings which had some
> issues too.

The pinctrl thing is being dealt with (and not in a way of adding
pinctrl _DSD properties support to the kernel FWIW).  Other things
potentially conflicting with ACPI-defined HW control should be dealt
with analogously.

The point here is that some things just don't conflict with
ACPI-defined HW control even potentially and they can be handled with
the help of _DSD properties just fine.  Thus, there are no technical
obstacles to do that, at least not in principle.

Thanks,
Rafael
