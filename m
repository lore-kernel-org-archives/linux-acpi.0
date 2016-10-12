From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 14:26:11 +0200
Message-ID: <CAJZ5v0jBVogg_4VriMXyvc7Bv37bTiQrGs_iktR9zY7qj_bATA@mail.gmail.com>
References: <20161005092215.GA20248@red-moon> <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
 <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk> <2933991.PYcZctIsx9@vostro.rjw.lan>
 <20161012120518.4f3j67ndba2fipro@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34157 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbcJLM0O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 08:26:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id x23so1148173lfi.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2016 05:26:14 -0700 (PDT)
In-Reply-To: <20161012120518.4f3j67ndba2fipro@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 12, 2016 at 2:05 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 02:32:04AM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, October 11, 2016 02:44:29 PM Mark Brown wrote:
>> > On Tue, Oct 11, 2016 at 01:44:46AM +0200, Rafael J. Wysocki wrote:
>
>> > My primary concern is the addition of what appear to be phandles
>> > introduced as part of this patch set.  The previous discussion had been
>> > that we'd enable simple DT bindings which don't need inter-device
>> > references and that those needed more careful study.  This appears to
>> > be changing that.
>
>> Yes, it does, but why exactly do you think this is wrong?
>
>> Is there any specific problem it creates that you can point to?
>
> It means there's now nothing in the code that says that we shouldn't
> just map a DT binding with inter-device references into ACPI

Are you sure about that?

This particular series doesn't make it so general AFAICS.

> and that any future conversions just look like API usage cleanups.

But it won't actually work, will it?

AFAICS, that would have required support in subsystems and the only
one that supports kind of generic _DSD properties is the GPIO one (and
these properties are based on _CRS resources anyway FWIW).

It would require explicit changes to subsystem code to do that and
surely they can be objected to by the respective maintainers of those
(including you).  IOW, for example, any patch attempting to change
of_* into device_property_* in the regulator subsystem will be highly
suspicious and objectionable, won't it?

>> > The way ARM implements this is that you don't get the DT and ACPI
>> > simultaneously, they're both present in the firmware and the OS picks
>> > which one it wants to use at runtime.
>
>> So for the boards I'm talking about ACPI is the only realistic choice.
>
> There shouldn't be any technical limiation here.

The limitation is the information necessary to implement low-level
support of things in there which is not and may never be available.

Thanks,
Rafael
