From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 14:30:27 +0200
Message-ID: <CAJZ5v0gK8oeGfk+ohUCkQY=Ze+1gCLMpaZJeZ7SUtoxhu=d2ew@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon> <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <20161006091133.GF30800@lahna.fi.intel.com> <20161006095739.GA22984@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754590AbcJFMa3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 08:30:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so3310600wmb.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 05:30:29 -0700 (PDT)
In-Reply-To: <20161006095739.GA22984@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 11:57 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Oct 06, 2016 at 12:11:33PM +0300, Mika Westerberg wrote:
>> On Thu, Oct 06, 2016 at 09:57:03AM +0100, Lorenzo Pieralisi wrote:
>> > I am trying to understand why x86 wants to do this, please understand
>> > our point of view too, we do not want to block progress we want to
>> > prevent a mess.
>>
>> One reason is that we have boards like Joule where developers are
>> allowed to connect different peripherals using buses such as I2C and SPI
>> where there is no native enumeration mechanism. This includes camera
>> sensors and related so there needs to be a way for a developer to
>> describe this in ACPI. Just as can be done when using ARM and DT.
>
> I am sorry I think we are at loggerheads on this. If you need a DT boot
> with a DT, I could have converted all the ACPI tables to DT nodes on
> ARM64 if I followed your reasoning (because we could not boot with ACPI
> till relatively recently), we did not do it because ACPI and DT are
> different specifications, incompatible with one another and governed by
> different entities in a *very* different way.

You are talking about core code and Mika is talking about device drivers.

As far as the core code is concerned, I agree with you.  As far as
device drivers are concerned, I agree with Mika.

You are both right. :-)

Thanks,
Rafael
