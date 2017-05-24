From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
Date: Thu, 25 May 2017 01:01:45 +0200
Message-ID: <CAJZ5v0g=-LfwX1Vx6U3=HhWqfYd6m5gfpmourWbZRuCzdS+WdA@mail.gmail.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170511094551.GF30987@mail.corp.redhat.com> <1AE640813FDE7649BE1B193DEA596E886CEA2CC4@SHSMSX101.ccr.corp.intel.com>
 <2574646.jh0JF0mi0Y@aspire.rjw.lan> <20170515074553.GJ30987@mail.corp.redhat.com>
 <CAJZ5v0jJ0SruFMp+v5ibcBnzctvjZF7U1w4+XThzFjwxTpdUUQ@mail.gmail.com>
 <20170515093752.GB11762@mail.corp.redhat.com> <CAJZ5v0iD33i4B+gFvKLOnLKB557eLx1yzFCJeiR6hghD9fmKeQ@mail.gmail.com>
 <20170524080830.GE13096@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34210 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161342AbdEXXBr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 19:01:47 -0400
In-Reply-To: <20170524080830.GE13096@mail.corp.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 24, 2017 at 10:08 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Rafael,
>
> On May 15 2017 or thereabouts, Rafael J. Wysocki wrote:
>> >> >> Benjamin, my understanding is that this is the case, is it correct?
>> >> >
>> >> > That is correct. This patch I reverted introduces regression for professional
>> >> > laptops that expect the LID switch to be reported accurately.
>> >>
>> >> And from a user's perspective, what does not work any more?
>> >
>> > If you boot or resume your laptop with the lid closed on a docking
>> > station while using an external monitor connected to it, both internal
>> > and external displays will light on, while only the external should.
>> >
>> > There is a design choice in gdm to only provide the greater on the
>> > internal display when lit on, so users only see a gray area on the
>> > external monitor. Also, the cursor will not show up as it's by default
>> > on the internal display too.
>> >
>> > To "fix" that, users have to open the laptop once and close it once
>> > again to sync the state of the switch with the hardware state.
>>
>> OK
>>
>> Yeah, that sucks.
>>
>> So without the Lv's patch the behavior (on the systems in question) is
>> as expected, right?
>
> Would you agree to take both these reverts without Lv's ACK? We already
> tried to explain for 2 weeks that they are valuable, but it seems we
> can't make change his mind.

One of the reverts actually is already in (as a patch from Lv) and
I'll most probably push the other one for -rc4 next week.

Thanks,
Rafael
