From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 15 Nov 2017 18:24:02 +0100
Message-ID: <CAJZ5v0h4+f67H4tB1jjdVV+xspjbfoUs7YHfFv4J4jLXqipJsw@mail.gmail.com>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
 <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com> <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
 <CAJZ5v0i7wiFY1rPFP8eS2WXQheOwK58aKpXSkEzw+8TLDbRdPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:53412 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758136AbdKORYD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Nov 2017 12:24:03 -0500
Received: by mail-oi0-f68.google.com with SMTP id h6so16514135oia.10
        for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2017 09:24:03 -0800 (PST)
In-Reply-To: <CAJZ5v0i7wiFY1rPFP8eS2WXQheOwK58aKpXSkEzw+8TLDbRdPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Timur Tabi <timur@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>

On Wed, Nov 15, 2017 at 6:22 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Nov 15, 2017 at 4:33 PM, Timur Tabi <timur@codeaurora.org> wrote:
>> On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> I still prefer this as debugfs and not as sysfs ABI. We already have
>>> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
>>> I don't want this to end up in the same way after few years. CPUIdle
>>> sysfs should be only sysfs ABI for these, adding an alternative is
>>> inviting troubles for future especially if some user-space starts using
>>> it and we will be stuck with that. Moreover with more h/w controlled
>>> idle we may not provide accurate data sooner.
>>>
>>> Sorry for the noise, I will shup up now ;). Since this may be last
>>> chance to make some noise, I am trying it. I completely understand that
>>> this is just my opinion and am fine if others thinks it's good to make
>>> this sysfs ABI.
>>
>> Unfortunately, I think Prashanth really needs a specific requirement
>> rather than opinions.  This patch has been languishing for over a
>> month, and we still have no idea whether it will make 4.15 or if
>> Prashanth is *required* to make any more changes.
>
> No, this is not how it works.
>
> If you want *me* to apply it, which seems to be the case, I need to be
> convinced that applying it is a good idea.
>
> You haven't so far.

You haven't convinced me so far.

Thanks,
Rafael
