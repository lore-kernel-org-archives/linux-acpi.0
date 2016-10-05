From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 22:18:58 +0200
Message-ID: <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com> <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33391 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbcJEUTA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2016 16:19:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id p138so338037wmb.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Oct 2016 13:18:59 -0700 (PDT)
In-Reply-To: <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 5, 2016 at 5:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 05/10/16 12:41, Mika Westerberg wrote:
>>
>> On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
>>>
>>> [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
>>>
>>> On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
>>>>
>>>> Hello everyone,
>>>>
>>>> I've been working awhile with my collegue Mika Westerberg to bring
>>>> firmware graph support to ACPI based systems. In practice the
>>>> functionality achieved by these patches is very similar to what the
>>>> Device
>>>> tree provides: the port and the endpoint concept are being employed. The
>>>> patches make use of the _DSD property and data extensions to achieve
>>>> this.
>>>> The fwnode interface is extended by graph functionality; this way graph
>>>> information originating from both OF and ACPI may be accessed using the
>>>> same interface.
>>>
>>>
>>> There is an ongoing effort to avoid wholesale import of DT bindings
>>> into ACPI, I am not a V4L2 expert but it seems to me that with patches
>>> like the one you have submitted we are getting closer and closer to
>>> achieving it instead of avoiding it.
>>
>>
>> The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
>> ACPI systems, so that the drivers can just call device_property_* and
>> get the properties regardless of the underlying firmware interface.
>>
>
> Does this also mean if there's some new bindings added to DT which ACPI
> specification still lacks, then instead of enhancing ACPI specification
> adding that to it, we can take a shortcut method of PRP0001 and
> completely ignore ACPI.

No.

> People are trying to do that as it's simple and faster.

The answer is really very simple: You need to build on top of what is
defined in ACPI already instead of trying to replace it.

So if your properties duplicate ACPI-defined ways of doing things or
would be in a direct conflict with them, they cannot be supported by
the mainline kernel as far as I'm concerned.

If, OTOH, they are defined such that they will extend the information
that can be provided by ACPI natively, I don't see a reason to reject
the concept as a matter of principle.

> And yes this has been raised multiple times in past, but worth raising
> every-time we head in that direction. And it's increasing day-by-day
> which is alarming.
>
> Even though you may say no to that, it absolutely prevents no one
> to do so unless we control what bindings can be support using DSD.

First of all, that's totally unrealistic.  You can't prevent anyone
from using whatever properties they want in practice.  You can only
(try to) block the mainline kernel from supporting those properties,
but the question here is why.

The whole exercise with _DSD properties is all about code reuse.

There is a metric ton of DT-centric code already in the kernel that is
well understood and tested and it would be plain unreasonable to try
to reinvent the wheel and (a) invent ACPI-specific ways of doing the
same thing for every use case that is distinct enough and (b) write
code using those ACPI-specific ways instead of already defined
properties just in order to handle the same hardware in the same OS.
[If you have to support different OSes, this is a different matter.]

If you are saying "no DT properties in _DSD", this implies that code
reuse is bad for some unspecified reason.  It is very difficult to me
to agree with that position.

Thanks,
Rafael
