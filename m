From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI : Update platform device numa node based on _PXM method
Date: Wed, 29 Mar 2017 12:24:42 +0200
Message-ID: <CAJZ5v0hSDE_b8FKBoLAkts5Tn1QQryGZbqP2zUpJA-bAKqeqZg@mail.gmail.com>
References: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org>
 <1932728.uFK6bUjlgv@aspire.rjw.lan> <6b298342-2746-f6d5-0b0e-67c20fd4c002@codeaurora.org>
 <13204058.j7zPSh58G6@aspire.rjw.lan> <18560c7a-c9c5-1cf1-2e74-cf28c3a16b97@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35179 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbdC2KYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 06:24:44 -0400
In-Reply-To: <18560c7a-c9c5-1cf1-2e74-cf28c3a16b97@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shankerd@codeaurora.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vikram Sethi <vikrams@codeaurora.org>

On Wed, Mar 29, 2017 at 12:51 AM, Shanker Donthineni
<shankerd@codeaurora.org> wrote:
> Hi Rafael,
>
>
> On 03/28/2017 05:15 PM, Rafael J. Wysocki wrote:
>> On Tuesday, March 28, 2017 05:14:13 PM Shanker Donthineni wrote:
>>> Hi Rafael,
>>>
>>>
>>> On 03/28/2017 04:43 PM, Rafael J. Wysocki wrote:
>>>> On Tuesday, March 21, 2017 09:54:30 AM Shanker Donthineni wrote:
>>>>> The optional _PXM method evaluates to an integer that identifies the
>>>>> proximity domain of a device object. This patch implements support for
>>>>> ACPI _PXM method and updates the platform device numa node id using
>>>>> acpi_get_node(), which provides the PXM to NUMA mapping information.
>>>>>
>>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> What exactly is the motivation here?
>>> We have a couple of platform devices some of them are attached
>>> to socket0 and others to a different socket. We would like to covert
>>> memory allocations in Qualcomm platform device drivers to a NUMA
>>> aware allocation to improve performance.
>> All of the above information should be there in the patch changelog and
>> presumably the patch should be a part of a larger series so the way this
>> feature is going to be used is more clear.
>
> Sorry, I didn't quite get what's larger series? I'm happy to include above information in
> commit/changelog text. We are trying to allocate memory using standard  function
> devm_kmalloc() but the function is always allocating memory from NUMA node 0.
> The inline function dev_to_node(dev) always returns -1 on our system even though
> we are setting PXM method in ACPI DSDT to non-zero value.

OK

So please add the above to the patch changelog too.

Thanks,
Rafael
