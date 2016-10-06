From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 17:56:27 +0200
Message-ID: <CAJZ5v0hvk=X1dmmp6SZ9wNRFUHdd4hVgQLCKJgkvYB84CBscuw@mail.gmail.com>
References: <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon> <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk> <CAJZ5v0htdbUpqZNPi00ieNJ5WWiAczK+LbKLYobNGAr3Sr+HWw@mail.gmail.com>
 <20161006152307.pqmmkazctqwlxsmy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32994 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942156AbcJFP4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 11:56:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id i130so845444wmg.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 08:56:29 -0700 (PDT)
In-Reply-To: <20161006152307.pqmmkazctqwlxsmy@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 5:23 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 06, 2016 at 03:15:36PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 6, 2016 at 12:40 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > One of my biggest concerns with this approach is that I'm really not
>> > clear to me that that this has broad buy in from the x86/ACPI community
>> > and therefore that we might end up needing to support several different
>> > styles of ACPI bindings.  Reuse would be great but it can be confusing
>> > if there's multiple different styles of bindings in use at the same
>> > time.
>
>> My view on that is a bit different.
>
>> Even if there's more than one style in use, they all can be supported
>> at the same time.  Avoiding confusion is only a matter of prioritizing
>> them, then.
>
>> It should be clear which style is the default one, which is going to
>> be taken into consideration next and so on.  If that is made clear, I
>> don't see a big problem here, at least in principle.
>
> My concern isn't just people using multiple styles, it's also people
> trying to mix and match.  Sometimes that will work well enough and it's
> fine but it can go wrong.

Yes, it can.

I'm not against being careful, but I'd rather not reject things as a
matter of principle.

>> The pinctrl thing is being dealt with (and not in a way of adding
>> pinctrl _DSD properties support to the kernel FWIW).  Other things
>> potentially conflicting with ACPI-defined HW control should be dealt
>> with analogously.
>
> Right, I was mentioning it mainly as an example of the general pattern
> of ACPI bindings springing up without coordination rather than as a
> specific problem that needs resolution.
>
>> The point here is that some things just don't conflict with
>> ACPI-defined HW control even potentially and they can be handled with
>> the help of _DSD properties just fine.  Thus, there are no technical
>> obstacles to do that, at least not in principle.
>
> It feels like we should be aiming for a higher bar with defining things
> like this than simple technical possibility - my fear is that we end up
> with a mess down the line with people being far too gung ho about
> defining new bindings without trying to work on standards.

But here we are talking about using bindings that (a) have already
been defined in DT and (b) are actively used by the existing code.

I guess you mean using existing DT bindings instead of working on
standards, but let's face it, DT bindings de facto are the standard in
some parts of the kernel.

> Perhaps I'm just worrying too much here but I'm not sure there's enough
> communication going on.  The private nature of ACPI standardization
> discussion doesn't help here of course.

Agreed, and that doesn't apply to ACPI only, of course.

Thanks,
Rafael
