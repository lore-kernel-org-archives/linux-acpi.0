From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: button: Add an info message when we're sending
 a LID closed event
Date: Wed, 22 Nov 2017 15:32:24 +0100
Message-ID: <CAJZ5v0jQfbwFitXwk0Z6dYULxrGvOcpcdfNNHgpJqNOOe3VsDA@mail.gmail.com>
References: <20171115140718.13026-1-hdegoede@redhat.com> <CAJZ5v0iHNj3XD1XWPrp_XZD+Nq-YzG665Ar+BeyCLfJEUT-nbQ@mail.gmail.com>
 <c6139108-b209-b0e6-6a65-74b09609a46b@redhat.com> <1728907.y24V3x8mmH@aspire.rjw.lan>
 <fa086b9f-9e8f-128c-b816-574b402a129b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44638 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdKVOcZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Nov 2017 09:32:25 -0500
Received: by mail-ot0-f196.google.com with SMTP id d27so13700394ote.11
        for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2017 06:32:24 -0800 (PST)
In-Reply-To: <fa086b9f-9e8f-128c-b816-574b402a129b@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Nov 22, 2017 at 8:48 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 22-11-17 01:41, Rafael J. Wysocki wrote:
>>
>> On Thursday, November 16, 2017 10:33:04 AM CET Hans de Goede wrote:
>>>
>>> Hi,
>>>
>>> On 15-11-17 18:16, Rafael J. Wysocki wrote:
>>>>
>>>> On Wed, Nov 15, 2017 at 3:07 PM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>> I've been debugging some spurious suspend issues on various devices,
>>>>> at least on some devices these spurious suspends are caused by surious
>>>>> LID closed events being send to userspace.
>>>>>
>>>>> Running e.g. evemu-record after noticing a spurious suspend is too late
>>>>> to detect that a LID closed event it the (probable) cause of this.
>>>>> This commit adds a pr_info("ACPI LID closed\n") call to help debugging.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>    drivers/acpi/button.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>>>>> index ef1856b15488..07da60fe9cae 100644
>>>>> --- a/drivers/acpi/button.c
>>>>> +++ b/drivers/acpi/button.c
>>>>> @@ -210,6 +210,9 @@ static int acpi_lid_notify_state(struct acpi_device
>>>>> *device, int state)
>>>>>           }
>>>>>           /* Send the platform triggered reliable event */
>>>>>           if (do_update) {
>>>>> +               if (!state)
>>>>> +                       pr_info("ACPI LID closed\n");
>>>>
>>>>
>>>> Why pr_info()?
>>>
>>>
>>> The purpose of the patch is to help debug spurious suspends seen on
>>> some devices (typically Intel based tablets or 2in1s) so the goal is to
>>> look at the logs after the fact and figure things out, so we want
>>> something
>>> which shows up by default (typically a lid close leads to a suspend which
>>> already causes some logging anyways), but this is not an error or a
>>> warning,
>>> so I ended up with pr_info.
>>
>>
>> This prints a useless message avery time the lid closes on *many* systems
>> that
>> don't have this problem which is a bit overly excessive IMO.
>>
>> And you can always ask bug reporters to collect logs with dynamic debug
>> enabled
>> if need be, can't you?
>
>
> Ok, I will send a v2 using pr_debug instead.

acpi_handle_debug() might be better, because it would allow you to
identify the device too.

Thanks,
Rafael
