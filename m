From: Al Stone <ahs3@redhat.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 11:20:49 -0600
Message-ID: <590ed0a0-544d-a320-e6e0-ce1ab89d485e@redhat.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
 <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com>
 <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37762 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942018AbcJFRUw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 13:20:52 -0400
Received: by mail-it0-f43.google.com with SMTP id j69so36292473itb.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 10:20:51 -0700 (PDT)
In-Reply-To: <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>

On 10/06/2016 08:20 AM, Sudeep Holla wrote:
> 
> 
> On 06/10/16 14:04, Rafael J. Wysocki wrote:
>> On Thu, Oct 6, 2016 at 12:29 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> [...]
> 
>>> No doubt about that, though controlling it is another question.
>>> Especially ARM vendors who have some driver for DT might just use this
>>> method without anyone noticing, ignoring the ACPI method as everything
>>> just works out of box. That's the main worry. Also it also provides no
>>> incentive for them to work with ASWG to enhance ACPI specification.
>>
>> They will need to hack the kernel to do that, because the mainline
>> will not support anything like regulator or pinctrl support based on
>> DT properties, at least as long as I have any influence on that.
>>
> 
> OK, that's good.
> 
>> And if they need to hack the kernel anyway, nothing prevents them from
>> hacking it to support whatever properties they like even if we don't
>> put any support for any generic _DSD properties into the mainline.
>> That's why the whole "oh but this allows ARM vendors to abuse things"
>> argument doesn't hold any water in my view.
>>
> 
> While I agree with you, the argument which will be done and will win
> most of the time to upstream something is that "we have shipped the
> product with that table, we need to support it upstream...". I don't
> think even you disagree with that ;)
> 
>> Yes, it may make it a bit easier for them to abuse things (as they
>> don't have to hack the kernel to support properties already supported
>> by it), but OTOH it sort of avoids the problem that multiple vendors
>> could hack the kernel in different and possibly incompatible ways to
>> make it support the same set of properties they all need.
>>
> 
> Pity, but still better :)
> 
>>> Sure. On the side note, we should at-least have PRP0001 reserved
>>> officially in the ACPI specification, I still see no mention about that
>>> in the spec and both firmware and Linux are using it for a while now.
>>
>> The whole PRPxxxx range of device IDs is reserved.
>>
> 
> Good, sorry I couldn't spot anything in ACPIv6.1 or uefi.org apart from
> dsd mailing list.
> 
>>>> There is a metric ton of DT-centric code already in the kernel that is
>>>> well understood and tested and it would be plain unreasonable to try
>>>> to reinvent the wheel and (a) invent ACPI-specific ways of doing the
>>>> same thing for every use case that is distinct enough and (b) write
>>>> code using those ACPI-specific ways instead of already defined
>>>> properties just in order to handle the same hardware in the same OS.
>>>> [If you have to support different OSes, this is a different matter.]
>>>>
>>>
>>> Agreed, but as you mentioned the question of different OS remains.
>>>
>>>> If you are saying "no DT properties in _DSD", this implies that code
>>>> reuse is bad for some unspecified reason.  It is very difficult to me
>>>> to agree with that position.
>>>>
>>>
>>> No, I am not saying no. I am just worried where do we stop this and how
>>> do we prevent ARM vendors exploiting this, and not rather contributing
>>> to the ACPI specification enhancement.
>>
>> The ACPI spec may not be the right place to define support for things
>> this series is about, though.  Ideally, they should be defined by
>> other standards using ASL as a form of expression or representation,
>> if you will.
>>
> 
> Yes, that would be ideal.
> 
>> And that still needs to happen for different OSes to be able to use
>> the ACPI tables in the same way (which doesn't even happen for
>> different versions of Windows, but that's a different matter).
>>
>> However, adding support for additional _DSD properties to the mainline
>> kernel need not prevent a standardization process like this from
>> happening.  The point is that this process will take time and both the
>> HW and the code in the kernel supporting it are available today.  The
>> only problem is that the code is DT-centric and there are ACPI tables
>> in the boards in question.
>>
>> If/when the new standard comes along, we will support it by default
>> and then fall back to _DSD properties if information defined by it is
>> not available.  Pretty much the same way as we fall back to
>> driver-supplied data if we can get information we need from the
>> platform firmware.
>>
> 
> Yes that's much better.
> 

So where does this leave us?  What I take away from the discussion is this:

   a) each use of _DSD device properties in the kernel is to be evaluated on a
      case-by-case basis.  Therefore, Rafael and/or driver maintainers have the
      final say on acceptance in the Linux kernel.

   b) if it makes sense to generalize a property and update the ACPI spec
      instead of using _DSD device properties, that's the preferred path.

   c) if a _DSD device property is doing something that can and should be
      described in ACPI, do it in ACPI, not with a device property.

   d) re-use of DT bindings is an acceptable use for _DSD device properties,
      unless they contradict (b) or (c).

   e) Windows and Linux are already diverging in their use of _DSD.

Did I misunderstand anything?

If I didn't, then it seems a mechanism external to the Linux kernel to document
device properties is completely redundant, especially given item (e) -- they
will either be documented in DT, or documented by the driver.  And if that's the
case, then the dsd@acpica.org mailing list is irrelevant, or what's worse, makes
for duplicated work, and should just go away.

I'm fine with that, if that's what we're saying (it's less for me to do :), but
let's say it explicitly instead of re-hashing it every time _DSD is used.  The
above list is nice and simple and personally I'd rather have simple than a full
blown registration process.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
