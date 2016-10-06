From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 19:05:51 +0200
Message-ID: <CAJZ5v0g3MCBXXOn_txBE4E1-rjjwyXDu=wq=oD7xgXy=rhpm0w@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com> <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com> <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32780 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932260AbcJFRFy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 13:05:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id i130so1108705wmg.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 10:05:53 -0700 (PDT)
In-Reply-To: <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 4:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 06/10/16 14:04, Rafael J. Wysocki wrote:
>>
>> On Thu, Oct 6, 2016 at 12:29 PM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>
>
> [...]
>
>>> No doubt about that, though controlling it is another question.
>>> Especially ARM vendors who have some driver for DT might just use this
>>> method without anyone noticing, ignoring the ACPI method as everything
>>> just works out of box. That's the main worry. Also it also provides no
>>> incentive for them to work with ASWG to enhance ACPI specification.
>>
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

Well, maybe they should have talked to the upstream before shipping
the product with that table?  Failing to do so is like jumping to a
pool from a tower without checking how much water is there in it in
the first place ...

Thanks,
Rafael
