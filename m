From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] mailbox: pcc: fix channel calculation in get_pcc_channel()
Date: Mon, 1 Feb 2016 21:51:23 +0100
Message-ID: <CAJZ5v0h1yVsSYVz==VD3a2w8N-1yePn0XvN54c6BTwxMk7w1uw@mail.gmail.com>
References: <CAJ5Y-eYdPM+hSZdH_Sz10K6iHb0cCB1E4Wh_A_sJn_yyLgLjZQ@mail.gmail.com>
	<1454339945-30565-1-git-send-email-alexey.klimov@arm.com>
	<CABb+yY35x8UNxojMJzh-1X6UODfvABP30oVrKyzr375vZgGi_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33962 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbcBAUvY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 15:51:24 -0500
In-Reply-To: <CABb+yY35x8UNxojMJzh-1X6UODfvABP30oVrKyzr375vZgGi_w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Alexey Klimov <alexey.klimov@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 1, 2016 at 4:43 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Mon, Feb 1, 2016 at 8:49 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
>> (adding Rafael and linux-acpi)
>>
>> On Fri, Jan 15, 2016 at 6:22 PM, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>> + Jassi (Linaro addr)
>>>
>>> On 15 January 2016 at 13:20, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:

[cut]

>>>> Can you please include this patch in your pull request to Linus?
>>
>> Hi Rafael,
>>
>> any chance you can take this fix via your tree?
>> I can resend patch if you want.
>> Looks like Jassi doesn't have time or doesn't care.
>>
> Ouch... sorry. Ashwin's reminder came after I had sent the pull
> request. And then it just got overlooked. If Rafael doesn't pick it as
> my punishment, I'll tomorow :)

I can apply it, but can anyone please point me to the original patch?

Or, maybe better, resend it with a CC to linux-acpi and all of the
tags collected so far?

Thanks,
Rafael
