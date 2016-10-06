From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 11:29:05 +0100
Message-ID: <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
 <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754686AbcJFK3K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 06:29:10 -0400
In-Reply-To: <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>



On 05/10/16 21:18, Rafael J. Wysocki wrote:
> On Wed, Oct 5, 2016 at 5:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>

[...]

>> Does this also mean if there's some new bindings added to DT which ACPI
>> specification still lacks, then instead of enhancing ACPI specification
>> adding that to it, we can take a shortcut method of PRP0001 and
>> completely ignore ACPI.
>
> No.
>

I know that the intentions of this series is not that, but my question
is more how can we prevent that misuse.

>> People are trying to do that as it's simple and faster.
>
> The answer is really very simple: You need to build on top of what is
> defined in ACPI already instead of trying to replace it.
>

No doubt about that, though controlling it is another question.
Especially ARM vendors who have some driver for DT might just use this
method without anyone noticing, ignoring the ACPI method as everything
just works out of box. That's the main worry. Also it also provides no
incentive for them to work with ASWG to enhance ACPI specification.

> So if your properties duplicate ACPI-defined ways of doing things or
> would be in a direct conflict with them, they cannot be supported by
> the mainline kernel as far as I'm concerned.
>

Agreed.

> If, OTOH, they are defined such that they will extend the information
> that can be provided by ACPI natively, I don't see a reason to reject
> the concept as a matter of principle.
>

While I agree conceptually, it confuses(again ARM vendors who are new to
ACPI) as when to use this method vs adding something to the ACPI
specification. They might just start to use this for all, again as it
just works with minimal or no kernel change.

>> And yes this has been raised multiple times in past, but worth raising
>> every-time we head in that direction. And it's increasing day-by-day
>> which is alarming.
>>
>> Even though you may say no to that, it absolutely prevents no one
>> to do so unless we control what bindings can be support using DSD.
>
> First of all, that's totally unrealistic.  You can't prevent anyone
> from using whatever properties they want in practice.  You can only
> (try to) block the mainline kernel from supporting those properties,
> but the question here is why.
>

Agreed, but just afraid that it may become a de-facto standard as long
as things can be made to work.

> The whole exercise with _DSD properties is all about code reuse.
>

Sure. On the side note, we should at-least have PRP0001 reserved
officially in the ACPI specification, I still see no mention about that
in the spec and both firmware and Linux are using it for a while now.

> There is a metric ton of DT-centric code already in the kernel that is
> well understood and tested and it would be plain unreasonable to try
> to reinvent the wheel and (a) invent ACPI-specific ways of doing the
> same thing for every use case that is distinct enough and (b) write
> code using those ACPI-specific ways instead of already defined
> properties just in order to handle the same hardware in the same OS.
> [If you have to support different OSes, this is a different matter.]
>

Agreed, but as you mentioned the question of different OS remains.

> If you are saying "no DT properties in _DSD", this implies that code
> reuse is bad for some unspecified reason.  It is very difficult to me
> to agree with that position.
>

No, I am not saying no. I am just worried where do we stop this and how
do we prevent ARM vendors exploiting this, and not rather contributing
to the ACPI specification enhancement.

-- 
Regards,
Sudeep
